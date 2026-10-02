package com.steppy.app.ui.screens.challenge

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PersonAdd
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import com.steppy.app.data.model.Participant
import com.steppy.app.viewmodel.auth.AuthViewModel
import com.steppy.app.viewmodel.challenge.ChallengeDetailViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ChallengeDetailScreen(
    onBack: () -> Unit,
    onNavigateToInvite: (String) -> Unit,
    viewModel: ChallengeDetailViewModel = hiltViewModel(),
    authViewModel: AuthViewModel = hiltViewModel(),
) {
    val challenge by viewModel.challenge.collectAsState()
    val participants by viewModel.participants.collectAsState()
    val currentUser by authViewModel.currentUser.collectAsState()

    val isParticipant = participants.any { it.userId == currentUser?.id }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(challenge?.name ?: "Challenge Detail") },
                navigationIcon = {
                    TextButton(onClick = onBack) { Text("Back") }
                },
                actions = {
                    if (challenge?.creatorId == currentUser?.id) {
                        IconButton(onClick = { challenge?.let { onNavigateToInvite(it.id) } }) {
                            Icon(Icons.Default.PersonAdd, contentDescription = "Invite")
                        }
                    }
                }
            )
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(16.dp)
        ) {
            challenge?.let { ch ->
                Text(ch.description, style = MaterialTheme.typography.bodyLarge)
                Spacer(modifier = Modifier.height(8.dp))
                Text("Goal: ${ch.stepGoal} steps", fontWeight = FontWeight.Bold)
                
                if (!isParticipant) {
                    Spacer(modifier = Modifier.height(16.dp))
                    Button(
                        onClick = {
                            currentUser?.let { user ->
                                viewModel.joinChallenge(user.id, user.username, user.profileImageUrl)
                            }
                        },
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Text("Join Challenge")
                    }
                }
            }

            Spacer(modifier = Modifier.height(24.dp))
            Text("Leaderboard", style = MaterialTheme.typography.headlineSmall)
            Spacer(modifier = Modifier.height(8.dp))

            LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                itemsIndexed(participants) { index, participant ->
                    LeaderboardItem(
                        rank = index + 1,
                        participant = participant,
                        isCurrentUser = participant.userId == currentUser?.id
                    )
                }
            }
        }
    }
}

@Composable
fun LeaderboardItem(rank: Int, participant: Participant, isCurrentUser: Boolean) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = if (isCurrentUser) MaterialTheme.colorScheme.primaryContainer else MaterialTheme.colorScheme.surfaceVariant
        )
    ) {
        Row(
            modifier = Modifier.padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "#$rank",
                style = MaterialTheme.typography.titleMedium,
                modifier = Modifier.width(40.dp)
            )
            Column(modifier = Modifier.weight(1f)) {
                Text(participant.username, fontWeight = FontWeight.Bold)
                Text("${participant.steps} steps", style = MaterialTheme.typography.bodySmall)
            }
            if (isCurrentUser) {
                Badge(containerColor = MaterialTheme.colorScheme.primary) {
                    Text("You", color = Color.White)
                }
            }
        }
    }
}
