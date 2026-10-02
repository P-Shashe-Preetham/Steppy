import { useState } from "react";
import { IconButton } from "../components/common/IconButton";
import { ASSET_MAP } from "../constants/assets";
import { useApp } from "../context/AppContext";
import { BadgeItem } from "../types";

export function ProfileScreen() {
  const {
    user,
    badges,
    logout,
    openModal,
    unreadNotificationCount,
    syncSteps,
  } = useApp();

  const [selectedBadge, setSelectedBadge] = useState<BadgeItem | null>(null);

  const xpProgress = Math.min(
    100,
    Math.round((user.xp / user.xpNextLevel) * 100)
  );

  return (
    <main className="screen profile-screen">
      <header className="home-header">
        <h1>Profile</h1>
        <IconButton
          icon={ASSET_MAP.NOTIFICATIONS}
          label="Notifications"
          notification={unreadNotificationCount > 0}
          onClick={() => openModal("notifications")}
        />
      </header>

      {/* Hero Profile Card */}
      <section className="profile-hero-card">
        <div className="profile-avatar-wrapper">
          <div className="profile-avatar">
            {user.name.split(" ").map((n) => n[0]).join("") || "HB"}
          </div>
          <span className="profile-level-badge">Lvl {user.level}</span>
        </div>
        <h2>{user.name}</h2>
        <p className="profile-handle">{user.handle} · Pro Walker</p>

        {/* Level XP Bar */}
        <div className="profile-xp-box">
          <div className="profile-xp-labels">
            <span>Level {user.level}</span>
            <span>
              {user.xp.toLocaleString()} / {user.xpNextLevel.toLocaleString()} XP
            </span>
          </div>
          <div className="profile-xp-track">
            <div
              className="profile-xp-fill"
              style={{ width: `${xpProgress}%` }}
            />
          </div>
        </div>

        {/* Quick Stats Grid */}
        <div className="profile-stats-row">
          <div className="profile-stat-box">
            <strong>{user.totalSteps.toLocaleString()}</strong>
            <span>Total Steps</span>
          </div>
          <div className="profile-stat-box">
            <strong>{user.streak} Days</strong>
            <span>Streak 🔥</span>
          </div>
          <div className="profile-stat-box">
            <strong>{user.coins} 🪙</strong>
            <span>Coins</span>
          </div>
        </div>

        {/* Quick Actions inside Profile */}
        <div className="profile-action-row">
          <button
            className="profile-btn-primary"
            onClick={() => openModal("rewards")}
          >
            🏪 Open Rewards Store
          </button>
          <button
            className="profile-btn-secondary"
            onClick={() => syncSteps(1000)}
          >
            +1,000 Steps 👟
          </button>
        </div>
      </section>

      {/* Badges Section */}
      <section className="content-section">
        <div className="section-heading">
          <h2>Badges Showcase</h2>
          <span className="badge-count-pill">
            {badges.filter((b) => b.unlocked).length} / {badges.length} Unlocked
          </span>
        </div>
        <div className="badges-grid">
          {badges.map((b) => (
            <div
              key={b.id}
              className={`badge-card ${b.unlocked ? "badge-unlocked" : "badge-locked"}`}
              onClick={() => setSelectedBadge(b)}
            >
              <span className="badge-icon">{b.icon}</span>
              <strong>{b.name}</strong>
              <span>{b.desc}</span>
            </div>
          ))}
        </div>
      </section>

      {/* Account / Logout Button */}
      <section className="content-section" style={{ marginTop: 24 }}>
        <button className="logout-btn" onClick={logout}>
          🚪 Log Out of {user.name}
        </button>
      </section>

      {/* Badge Detail Modal Dialog */}
      {selectedBadge && (
        <div className="modal-backdrop" onClick={() => setSelectedBadge(null)}>
          <div className="modal-dialog" onClick={(e) => e.stopPropagation()}>
            <span className="dialog-badge-icon">{selectedBadge.icon}</span>
            <h3>{selectedBadge.name}</h3>
            <p>{selectedBadge.desc}</p>
            <div className="badge-status-tag">
              {selectedBadge.unlocked ? "Unlocked 🎉" : "Locked 🔒"}
            </div>
            <button
              className="dialog-close-btn"
              onClick={() => setSelectedBadge(null)}
            >
              Close
            </button>
          </div>
        </div>
      )}
    </main>
  );
}
