package com.gymcoach.gym_coach.feature.path

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.EmojiEvents
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.gymcoach.gym_coach.theme.AppColors
import com.gymcoach.gym_coach.theme.AppMascot
import com.gymcoach.gym_coach.theme.MascotMood
import java.time.LocalDate

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PathScreen(vm: PathViewModel = hiltViewModel()) {
    val tasks by vm.state.collectAsState()
    LaunchedEffect(Unit) { vm.load() }
    Scaffold(
        containerColor = AppColors.duoBackground,
        topBar = {
            TopAppBar(
                title = { Text("我的路径") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppColors.duoPurple,
                    titleContentColor = Color.White
                )
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp, vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(tasks.size) { idx ->
                val task = tasks[idx]
                val isToday = task.date == LocalDate.now()
                val completed = task.completedWorkout
                val milestone = (idx + 1) % 28 == 0
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(
                        modifier = Modifier
                            .size(28.dp)
                            .clip(CircleShape)
                            .background(
                                if (isToday) AppColors.duoGold
                                else if (completed) AppColors.duoGreen
                                else AppColors.duoGray
                            )
                            .border(2.dp, AppColors.duoBlack, CircleShape),
                        contentAlignment = Alignment.Center
                    ) {
                        if (milestone) {
                            Icon(Icons.Filled.EmojiEvents, contentDescription = "milestone", tint = AppColors.duoBlack)
                        } else {
                            Text(text = "${idx + 1}", style = MaterialTheme.typography.bodyMedium)
                        }
                    }
                    Spacer(Modifier.width(12.dp))
                    Text(
                        text = task.workout?.title ?: "休息日",
                        fontWeight = if (isToday) FontWeight.ExtraBold else FontWeight.Normal,
                        modifier = Modifier.weight(1f)
                    )
                    if (isToday) AppMascot(sizeDp = 32, mood = MascotMood.Cheer)
                }
            }
        }
    }
}
