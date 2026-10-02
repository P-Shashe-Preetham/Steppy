export type Screen = "home" | "search" | "statistics" | "leaderboard" | "profile" | "auth";

export interface UserProfile {
  id: string;
  name: string;
  email: string;
  handle: string;
  level: number;
  xp: number;
  xpNextLevel: number;
  coins: number;
  todaySteps: number;
  dailyGoal: number;
  totalSteps: number;
  streak: number;
  earnedBadgeIds: string[];
}

export interface UpcomingActivity {
  id: string;
  title: string;
  category: "Fitness" | "Warm-up" | "Cardio" | "Strength";
  scheduledTime: string;
  location?: string;
  artType: "workout" | "pushups";
}

export interface Gym {
  id: string;
  name: string;
  hours: string;
  distance: string;
  rating: number;
  isBookmarked?: boolean;
}

export interface OverviewMetric {
  id: string;
  value: string;
  label: string;
  iconBg: string;
  icon?: string;
}

export interface DailyCalories {
  day: string;
  height: number;
  calories: number;
}

export interface LeaderboardUser {
  id: string;
  rank: number;
  name: string;
  steps: number;
  xp: number;
  avatar: string;
  badge?: string;
  isCurrent?: boolean;
}

export interface BadgeItem {
  id: string;
  name: string;
  icon: string;
  desc: string;
  unlocked: boolean;
  requiredSteps?: number;
}

export interface RewardItem {
  id: string;
  name: string;
  description: string;
  cost: number;
  icon: string;
  category: "pass" | "gear" | "digital";
  redeemed?: boolean;
}

export interface NotificationItem {
  id: string;
  title: string;
  message: string;
  time: string;
  read: boolean;
  type: "achievement" | "social" | "reminder";
}
