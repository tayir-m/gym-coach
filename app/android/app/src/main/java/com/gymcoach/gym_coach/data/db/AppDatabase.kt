package com.gymcoach.gym_coach.data.db

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.gymcoach.gym_coach.data.db.dao.BadgeDao
import com.gymcoach.gym_coach.data.db.dao.ChatMessageDao
import com.gymcoach.gym_coach.data.db.dao.DayTaskDao
import com.gymcoach.gym_coach.data.db.dao.GamificationEventDao
import com.gymcoach.gym_coach.data.db.dao.PlanDao
import com.gymcoach.gym_coach.data.db.dao.StreakDao
import com.gymcoach.gym_coach.data.db.dao.UserProfileDao
import com.gymcoach.gym_coach.data.db.entity.BadgeEntity
import com.gymcoach.gym_coach.data.db.entity.ChatMessageEntity
import com.gymcoach.gym_coach.data.db.entity.DayTaskEntity
import com.gymcoach.gym_coach.data.db.entity.GamificationEventEntity
import com.gymcoach.gym_coach.data.db.entity.PlanEntity
import com.gymcoach.gym_coach.data.db.entity.StreakEntity
import com.gymcoach.gym_coach.data.db.entity.UserProfileEntity

@Database(
    entities = [
        UserProfileEntity::class,
        PlanEntity::class,
        DayTaskEntity::class,
        ChatMessageEntity::class,
        StreakEntity::class,
        GamificationEventEntity::class,
        BadgeEntity::class
    ],
    version = 1,
    exportSchema = false
)
@TypeConverters(Converters::class)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userProfileDao(): UserProfileDao
    abstract fun planDao(): PlanDao
    abstract fun dayTaskDao(): DayTaskDao
    abstract fun chatMessageDao(): ChatMessageDao
    abstract fun streakDao(): StreakDao
    abstract fun gamificationEventDao(): GamificationEventDao
    abstract fun badgeDao(): BadgeDao

    companion object {
        const val DB_NAME = "gym_coach.sqlite"
    }
}
