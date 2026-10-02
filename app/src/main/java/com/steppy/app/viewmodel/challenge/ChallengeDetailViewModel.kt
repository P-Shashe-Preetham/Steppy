package com.steppy.app.viewmodel.challenge

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.steppy.app.data.model.Challenge
import com.steppy.app.data.model.Participant
import com.steppy.app.data.repository.ChallengeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ChallengeDetailViewModel @Inject constructor(
    private val challengeRepository: ChallengeRepository,
    savedStateHandle: SavedStateHandle
) : ViewModel() {

    private val challengeId: String = checkNotNull(savedStateHandle["challengeId"])

    val challenge: StateFlow<Challenge?> = challengeRepository.getChallenge(challengeId)
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), null)

    val participants: StateFlow<List<Participant>> = challengeRepository.getParticipants(challengeId)
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())

    fun joinChallenge(userId: String, username: String, profileImageUrl: String) {
        viewModelScope.launch {
            challengeRepository.joinChallenge(challengeId, userId, username, profileImageUrl)
        }
    }
    
    fun updateSteps(userId: String, steps: Long) {
        viewModelScope.launch {
            challengeRepository.updateParticipantSteps(challengeId, userId, steps)
        }
    }
}
