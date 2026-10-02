import { asset, ASSET_MAP } from "../../constants/assets";

export function ActivityChart() {
  return (
    <div className="activity-chart" aria-label="Weekly activities visual timeline">
      <div className="hours">
        <span>5h</span>
        <span>4h</span>
        <span>3h</span>
        <span>2h</span>
        <span>1h</span>
      </div>
      <div className="chart-art">
        <img src={asset(ASSET_MAP.CHART_GRID)} alt="" />
        <img className="chart-fill" src={asset(ASSET_MAP.CHART_FILL)} alt="" />
        <img className="chart-line" src={asset(ASSET_MAP.CHART_LINE)} alt="" />
      </div>
    </div>
  );
}
