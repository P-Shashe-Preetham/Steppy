package com.steppy.app.viewmodel.analytics

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.steppy.app.data.health.HealthConnectManager
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import java.time.Instant
import javax.inject.Inject

@HiltViewModel
class AnalyticsViewModel @Inject constructor(
    private val healthConnectManager: HealthConnectManager
) : ViewModel() {

    private val _weeklyHistory = MutableStateFlow<List<Pair<Instant, Long>>>(emptyList())
    val weeklyHistory: StateFlow<List<Pair<Instant, Long>>> = _weeklyHistory

    init {
        fetchHistory()
    }

    fun fetchHistory() {
        viewModelScope.launch {
            _weeklyHistory.value = healthConnectManager.readWeeklySteps()
        }
    }
}
