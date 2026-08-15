package com.gymcoach.gym_coach.navigation

sealed class Route(val path: String) {
    data object Onboarding : Route("onboarding")
    data object Shell : Route("shell")
    data object Today : Route("today")
    data object Path : Route("path")
    data object Coach : Route("coach")
    data object Profile : Route("profile")
}
