import { ASSET_MAP } from "../constants/assets";
import {
  BadgeItem,
  DailyCalories,
  Gym,
  LeaderboardUser,
  NotificationItem,
  OverviewMetric,
  RewardItem,
  UpcomingActivity,
  UserProfile,
} from "../types";

export const INITIAL_USER: UserProfile = {
  id: "u-current",
  name: "HoneyBadger",
  email: "honeybadger@steppy.app",
  handle: "@honeybadger",
  level: 4,
  xp: 2400,
  xpNextLevel: 3000,
  coins: 420,
  todaySteps: 8520,
  dailyGoal: 10000,
  totalSteps: 124500,
  streak: 7,
  earnedBadgeIds: ["1", "2", "3"],
};

export const UPCOMING_ACTIVITIES: UpcomingActivity[] = [
  {
    id: "act-1",
    title: "Workout",
    category: "Fitness",
    scheduledTime: "Today at 2:45 PM",
    location: "Aleja Pokoju",
    artType: "workout",
  },
  {
    id: "act-2",
    title: "Push-ups",
    category: "Warm-up",
    scheduledTime: "Tomorrow at 10:00 AM",
    artType: "pushups",
  },
];

export const INITIAL_GYMS: Gym[] = [
  {
    id: "gym-1",
    name: "GymFit",
    hours: "10:00 AM – 11:00 PM",
    distance: "250 meters",
    rating: 5.0,
    isBookmarked: false,
  },
  {
    id: "gym-2",
    name: "Lotus",
    hours: "24/7",
    distance: "630 meters",
    rating: 5.0,
    isBookmarked: true,
  },
  {
    id: "gym-3",
    name: "PowerGym Kraków",
    hours: "6:00 AM – Midnight",
    distance: "1.2 km",
    rating: 4.9,
    isBookmarked: false,
  },
  {
    id: "gym-4",
    name: "CrossFit Central",
    hours: "7:00 AM – 10:00 PM",
    distance: "1.8 km",
    rating: 4.8,
    isBookmarked: false,
  },
];

export const ALL_BADGES: BadgeItem[] = [
  { id: "1", name: "10K Club", icon: "👟", desc: "10,000 steps in a single day", unlocked: true, requiredSteps: 10000 },
  { id: "2", name: "7-Day Streak", icon: "🔥", desc: "Maintain daily goal for 7 consecutive days", unlocked: true },
  { id: "3", name: "Century Walk", icon: "⚡", desc: "Reach 100 total kilometers walked", unlocked: true },
  { id: "4", name: "Champion", icon: "🏆", desc: "Win 1st place in a community step race", unlocked: false },
  { id: "5", name: "Night Owl", icon: "🌙", desc: "Complete 2,500 steps after 8:00 PM", unlocked: false },
  { id: "6", name: "Step Millionaire", icon: "💎", desc: "Accumulate 1,000,000 lifetime steps", unlocked: false, requiredSteps: 1000000 },
];

export const REWARD_STORE_ITEMS: RewardItem[] = [
  {
    id: "rew-1",
    name: "Free Day Pass (GymFit)",
    description: "Full day access to all GymFit cardio & weights equipment.",
    cost: 150,
    icon: "🎟️",
    category: "pass",
  },
  {
    id: "rew-2",
    name: "Steppy Pro Water Bottle",
    description: "Insulated 750ml stainless steel water bottle.",
    cost: 300,
    icon: "🍶",
    category: "gear",
  },
  {
    id: "rew-3",
    name: "Exclusive Golden Avatar Ring",
    description: "Stand out on the global leaderboard with a shiny border.",
    cost: 200,
    icon: "✨",
    category: "digital",
  },
  {
    id: "rew-4",
    name: "One Month Free Lotus Gym",
    description: "24/7 unlimited access pass for 30 days.",
    cost: 800,
    icon: "🏋️",
    category: "pass",
  },
];

export const INITIAL_NOTIFICATIONS: NotificationItem[] = [
  {
    id: "notif-1",
    title: "Streak Milestone! 🔥",
    message: "You have maintained your 7-day walking streak! +50 XP bonus.",
    time: "10m ago",
    read: false,
    type: "achievement",
  },
  {
    id: "notif-2",
    title: "Sarah challenged you 👟",
    message: "Sarah invited you to the 'Weekend 25k Marathon' challenge.",
    time: "2h ago",
    read: false,
    type: "social",
  },
  {
    id: "notif-3",
    title: "Daily Goal Reminder ⏱️",
    message: "Only 1,480 steps left to smash today's 10,000 target!",
    time: "5h ago",
    read: true,
    type: "reminder",
  },
];

export const LEADERBOARD_DATA: Record<string, LeaderboardUser[]> = {
  Today: [
    { id: "u1", rank: 1, name: "Sarah Walker", steps: 14250, xp: 1425, avatar: "SW", badge: "👑" },
    { id: "u2", rank: 2, name: "John Doe", steps: 12850, xp: 1285, avatar: "JD", badge: "🥈" },
    { id: "u3", rank: 3, name: "Alex Runner", steps: 11400, xp: 1140, avatar: "AR", badge: "🥉" },
    { id: "u4", rank: 4, name: "Emma Fit", steps: 9800, xp: 980, avatar: "EF" },
    { id: "u-current", rank: 5, name: "HoneyBadger (You)", steps: 8520, xp: 852, avatar: "HB", isCurrent: true },
    { id: "u5", rank: 6, name: "Michael B", steps: 7200, xp: 720, avatar: "MB" },
    { id: "u6", rank: 7, name: "David K", steps: 6100, xp: 610, avatar: "DK" },
  ],
  "This Week": [
    { id: "u1", rank: 1, name: "Sarah Walker", steps: 89400, xp: 8940, avatar: "SW", badge: "👑" },
    { id: "u-current", rank: 2, name: "HoneyBadger (You)", steps: 74200, xp: 7420, avatar: "HB", badge: "🥈", isCurrent: true },
    { id: "u2", rank: 3, name: "John Doe", steps: 68900, xp: 6890, avatar: "JD", badge: "🥉" },
    { id: "u3", rank: 4, name: "Alex Runner", steps: 61500, xp: 6150, avatar: "AR" },
    { id: "u4", rank: 5, name: "Emma Fit", steps: 58200, xp: 5820, avatar: "EF" },
    { id: "u5", rank: 6, name: "Michael B", steps: 44000, xp: 4400, avatar: "MB" },
    { id: "u6", rank: 7, name: "David K", steps: 39500, xp: 3950, avatar: "DK" },
  ],
  "All Time": [
    { id: "u3", rank: 1, name: "Alex Runner", steps: 1250000, xp: 125000, avatar: "AR", badge: "👑" },
    { id: "u1", rank: 2, name: "Sarah Walker", steps: 980000, xp: 98000, avatar: "SW", badge: "🥈" },
    { id: "u-current", rank: 3, name: "HoneyBadger (You)", steps: 840000, xp: 84000, avatar: "HB", badge: "🥉", isCurrent: true },
    { id: "u2", rank: 4, name: "John Doe", steps: 790000, xp: 79000, avatar: "JD" },
    { id: "u4", rank: 5, name: "Emma Fit", steps: 620000, xp: 62000, avatar: "EF" },
  ],
};

export const WEEKDAYS = ["M", "T", "W", "T", "F", "S", "S"];

export const CALENDAR_DATES = [13, 14, 15, 16, 17, 18, 19];

export const WEEKLY_CALORIES: DailyCalories[] = [
  { day: "Mon", height: 48, calories: 1250 },
  { day: "Tue", height: 72, calories: 1840 },
  { day: "Wed", height: 54, calories: 1420 },
  { day: "Thu", height: 96, calories: 2350 },
  { day: "Fri", height: 38, calories: 980 },
  { day: "Sat", height: 60, calories: 1600 },
  { day: "Sun", height: 82, calories: 2100 },
];
