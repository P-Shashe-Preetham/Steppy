import { useState, useEffect } from "react";
import { Screen } from "./types";
import { BottomNav } from "./components/common/BottomNav";
import { HomeScreen } from "./screens/HomeScreen";
import { StatisticsScreen } from "./screens/StatisticsScreen";
import { LeaderboardScreen } from "./screens/LeaderboardScreen";
import { ProfileScreen } from "./screens/ProfileScreen";
import { SearchScreen } from "./screens/SearchScreen";
import { AuthScreen } from "./screens/AuthScreen";
import { AppProvider, useApp } from "./context/AppContext";
import { NotificationsModal } from "./components/modals/NotificationsModal";
import { MessagesModal } from "./components/modals/MessagesModal";
import { CategoryModal } from "./components/modals/CategoryModal";
import { RewardStoreModal } from "./components/modals/RewardStoreModal";
import { Toast } from "./components/common/Toast";

function MainAppShell() {
  const { isLoggedIn, openModal } = useApp();
  const getInitialScreen = (): Screen => {
    try {
      const p = new URLSearchParams(window.location.search).get("screen");
      if (p && ["home", "search", "statistics", "leaderboard", "profile"].includes(p)) {
        return p as Screen;
      }
    } catch (_) {}
    return "home";
  };
  const [screen, setScreen] = useState<Screen>(getInitialScreen);

  useEffect(() => {
    try {
      const m = new URLSearchParams(window.location.search).get("modal");
      if (m && ["notifications", "messages", "categories", "rewards"].includes(m)) {
        openModal(m as any);
      }
    } catch (_) {}
  }, []);

  if (!isLoggedIn) {
    return <AuthScreen />;
  }

  const renderScreen = () => {
    switch (screen) {
      case "home":
        return <HomeScreen />;
      case "search":
        return <SearchScreen />;
      case "statistics":
        return <StatisticsScreen />;
      case "leaderboard":
        return <LeaderboardScreen />;
      case "profile":
        return <ProfileScreen />;
      default:
        return <HomeScreen />;
    }
  };

  return (
    <div className="app-shell">
      {renderScreen()}
      <BottomNav screen={screen} onChange={setScreen} />

      {/* Global Modals & Notifications */}
      <NotificationsModal />
      <MessagesModal />
      <CategoryModal />
      <RewardStoreModal />
      <Toast />
    </div>
  );
}

export default function App() {
  return (
    <AppProvider>
      <MainAppShell />
    </AppProvider>
  );
}
