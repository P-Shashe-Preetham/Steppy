package com.steppy.app.ui.screens.reward

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.steppy.app.data.model.Reward
import com.steppy.app.viewmodel.auth.AuthViewModel
import com.steppy.app.viewmodel.reward.RewardViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RewardStoreScreen(
    viewModel: RewardViewModel = hiltViewModel(),
    authViewModel: AuthViewModel = hiltViewModel()
) {
    val rewards by viewModel.rewards.collectAsState()
    val currentUser by authViewModel.currentUser.collectAsState()

    Scaffold(
        topBar = { TopAppBar(title = { Text("Reward Store") }) }
    ) { innerPadding ->
        Column(modifier = Modifier.padding(innerPadding).padding(16.dp)) {
            Text("Your Coins: ${currentUser?.coins ?: 0}", style = MaterialTheme.typography.titleLarge)
            Spacer(modifier = Modifier.height(16.dp))
            
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(rewards) { reward ->
                    RewardItem(
                        reward = reward,
                        canAfford = (currentUser?.coins ?: 0) >= reward.cost,
                        onRedeem = { 
                            currentUser?.let { user ->
                                viewModel.redeemReward(user.id, reward) { /* handle result */ }
                            }
                        }
                    )
                }
            }
        }
    }
}

@Composable
fun RewardItem(reward: Reward, canAfford: Boolean, onRedeem: () -> Unit) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(reward.name, style = MaterialTheme.typography.titleMedium)
            Text(reward.description, style = MaterialTheme.typography.bodySmall)
            Spacer(modifier = Modifier.height(8.dp))
            Text("${reward.cost} Coins", style = MaterialTheme.typography.labelLarge, color = MaterialTheme.colorScheme.primary)
            Spacer(modifier = Modifier.height(8.dp))
            Button(
                onClick = onRedeem,
                enabled = canAfford,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Redeem")
            }
        }
    }
}
