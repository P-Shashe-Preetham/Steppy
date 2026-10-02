import { useState } from "react";
import { LEADERBOARD_DATA } from "../data/mockData";
import { useApp } from "../context/AppContext";

type Timeframe = "Today" | "This Week" | "All Time";

export function LeaderboardScreen() {
  const { user, showToast } = useApp();
  const [timeframe, setTimeframe] = useState<Timeframe>("Today");

  // Get users for timeframe, ensuring current user shows real today steps if Today
  const rawList = LEADERBOARD_DATA[timeframe] || LEADERBOARD_DATA["Today"];
  const list = rawList.map((u) => {
    if (u.isCurrent && timeframe === "Today") {
      return {
        ...u,
        steps: user.todaySteps,
        xp: Math.round(user.todaySteps / 10),
      };
    }
    return u;
  });

  // Re-sort based on updated steps
  list.sort((a, b) => b.steps - a.steps);
  const rankedList = list.map((u, i) => ({ ...u, rank: i + 1 }));

  const topThree = rankedList.slice(0, 3);
  const restList = rankedList.slice(3);

  const handleNudge = (targetName: string) => {
    showToast(`Nudged ${targetName}! 👋 Motivations sent.`);
  };

  return (
    <main className="screen leaderboard-screen">
      <div className="section-heading">
        <h1>Leaderboard</h1>
        <div className="timeframe-pills">
          {(["Today", "This Week", "All Time"] as Timeframe[]).map((t) => (
            <button
              key={t}
              className={`timeframe-pill-btn ${timeframe === t ? "active" : ""}`}
              onClick={() => {
                setTimeframe(t);
                showToast(`Switched leaderboard to ${t}`);
              }}
            >
              {t}
            </button>
          ))}
        </div>
      </div>

      {/* Top 3 Podium Cards */}
      <section className="podium-section">
        <div className="podium-grid">
          {topThree[1] && (
            <div className="podium-card rank-2">
              <span className="podium-badge">🥈</span>
              <div className="podium-avatar">{topThree[1].avatar}</div>
              <strong>{topThree[1].name}</strong>
              <span className="podium-steps">{topThree[1].steps.toLocaleString()} steps</span>
              <span className="podium-xp">{topThree[1].xp.toLocaleString()} XP</span>
            </div>
          )}

          {topThree[0] && (
            <div className="podium-card rank-1">
              <span className="podium-badge">👑</span>
              <div className="podium-avatar">{topThree[0].avatar}</div>
              <strong>{topThree[0].name}</strong>
              <span className="podium-steps">{topThree[0].steps.toLocaleString()} steps</span>
              <span className="podium-xp">{topThree[0].xp.toLocaleString()} XP</span>
            </div>
          )}

          {topThree[2] && (
            <div className="podium-card rank-3">
              <span className="podium-badge">🥉</span>
              <div className="podium-avatar">{topThree[2].avatar}</div>
              <strong>{topThree[2].name}</strong>
              <span className="podium-steps">{topThree[2].steps.toLocaleString()} steps</span>
              <span className="podium-xp">{topThree[2].xp.toLocaleString()} XP</span>
            </div>
          )}
        </div>
      </section>

      {/* Ranks 4+ List */}
      <section className="content-section ranks-section">
        <h2>Rankings</h2>
        <div className="ranks-list">
          {restList.map((u) => (
            <div
              key={u.id}
              className={`rank-item ${u.isCurrent ? "current-user-item" : ""}`}
            >
              <span className="rank-num">#{u.rank}</span>
              <div className="rank-avatar">{u.avatar}</div>
              <div className="rank-info">
                <strong>{u.name}</strong>
                <span>{u.xp.toLocaleString()} XP</span>
              </div>
              <div className="rank-steps">
                <strong>{u.steps.toLocaleString()}</strong>
                <span>steps</span>
              </div>
              {!u.isCurrent && (
                <button
                  className="nudge-btn"
                  onClick={() => handleNudge(u.name)}
                  title="Send encouragement"
                >
                  Nudge 👋
                </button>
              )}
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}
