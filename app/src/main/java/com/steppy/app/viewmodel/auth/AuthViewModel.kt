package com.steppy.app.viewmodel.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.steppy.app.data.model.User
import com.steppy.app.data.repository.AuthRepository
import com.google.firebase.messaging.FirebaseMessaging
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val authRepository: AuthRepository,
    private val firebaseMessaging: FirebaseMessaging
) : ViewModel() {

    val currentUser: StateFlow<User?> = authRepository.currentUser
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), null)

    init {
        viewModelScope.launch {
            currentUser.collect { user ->
                if (user != null) {
                    firebaseMessaging.token.addOnCompleteListener { task ->
                        if (task.isSuccessful) {
                            updateFcmToken(task.result)
                        }
                    }
                }
            }
        }
    }

    fun signUp(email: String, password: String, username: String, onResult: (Result<Unit>) -> Unit) {
        viewModelScope.launch {
            onResult(authRepository.signUp(email, password, username))
        }
    }

    fun signIn(email: String, password: String, onResult: (Result<Unit>) -> Unit) {
        viewModelScope.launch {
            onResult(authRepository.signIn(email, password))
        }
    }

    fun signOut() {
        viewModelScope.launch {
            authRepository.signOut()
        }
    }

    fun resetPassword(email: String, onResult: (Result<Unit>) -> Unit) {
        viewModelScope.launch {
            onResult(authRepository.resetPassword(email))
        }
    }

    private fun updateFcmToken(token: String) {
        viewModelScope.launch {
            authRepository.updateFcmToken(token)
        }
    }
}
