package com.gymcoach.gym_coach.di

import com.gymcoach.gym_coach.BuildConfig
import com.gymcoach.gym_coach.config.AppConfig
import com.gymcoach.gym_coach.data.network.HmacSigningInterceptor
import com.gymcoach.gym_coach.data.network.LlmClient
import com.gymcoach.gym_coach.data.network.LlmClientImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    @Provides @Singleton
    fun provideAppConfig(): AppConfig = AppConfig(
        proxyEndpoint = BuildConfig.PROXY_ENDPOINT,
        hmacSecret = BuildConfig.HMAC_SECRET
    )

    @Provides @Singleton
    fun provideOkHttpClient(signer: HmacSigningInterceptor): OkHttpClient {
        val logging = HttpLoggingInterceptor().apply {
            level = if (BuildConfig.DEBUG) HttpLoggingInterceptor.Level.BASIC
            else HttpLoggingInterceptor.Level.NONE
        }
        return OkHttpClient.Builder()
            .addInterceptor(signer)
            .addInterceptor(logging)
            .callTimeout(60, TimeUnit.SECONDS)
            .readTimeout(60, TimeUnit.SECONDS)
            .build()
    }

    @Provides @Singleton
    fun provideLlmClient(client: OkHttpClient, config: AppConfig): LlmClient =
        LlmClientImpl(client, config)
}
