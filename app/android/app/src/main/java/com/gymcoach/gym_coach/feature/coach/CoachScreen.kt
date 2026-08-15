package com.gymcoach.gym_coach.feature.coach

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
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Send
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.gymcoach.gym_coach.domain.model.ChatMessage
import com.gymcoach.gym_coach.domain.model.ChatRole
import com.gymcoach.gym_coach.theme.AppColors

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CoachScreen(vm: CoachViewModel = hiltViewModel()) {
    val state by vm.state.collectAsState()
    var input by remember { mutableStateOf("") }
    LaunchedEffect(Unit) { vm.load() }
    Scaffold(
        containerColor = AppColors.duoBackground,
        topBar = {
            TopAppBar(
                title = { Text("教练") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppColors.duoPurple,
                    titleContentColor = Color.White
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = 16.dp)
        ) {
            LazyColumn(
                modifier = Modifier.weight(1f).fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(8.dp),
                contentPadding = PaddingValues(vertical = 8.dp)
            ) {
                items(
                    items = state.messages,
                    key = { msg -> "${msg.createdAt}-${msg.role}" }
                ) { msg -> ChatBubble(msg) }
            }
            Row(
                modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                TextField(
                    value = input,
                    onValueChange = { input = it },
                    placeholder = { Text("问教练...") },
                    modifier = Modifier.weight(1f),
                    enabled = state.planId != null && !state.busy
                )
                Spacer(Modifier.width(4.dp))
                IconButton(
                    onClick = {
                        val text = input.trim()
                        if (text.isNotEmpty()) {
                            input = ""
                            vm.send(text)
                        }
                    },
                    enabled = state.planId != null && !state.busy
                ) { Icon(Icons.Filled.Send, contentDescription = "发送", tint = AppColors.duoGreen) }
            }
        }
    }
}

@Composable
private fun ChatBubble(msg: ChatMessage) {
    val isUser = msg.role == ChatRole.User
    Box(
        modifier = Modifier.fillMaxWidth(),
        contentAlignment = if (isUser) Alignment.CenterEnd else Alignment.CenterStart
    ) {
        val shape = RoundedCornerShape(12.dp)
        Box(
            modifier = Modifier
                .clip(shape)
                .background(if (isUser) AppColors.duoGreen else Color.White)
                .border(2.dp, AppColors.duoBlack, shape)
                .padding(horizontal = 12.dp, vertical = 8.dp)
        ) {
            Text(
                text = msg.content,
                color = if (isUser) Color.White else AppColors.duoText
            )
        }
    }
}

/** Local alias; the canonical items(...) lives in androidx.compose.foundation.lazy. */
private fun androidx.compose.foundation.lazy.LazyListScope.items(
    items: List<ChatMessage>,
    key: ((ChatMessage) -> Any)?,
    content: @Composable (ChatMessage) -> Unit
) {
    items(count = items.size, key = key?.let { k -> { i: Int -> k(items[i]) } }) { i ->
        content(items[i])
    }
}
