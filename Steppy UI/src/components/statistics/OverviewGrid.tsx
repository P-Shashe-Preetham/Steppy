import { asset } from "../../constants/assets";
import { useApp } from "../../context/AppContext";
import { ASSET_MAP } from "../../constants/assets";

export function OverviewGrid() {
  const { user } = useApp();

  const calories = Math.round(user.todaySteps * 0.04);
  const totalMins = Math.round(user.todaySteps / 80);
  const hours = Math.floor(totalMins / 60);
  const mins = totalMins % 60;
  const timeFormatted = `${hours}h ${mins}min`;

  return (
    <section className="content-section overview">
      <h2>Overview</h2>
      <div className="overview-grid">
        <article className="overview-card">
          <div className="metric-icon">
            <img src={asset(ASSET_MAP.OVERVIEW_CALORIES_BG)} alt="" />
            <img src={asset(ASSET_MAP.OVERVIEW_CALORIES_ICON)} alt="" />
          </div>
          <strong>{calories.toLocaleString()}</strong>
          <span>Cal Burnt</span>
        </article>

        <article className="overview-card">
          <div className="metric-icon">
            <img src={asset(ASSET_MAP.OVERVIEW_TIME_BG)} alt="" />
            <img src={asset(ASSET_MAP.OVERVIEW_TIME_ICON)} alt="" />
          </div>
          <strong>{timeFormatted}</strong>
          <span>Total Time</span>
        </article>

        <article className="overview-card">
          <div className="metric-icon">
            <img src={asset(ASSET_MAP.OVERVIEW_EXERCISES_BG)} alt="" />
          </div>
          <strong>15</strong>
          <span>Exercises</span>
        </article>
      </div>
    </section>
  );
}
