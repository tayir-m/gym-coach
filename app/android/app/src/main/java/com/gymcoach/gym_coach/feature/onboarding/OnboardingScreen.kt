package com.gymcoach.gym_coach.feature.onboarding

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.gymcoach.gym_coach.theme.AppButton
import com.gymcoach.gym_coach.theme.AppColors

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun OnboardingScreen(
    onPlanCreated: () -> Unit,
    vm: OnboardingViewModel = hiltViewModel()
) {
    val state by vm.state.collectAsState()
    var input by remember { mutableStateOf("") }
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("与教练聊聊") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppColors.duoGreen,
                    titleContentColor = androidx.compose.ui.graphics.Color.White
                )
            )
        },
        containerColor = AppColors.duoBackground
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            LazyColumn(
                modifier = Modifier.weight(1f).fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(8.dp),
                contentPadding = PaddingValues(vertical = 8.dp)
            ) {
                items(state.messages, key = { idx -> idx.hashCode() }) { msg ->
                    ChatBubble(role = msg.role, text = msg.text)
                }
            }
            Row(
                modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                TextField(
                    value = input,
                    onValueChange = { input = it },
                    placeholder = { Text("说点什么...") },
                    modifier = Modifier.weight(1f),
                    singleLine = false,
                    maxLines = 4
                )
                Spacer(Modifier.width(8.dp))
                AppButton(
                    label = if (state.busy) "发送中…" else "发送",
                    onClick = {
                        val text = input.trim()
                        if (text.isNotEmpty()) {
                            input = ""
                            vm.send(text) { onPlanCreated() }
                        }
                    },
                    enabled = !state.busy && !state.planCreated
                )
            }
        }
    }
}

@Composable
private fun ChatBubble(role: String, text: String) {
    val isUser = role == "user"
    val bg = if (isUser) AppColors.duoGreen else androidx.compose.ui.graphics.Color.White
    val fg = if (isUser) androidx.compose.ui.graphics.Color.White else AppColors.duoText
    val shape = RoundedCornerShape(12.dp)
    Box(
        modifier = Modifier.fillMaxWidth(),
        contentAlignment = if (isUser) Alignment.CenterEnd else Alignment.CenterStart
    ) {
        Box(
            modifier = Modifier
                .padding(horizontal = 4.dp)
                .clip(shape)
                .background(bg)
                .border(2.dp, AppColors.duoBlack, shape)
                .padding(horizontal = 12.dp, vertical = 8.dp)
        ) {
            Text(text = text, color = fg)
        }
    }
}
