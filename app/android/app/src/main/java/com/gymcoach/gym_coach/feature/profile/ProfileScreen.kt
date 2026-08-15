package com.gymcoach.gym_coach.feature.profile

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.gymcoach.gym_coach.theme.AppColors
import com.gymcoach.gym_coach.theme.AppMascot
import com.gymcoach.gym_coach.theme.MascotMood

@OptIn(ExperimentalMaterial3Api::class, androidx.compose.foundation.layout.ExperimentalLayoutApi::class)
@Composable
fun ProfileScreen(vm: ProfileViewModel = hiltViewModel()) {
    val s by vm.state.collectAsState()
    LaunchedEffect(Unit) { vm.load() }
    Scaffold(
        containerColor = AppColors.duoBackground,
        topBar = {
            TopAppBar(
                title = { Text("我") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppColors.duoGold,
                    titleContentColor = AppColors.duoBlack
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            horizontalAlignment = androidx.compose.ui.Alignment.CenterHorizontally
        ) {
            AppMascot(sizeDp = 120, mood = MascotMood.Happy)
            Card(modifier = Modifier.fillMaxWidth()) {
                Column(Modifier.padding(16.dp)) {
                    Text("🔥 ${s.streak.currentDays} 天 streak", style = MaterialTheme.typography.titleLarge)
                    Text("最长 ${s.streak.longestDays} 天")
                    Text("冻结 ${s.streak.freezesRemaining} 次")
                }
            }
            Card(modifier = Modifier.fillMaxWidth()) {
                Column(Modifier.padding(16.dp)) {
                    Text("Lv. ${s.level}", style = MaterialTheme.typography.headlineSmall)
                    Spacer(Modifier.height(4.dp))
                    Text("${s.xpToNext} XP 升下一级")
                    Spacer(Modifier.height(8.dp))
                    LinearProgressIndicator(
                        progress = { 1f - (s.xpToNext.toFloat() / 1000f) },
                        modifier = Modifier.fillMaxWidth(),
                        color = AppColors.duoGreen,
                        trackColor = AppColors.duoGray
                    )
                }
            }
            Card(modifier = Modifier.fillMaxWidth()) {
                Column(Modifier.padding(16.dp)) {
                    Text("徽章", style = MaterialTheme.typography.titleLarge)
                    Spacer(Modifier.height(8.dp))
                    FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        s.unlockedBadges.forEach { code ->
                            androidx.compose.material3.SuggestionChip(
                                onClick = {},
                                label = { Text(code) }
                            )
                        }
                    }
                }
            }
        }
    }
}
