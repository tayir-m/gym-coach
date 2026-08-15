package com.gymcoach.gym_coach.di

import android.content.Context
import androidx.room.Room
import com.gymcoach.gym_coach.data.db.AppDatabase
import com.gymcoach.gym_coach.data.db.dao.BadgeDao
import com.gymcoach.gym_coach.data.db.dao.ChatMessageDao
import com.gymcoach.gym_coach.data.db.dao.DayTaskDao
import com.gymcoach.gym_coach.data.db.dao.GamificationEventDao
import com.gymcoach.gym_coach.data.db.dao.PlanDao
import com.gymcoach.gym_coach.data.db.dao.StreakDao
import com.gymcoach.gym_coach.data.db.dao.UserProfileDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Provides @Singleton
    fun provideDatabase(@ApplicationContext context: Context): AppDatabase =
        Room.databaseBuilder(context, AppDatabase::class.java, AppDatabase.DB_NAME)
            .addMigrations()
            .build()

    @Provides fun provideUserProfileDao(db: AppDatabase): UserProfileDao = db.userProfileDao()
    @Provides fun providePlanDao(db: AppDatabase): PlanDao = db.planDao()
    @Provides fun provideDayTaskDao(db: AppDatabase): DayTaskDao = db.dayTaskDao()
    @Provides fun provideChatMessageDao(db: AppDatabase): ChatMessageDao = db.chatMessageDao()
    @Provides fun provideStreakDao(db: AppDatabase): StreakDao = db.streakDao()
    @Provides fun provideGamificationEventDao(db: AppDatabase): GamificationEventDao = db.gamificationEventDao()
    @Provides fun provideBadgeDao(db: AppDatabase): BadgeDao = db.badgeDao()
}
