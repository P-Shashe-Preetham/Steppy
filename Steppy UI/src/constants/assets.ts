/**
 * Semantic Asset Dictionary for Steppy UI
 * Maps human-readable asset identifiers to their respective SVG filenames in `/assets/`.
 */

export const ASSET_MAP = {
  // Navigation Icons
  NAV_HOME_ACTIVE: "d47bd",
  NAV_HOME_INACTIVE: "9601f",
  NAV_SEARCH: "e48e2",
  NAV_STATISTICS_ACTIVE: "db141",
  NAV_STATISTICS_INACTIVE: "62d1b",
  NAV_PROFILE: "18f8d",

  // Header & Controls
  ICON_BUTTON_BG: "895bb",
  CATEGORIES_MENU: "0a3f5",
  MESSAGES: "577d9",
  NOTIFICATIONS: "ad7ec",
  CHEVRON_DOWN: "e1e8e",

  // Home Screen - Upcoming Workouts
  LOCATION_PIN_SM: "8e04c",
  WORKOUT_RUNNER: "d5d13",
  WORKOUT_TREADMILL: "ce1f6",
  PUSHUPS_ART: "b655e",

  // Home Screen - Nearby Gyms
  LOCATION_PIN_MD: "89227",
  GYM_HOURS_CLOCK: "84f1d",
  GYM_DISTANCE_PIN: "dbfca",
  GYM_RATING_STAR: "b53cd",

  // Home Screen - Activities Chart
  CHART_GRID: "347cc",
  CHART_FILL: "94ffb",
  CHART_LINE: "965b5",

  // Statistics Screen - Overview Metrics
  OVERVIEW_CALORIES_BG: "5f776",
  OVERVIEW_CALORIES_ICON: "1160a",
  OVERVIEW_TIME_BG: "14e45",
  OVERVIEW_TIME_ICON: "b1ac0",
  OVERVIEW_EXERCISES_BG: "870e9",

  // Statistics Screen - Progress Concentric Rings
  PROGRESS_RING_OUTER_SLEEP: "6df69",
  PROGRESS_RING_MID_CALORIES: "84b3d",
  PROGRESS_RING_INNER_STEPS: "8febf",
} as const;

export type AssetKey = keyof typeof ASSET_MAP;

export const asset = (nameOrKey: string): string => {
  // If a known key was passed, resolve it; otherwise treat as direct filename
  const filename = (ASSET_MAP as Record<string, string>)[nameOrKey] || nameOrKey;
  return `/assets/${filename}.svg`;
};
