package com.gymcoach.gym_coach.data.repository

import com.gymcoach.gym_coach.data.db.dao.DayTaskDao
import com.gymcoach.gym_coach.data.db.dao.GamificationEventDao
import com.gymcoach.gym_coach.data.db.dao.StreakDao
import com.gymcoach.gym_coach.data.db.entity.GamificationEventEntity
import com.gymcoach.gym_coach.domain.model.StreakData
import java.time.LocalDate
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class GamificationRepository @Inject constructor(
    private val streakDao: StreakDao,
    private val dayTaskDao: DayTaskDao,
    private val eventDao: GamificationEventDao
) {

    suspend fun getStreak(): StreakData {
        val row = streakDao.getOrCreate()
        return StreakData(
            currentDays = row.currentDays,
            longestDays = row.longestDays,
            lastActiveDate = row.lastActiveDate?.let { LocalDate.ofEpochDay(it) },
            freezesRemaining = row.freezesRemaining.coerceIn(0, 2)
        )
    }

    suspend fun updateStreak(data: StreakData) {
        streakDao.overwrite(
            current = data.currentDays,
            longest = data.longestDays,
            last = data.lastActiveDate?.toEpochDay(),
            freezes = data.freezesRemaining.coerceIn(0, 2)
        )
    }

    suspend fun getTotalXp(): Int = dayTaskDao.totalXp()

    suspend fun getTotalWorkoutsCompleted(): Int = dayTaskDao.totalWorkoutsCompleted()

    suspend fun recordEvent(type: String, value: Int) {
        eventDao.insert(GamificationEventEntity(eventType = type, value = value, createdAt = System.currentTimeMillis()))
    }
}
