package com.steppy.app.viewmodel.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.steppy.app.data.health.HealthConnectManager
import com.steppy.app.data.repository.AuthRepository
import com.steppy.app.data.repository.ChallengeRepository
import com.steppy.app.domain.usecase.GamificationUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val healthConnectManager: HealthConnectManager,
    private val challengeRepository: ChallengeRepository,
    private val authRepository: AuthRepository,
    private val gamificationUseCase: GamificationUseCase
) : ViewModel() {

    private val _todaySteps = MutableStateFlow(0L)
    val todaySteps: StateFlow<Long> = _todaySteps

    private val _dailyGoal = MutableStateFlow(10000L)
    val dailyGoal: StateFlow<Long> = _dailyGoal

    private val _isRefreshing = MutableStateFlow(false)
    val isRefreshing: StateFlow<Boolean> = _isRefreshing

    init {
        refreshSteps()
    }

    fun refreshSteps() {
        viewModelScope.launch {
            _isRefreshing.value = true
            val steps = healthConnectManager.readTodaySteps()
            _todaySteps.value = steps
            
            // Sync steps to active challenges
            val currentUser = authRepository.currentUser.first()
            if (currentUser != null) {
                // Update User XP and Level
                val newXP = gamificationUseCase.calculateXP(steps)
                val newLevel = gamificationUseCase.getLevel(newXP)
                val newBadgeIds = gamificationUseCase.checkNewBadges(currentUser, steps)
                
                authRepository.updateUserStats(steps, newXP, newLevel, newBadgeIds)

                // Fetch all challenges the user is in and update steps
                challengeRepository.getChallenges().first().forEach { challenge ->
                    if (currentUser.id in challenge.participantIds) {
                        challengeRepository.updateParticipantSteps(challenge.id, currentUser.id, steps)
                    }
                }
            }
            
            _isRefreshing.value = false
        }
    }
}
