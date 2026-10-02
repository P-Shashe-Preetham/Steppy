import { IconButton } from "../components/common/IconButton";
import { PeriodChip } from "../components/common/PeriodChip";
import { UpcomingCard } from "../components/home/UpcomingCard";
import { GymCard } from "../components/home/GymCard";
import { ActivityChart } from "../components/home/ActivityChart";
import { UPCOMING_ACTIVITIES } from "../data/mockData";
import { asset, ASSET_MAP } from "../constants/assets";
import { useApp } from "../context/AppContext";

export function HomeScreen() {
  const {
    user,
    gyms,
    openModal,
    unreadNotificationCount,
    syncSteps,
  } = useApp();

  const progressPercent = Math.min(
    100,
    Math.round((user.todaySteps / user.dailyGoal) * 100)
  );

  return (
    <main className="screen home-screen">
      {/* Header */}
      <header className="home-header">
        <IconButton
          icon={ASSET_MAP.CATEGORIES_MENU}
          label="Open categories & preferences"
          onClick={() => openModal("categories")}
        />
        <div className="header-actions">
          <IconButton
            icon={ASSET_MAP.MESSAGES}
            label="Messages"
            onClick={() => openModal("messages")}
          />
          <IconButton
            icon={ASSET_MAP.NOTIFICATIONS}
            label="Notifications"
            notification={unreadNotificationCount > 0}
            onClick={() => openModal("notifications")}
          />
        </div>
      </header>

      <h1>Home</h1>

      {/* Interactive Step Quick Tracker Banner */}
      <section className="live-tracker-banner">
        <div className="tracker-header">
          <div>
            <span className="tracker-sub">Today's Progress</span>
            <div className="tracker-main">
              <strong>{user.todaySteps.toLocaleString()}</strong>
              <span> / {user.dailyGoal.toLocaleString()} steps</span>
            </div>
          </div>
          <button
            className="quick-sync-btn"
            onClick={() => syncSteps(750)}
            title="Simulate step tracking"
          >
            +750 Walk 👟
          </button>
        </div>
        <div className="tracker-bar-track">
          <div
            className="tracker-bar-fill"
            style={{ width: `${progressPercent}%` }}
          />
        </div>
        <div className="tracker-footer">
          <span>{progressPercent}% of daily goal</span>
          <span>{user.coins} Coins 🪙 · Level {user.level}</span>
        </div>
      </section>

      {/* Upcoming Activities Carousel */}
      <section className="content-section upcoming">
        <h2>Upcoming</h2>
        <div className="horizontal-cards">
          {UPCOMING_ACTIVITIES.map((activity) => (
            <UpcomingCard key={activity.id} activity={activity} />
          ))}
        </div>
      </section>

      {/* Nearby Gyms */}
      <section className="content-section gyms">
        <h2>Gyms near you</h2>
        <p className="section-location">
          <img src={asset(ASSET_MAP.LOCATION_PIN_MD)} alt="" />
          Starowiślna 12
        </p>
        <div className="gym-grid">
          {gyms.slice(0, 2).map((gym) => (
            <GymCard key={gym.id} gym={gym} />
          ))}
        </div>
      </section>

      {/* Activities Timeline Chart */}
      <section className="content-section activities">
        <div className="section-heading">
          <h2>Activities</h2>
          <PeriodChip label="Weekly" />
        </div>
        <ActivityChart />
      </section>
    </main>
  );
}
