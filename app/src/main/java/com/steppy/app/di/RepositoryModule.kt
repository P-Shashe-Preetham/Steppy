package com.steppy.app.di

import com.steppy.app.data.repository.AuthRepository
import com.steppy.app.data.repository.AuthRepositoryImpl
import com.steppy.app.data.repository.ChallengeRepository
import com.steppy.app.data.repository.ChallengeRepositoryImpl
import com.steppy.app.data.repository.FriendsRepository
import com.steppy.app.data.repository.FriendsRepositoryImpl
import com.steppy.app.data.repository.RewardRepository
import com.steppy.app.data.repository.RewardRepositoryImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {

    @Binds
    @Singleton
    abstract fun bindAuthRepository(
        authRepositoryImpl: AuthRepositoryImpl
    ): AuthRepository

    @Binds
    @Singleton
    abstract fun bindChallengeRepository(
        challengeRepositoryImpl: ChallengeRepositoryImpl
    ): ChallengeRepository

    @Binds
    @Singleton
    abstract fun bindFriendsRepository(
        friendsRepositoryImpl: FriendsRepositoryImpl
    ): FriendsRepository

    @Binds
    @Singleton
    abstract fun bindRewardRepository(
        rewardRepositoryImpl: RewardRepositoryImpl
    ): RewardRepository
}
