import { PeriodChip } from "../common/PeriodChip";
import { WEEKLY_CALORIES } from "../../data/mockData";

export function CaloriesChart() {
  return (
    <section className="content-section calories-section">
      <div className="section-heading">
        <h2>Calories</h2>
        <PeriodChip label="Weekly" />
      </div>

      <div className="bar-chart" aria-label="Weekly calories chart">
        {WEEKLY_CALORIES.map((item, index) => (
          <div className="bar-track" key={index}>
            <span style={{ height: `${item.height}%` }} />
          </div>
        ))}
      </div>

      <div className="chart-days">
        {WEEKLY_CALORIES.map((item) => (
          <span key={item.day}>{item.day}</span>
        ))}
      </div>
    </section>
  );
}
