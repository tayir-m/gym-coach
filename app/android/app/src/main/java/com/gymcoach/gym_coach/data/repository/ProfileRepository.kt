package com.gymcoach.gym_coach.data.repository

import com.gymcoach.gym_coach.data.db.dao.UserProfileDao
import com.gymcoach.gym_coach.data.db.entity.UserProfileEntity
import com.gymcoach.gym_coach.domain.model.Experience
import com.gymcoach.gym_coach.domain.model.Goal
import com.gymcoach.gym_coach.domain.model.Sex
import com.gymcoach.gym_coach.domain.model.UserProfile
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.builtins.MapSerializer
import kotlinx.serialization.builtins.serializer
import kotlinx.serialization.json.Json
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Mirrors `lib/data/repositories/profile_repository.dart`. Note `save` is an
 * INSERT, never an upsert; calling it twice yields two rows and `get()` will
 * only return the first.
 */
@Singleton
class ProfileRepository @Inject constructor(
    private val dao: UserProfileDao
) {
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun get(): UserProfile? {
        val row = dao.first() ?: return null
        return UserProfile(
            age = row.age,
            heightCm = row.heightCm,
            weightKg = row.weightKg,
            sex = Sex.valueOf(row.sex),
            goal = Goal.valueOf(row.goal),
            experience = Experience.valueOf(row.experience),
            equipment = json.decodeFromString(ListSerializer(String.serializer()), row.equipment),
            injuries = row.injuries,
            dietaryNotes = row.dietaryNotes,
            dailySchedule = if (row.dailySchedule.isEmpty()) emptyMap()
            else json.decodeFromString(MapSerializer(String.serializer(), Boolean.serializer()), row.dailySchedule),
            updatedAt = row.updatedAt
        )
    }

    suspend fun save(profile: UserProfile): Long {
        val entity = UserProfileEntity(
            age = profile.age,
            heightCm = profile.heightCm,
            weightKg = profile.weightKg,
            sex = profile.sex.name,
            goal = profile.goal.name,
            experience = profile.experience.name,
            equipment = json.encodeToString(ListSerializer(String.serializer()), profile.equipment),
            injuries = profile.injuries,
            dietaryNotes = profile.dietaryNotes,
            dailySchedule = json.encodeToString(
                MapSerializer(String.serializer(), Boolean.serializer()),
                profile.dailySchedule
            ),
            updatedAt = profile.updatedAt
        )
        return dao.insert(entity)
    }
}
