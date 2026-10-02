import React, { createContext, useContext, useState, ReactNode } from "react";
import {
  ALL_BADGES,
  INITIAL_GYMS,
  INITIAL_NOTIFICATIONS,
  INITIAL_USER,
  REWARD_STORE_ITEMS,
} from "../data/mockData";
import {
  BadgeItem,
  Gym,
  NotificationItem,
  RewardItem,
  UserProfile,
} from "../types";

export type ModalType =
  | "notifications"
  | "messages"
  | "categories"
  | "rewards"
  | "challenge"
  | null;

interface AppContextType {
  user: UserProfile;
  isLoggedIn: boolean;
  login: (email: string, password: string) => boolean;
  signup: (name: string, email: string, password: string) => boolean;
  logout: () => void;
  syncSteps: (amount?: number) => void;
  gyms: Gym[];
  toggleBookmark: (gymId: string) => void;
  badges: BadgeItem[];
  rewards: RewardItem[];
  redeemReward: (rewardId: string) => boolean;
  notifications: NotificationItem[];
  unreadNotificationCount: number;
  markAllNotificationsRead: () => void;
  selectedDate: number;
  setSelectedDate: (date: number) => void;
  activeModal: ModalType;
  openModal: (modal: ModalType) => void;
  closeModal: () => void;
  toast: string | null;
  showToast: (msg: string) => void;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: ReactNode }) {
  const [isLoggedIn, setIsLoggedIn] = useState(true);
  const [user, setUser] = useState<UserProfile>(INITIAL_USER);
  const [gyms, setGyms] = useState<Gym[]>(INITIAL_GYMS);
  const [badges, setBadges] = useState<BadgeItem[]>(ALL_BADGES);
  const [rewards, setRewards] = useState<RewardItem[]>(REWARD_STORE_ITEMS);
  const [notifications, setNotifications] = useState<NotificationItem[]>(
    INITIAL_NOTIFICATIONS
  );
  const [selectedDate, setSelectedDate] = useState<number>(15);
  const [activeModal, setActiveModal] = useState<ModalType>(null);
  const [toast, setToast] = useState<string | null>(null);

  const showToast = (msg: string) => {
    setToast(msg);
    setTimeout(() => {
      setToast((current) => (current === msg ? null : current));
    }, 3200);
  };

  const login = (email: string, _password: string): boolean => {
    setIsLoggedIn(true);
    setUser((prev) => ({
      ...prev,
      email,
      name: email.split("@")[0] || "Steppy User",
      handle: `@${(email.split("@")[0] || "user").toLowerCase()}`,
    }));
    showToast(`Welcome back, ${email.split("@")[0]}! 👋`);
    return true;
  };

  const signup = (name: string, email: string, _password: string): boolean => {
    setIsLoggedIn(true);
    setUser({
      id: `u-${Date.now()}`,
      name,
      email,
      handle: `@${name.toLowerCase().replace(/\s+/g, "")}`,
      level: 1,
      xp: 0,
      xpNextLevel: 1000,
      coins: 100,
      todaySteps: 0,
      dailyGoal: 10000,
      totalSteps: 0,
      streak: 1,
      earnedBadgeIds: [],
    });
    showToast(`Account created! +100 Welcome Coins 🪙`);
    return true;
  };

  const logout = () => {
    setIsLoggedIn(false);
    showToast("Logged out successfully.");
  };

  const syncSteps = (amount: number = 750) => {
    setUser((prev) => {
      const newToday = prev.todaySteps + amount;
      const newTotal = prev.totalSteps + amount;
      const xpGained = Math.round(amount / 10);
      let newXp = prev.xp + xpGained;
      let newLevel = prev.level;
      let newXpNextLevel = prev.xpNextLevel;
      let newCoins = prev.coins + Math.round(amount / 200); // 1 coin per 200 steps

      // Level up check (1000 XP per level)
      if (newXp >= newXpNextLevel) {
        newLevel += 1;
        newXpNextLevel += 1000;
        newCoins += 50; // Level-up bonus
        showToast(`🎉 LEVEL UP! You reached Level ${newLevel}! (+50 Coins)`);
      } else {
        showToast(`Synced +${amount} steps! (+${xpGained} XP) 👟`);
      }

      // Check badge unlock (e.g. 10k club)
      if (newToday >= 10000 && !prev.earnedBadgeIds.includes("1")) {
        setBadges((all) =>
          all.map((b) => (b.id === "1" ? { ...b, unlocked: true } : b))
        );
        prev.earnedBadgeIds.push("1");
        showToast("🏆 BADGE UNLOCKED: 10K Club!");
      }

      return {
        ...prev,
        todaySteps: newToday,
        totalSteps: newTotal,
        xp: newXp,
        level: newLevel,
        xpNextLevel: newXpNextLevel,
        coins: newCoins,
      };
    });
  };

  const toggleBookmark = (gymId: string) => {
    setGyms((prev) =>
      prev.map((g) =>
        g.id === gymId ? { ...g, isBookmarked: !g.isBookmarked } : g
      )
    );
    showToast("Updated favorites");
  };

  const redeemReward = (rewardId: string): boolean => {
    const target = rewards.find((r) => r.id === rewardId);
    if (!target) return false;

    if (user.coins < target.cost) {
      showToast(`Not enough coins! Need ${target.cost - user.coins} more 🪙`);
      return false;
    }

    setUser((prev) => ({
      ...prev,
      coins: prev.coins - target.cost,
    }));

    setRewards((prev) =>
      prev.map((r) => (r.id === rewardId ? { ...r, redeemed: true } : r))
    );

    showToast(`Redeemed ${target.name}! Check your inventory 🎉`);
    return true;
  };

  const unreadNotificationCount = notifications.filter((n) => !n.read).length;

  const markAllNotificationsRead = () => {
    setNotifications((prev) => prev.map((n) => ({ ...n, read: true })));
    showToast("All notifications marked as read");
  };

  const openModal = (modal: ModalType) => setActiveModal(modal);
  const closeModal = () => setActiveModal(null);

  return (
    <AppContext.Provider
      value={{
        user,
        isLoggedIn,
        login,
        signup,
        logout,
        syncSteps,
        gyms,
        toggleBookmark,
        badges,
        rewards,
        redeemReward,
        notifications,
        unreadNotificationCount,
        markAllNotificationsRead,
        selectedDate,
        setSelectedDate,
        activeModal,
        openModal,
        closeModal,
        toast,
        showToast,
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error("useApp must be used within an AppProvider");
  }
  return context;
}
