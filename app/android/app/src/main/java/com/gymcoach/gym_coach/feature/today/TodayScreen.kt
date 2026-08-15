package com.gymcoach.gym_coach.feature.today

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
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.gymcoach.gym_coach.domain.model.DayTask
import com.gymcoach.gym_coach.theme.AppButton
import com.gymcoach.gym_coach.theme.AppMascot
import com.gymcoach.gym_coach.theme.AppColors
import com.gymcoach.gym_coach.theme.MascotMood
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TodayScreen(vm: TodayViewModel = hiltViewModel()) {
    val state by vm.state.collectAsState()
    val snackbar = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()
    LaunchedEffect(Unit) { vm.load() }
    Scaffold(
        snackbarHost = { SnackbarHost(snackbar) },
        containerColor = AppColors.duoBackground,
        topBar = {
            TopAppBar(
                title = { Text("今日任务") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppColors.duoGreen,
                    titleContentColor = Color.White
                )
            )
        }
    ) { padding ->
        Box(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentAlignment = Alignment.TopCenter
        ) {
            when (val s = state) {
                TodayUiState.Loading -> Text("加载中…")
                TodayUiState.Empty -> Text("今天没有任务，去跟教练聊聊")
                is TodayUiState.Loaded -> TodayContent(
                    task = s.task,
                    onCompleteWorkout = { vm.completeWorkout(s.task) { scope.launch { snackbar.showSnackbar("+$it XP") } } },
                    onCompleteMeal = { slot -> vm.completeMeal(s.task, slot) { scope.launch { snackbar.showSnackbar("+$it XP") } } }
                )
            }
        }
    }
}

@Composable
private fun TodayContent(
    task: DayTask,
    onCompleteWorkout: () -> Unit,
    onCompleteMeal: (String) -> Unit
) {
    Column(
        modifier = Modifier.fillMaxWidth().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        AppMascot(mood = MascotMood.Cheer)
        task.workout?.let { w ->
            Card(modifier = Modifier.fillMaxWidth()) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(12.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(Modifier.weight(1f)) {
                        Text(w.title, style = MaterialTheme.typography.titleLarge)
                        Text("${w.estimatedMinutes} 分钟 · ${w.exercises.size} 个动作")
                    }
                    if (task.completedWorkout) {
                        Icon(Icons.Filled.CheckCircle, contentDescription = "done", tint = AppColors.duoGreen)
                    } else {
                        AppButton(label = "完成", onClick = onCompleteWorkout)
                    }
                }
            }
        }
        task.meals.forEach { meal ->
            Card(modifier = Modifier.fillMaxWidth()) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(12.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(Modifier.weight(1f)) {
                        Text("${meal.slot} · ${meal.name}", style = MaterialTheme.typography.titleLarge)
                        Text("${meal.kcal} kcal")
                    }
                    if (task.completedMeals[meal.slot] == true) {
                        Icon(Icons.Filled.CheckCircle, contentDescription = "done", tint = AppColors.duoGreen)
                    } else {
                        AppButton(label = "吃了", onClick = { onCompleteMeal(meal.slot) })
                    }
                }
            }
        }
    }
}
