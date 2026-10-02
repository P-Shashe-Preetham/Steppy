import { asset, ASSET_MAP } from "../../constants/assets";
import { Screen } from "../../types";

interface BottomNavProps {
  screen: Screen;
  onChange: (screen: Screen) => void;
}

export function BottomNav({ screen, onChange }: BottomNavProps) {
  return (
    <nav className="bottom-nav" aria-label="Primary navigation">
      {/* Home */}
      <button
        className={screen === "home" ? "nav-active" : "nav-icon"}
        onClick={() => onChange("home")}
        aria-current={screen === "home" ? "page" : undefined}
      >
        <img
          src={asset(
            screen === "home"
              ? ASSET_MAP.NAV_HOME_ACTIVE
              : ASSET_MAP.NAV_HOME_INACTIVE
          )}
          alt=""
        />
        {screen === "home" && <span>Home</span>}
      </button>

      {/* Search */}
      <button
        className={screen === "search" ? "nav-active" : "nav-icon"}
        onClick={() => onChange("search")}
        aria-current={screen === "search" ? "page" : undefined}
        aria-label="Search"
      >
        <img src={asset(ASSET_MAP.NAV_SEARCH)} alt="" />
        {screen === "search" && <span>Search</span>}
      </button>

      {/* Statistics */}
      <button
        className={screen === "statistics" ? "nav-active" : "nav-icon"}
        onClick={() => onChange("statistics")}
        aria-current={screen === "statistics" ? "page" : undefined}
        aria-label="Statistics"
      >
        <img
          src={asset(
            screen === "statistics"
              ? ASSET_MAP.NAV_STATISTICS_ACTIVE
              : ASSET_MAP.NAV_STATISTICS_INACTIVE
          )}
          alt=""
        />
        {screen === "statistics" && <span>Statistics</span>}
      </button>

      {/* Leaderboard */}
      <button
        className={screen === "leaderboard" ? "nav-active" : "nav-icon"}
        onClick={() => onChange("leaderboard")}
        aria-current={screen === "leaderboard" ? "page" : undefined}
        aria-label="Leaderboard"
      >
        <svg
          className="leaderboard-icon"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          aria-hidden="true"
        >
          <path d="M4 19V13.5C4 12.672 4.672 12 5.5 12H8V19" />
          <path d="M8 19V7.5C8 6.672 8.672 6 9.5 6H14.5C15.328 6 16 6.672 16 7.5V19" />
          <path d="M16 19V11.5C16 10.672 16.672 10 17.5 10H20V19" />
          <path d="M3 19H21" />
          <path d="M10.25 10.25L11.5 11.5L14 9" />
        </svg>
        {screen === "leaderboard" && <span>Ranks</span>}
      </button>

      {/* Profile */}
      <button
        className={screen === "profile" ? "nav-active" : "nav-icon"}
        onClick={() => onChange("profile")}
        aria-current={screen === "profile" ? "page" : undefined}
        aria-label="Profile"
      >
        <img src={asset(ASSET_MAP.NAV_PROFILE)} alt="" />
        {screen === "profile" && <span>Profile</span>}
      </button>
    </nav>
  );
}
