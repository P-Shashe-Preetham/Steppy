import { asset, ASSET_MAP } from "../../constants/assets";
import { useApp } from "../../context/AppContext";

export function ProgressRings() {
  const { user } = useApp();
  const calories = Math.round(user.todaySteps * 0.04);

  return (
    <section className="content-section progress-section">
      <h2>Daily progress</h2>
      <div className="progress-content">
        <div className="rings" aria-label="Daily goal progress rings">
          <img
            src={asset(ASSET_MAP.PROGRESS_RING_OUTER_SLEEP)}
            alt="Sleep ring"
          />
          <img
            src={asset(ASSET_MAP.PROGRESS_RING_MID_CALORIES)}
            alt="Calories ring"
          />
          <img
            src={asset(ASSET_MAP.PROGRESS_RING_INNER_STEPS)}
            alt="Steps ring"
          />
        </div>
        <dl className="progress-legend">
          <div>
            <dt>
              <i className="sleep-dot" />
              Sleep
            </dt>
            <dd>6h 5min/8h</dd>
          </div>
          <div>
            <dt>
              <i className="calories-dot" />
              Calories
            </dt>
            <dd>{calories.toLocaleString()}/2000 kcal</dd>
          </div>
          <div>
            <dt>
              <i className="steps-dot" />
              Steps
            </dt>
            <dd>{user.todaySteps.toLocaleString()}/{user.dailyGoal.toLocaleString()}</dd>
          </div>
        </dl>
      </div>
    </section>
  );
}
