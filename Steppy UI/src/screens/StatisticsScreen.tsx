import { CalendarSection } from "../components/statistics/CalendarSection";
import { OverviewGrid } from "../components/statistics/OverviewGrid";
import { ProgressRings } from "../components/statistics/ProgressRings";
import { CaloriesChart } from "../components/statistics/CaloriesChart";

export function StatisticsScreen() {
  return (
    <main className="screen statistics-screen">
      <h1>Statistics</h1>
      <CalendarSection />
      <OverviewGrid />
      <ProgressRings />
      <CaloriesChart />
    </main>
  );
}
