package com.gymcoach.gym_coach.navigation

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.ChatBubbleOutline
import androidx.compose.material.icons.outlined.LocalFireDepartment
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.Timeline
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.gymcoach.gym_coach.feature.coach.CoachScreen
import com.gymcoach.gym_coach.feature.onboarding.OnboardingScreen
import com.gymcoach.gym_coach.feature.path.PathScreen
import com.gymcoach.gym_coach.feature.profile.ProfileScreen
import com.gymcoach.gym_coach.feature.today.TodayScreen

private data class TabSpec(val route: String, val icon: ImageVector, val label: String)

@Composable
fun GymCoachNavGraph() {
    val navController = rememberNavController()
    NavHost(
        navController = navController,
        startDestination = Route.Onboarding.path
    ) {
        composable(Route.Onboarding.path) {
            OnboardingScreen(
                onPlanCreated = {
                    navController.navigate(Route.Shell.path) {
                        popUpTo(Route.Onboarding.path) { inclusive = true }
                    }
                }
            )
        }
        composable(Route.Shell.path) { TabScaffold() }
    }
}

@Composable
fun TabScaffold() {
    val tabNav = rememberNavController()
    val backStack by tabNav.currentBackStackEntryAsState()
    val current = backStack?.destination?.route ?: Route.Today.path
    val tabs = listOf(
        TabSpec(Route.Today.path,   Icons.Outlined.LocalFireDepartment,  "今日"),
        TabSpec(Route.Path.path,    Icons.Outlined.Timeline,            "路径"),
        TabSpec(Route.Coach.path,   Icons.Outlined.ChatBubbleOutline,   "教练"),
        TabSpec(Route.Profile.path, Icons.Outlined.Person,              "我"),
    )
    Scaffold(
        bottomBar = {
            NavigationBar {
                tabs.forEach { tab ->
                    NavigationBarItem(
                        selected = current == tab.route,
                        onClick = { tabNav.navigateTab(tab.route) },
                        icon = { Icon(tab.icon, contentDescription = tab.label) },
                        label = { Text(tab.label) }
                    )
                }
            }
        }
    ) { padding ->
        NavHost(
            navController = tabNav,
            startDestination = Route.Today.path,
            modifier = Modifier.fillMaxSize().padding(padding)
        ) {
            composable(Route.Today.path) { TodayScreen() }
            composable(Route.Path.path) { PathScreen() }
            composable(Route.Coach.path) { CoachScreen() }
            composable(Route.Profile.path) { ProfileScreen() }
        }
    }
}

private fun NavHostController.navigateTab(route: String) {
    navigate(route) {
        popUpTo(graph.findStartDestination().id) { saveState = true }
        launchSingleTop = true
        restoreState = true
    }
}
