package com.steppy.app.viewmodel.reward

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.steppy.app.data.model.Reward
import com.steppy.app.data.repository.RewardRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class RewardViewModel @Inject constructor(
    private val rewardRepository: RewardRepository
) : ViewModel() {

    val rewards: StateFlow<List<Reward>> = rewardRepository.getRewards()
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())

    fun redeemReward(userId: String, reward: Reward, onResult: (Result<Unit>) -> Unit) {
        viewModelScope.launch {
            onResult(rewardRepository.redeemReward(userId, reward))
        }
    }
}
