import { asset, ASSET_MAP } from "../../constants/assets";
import { UpcomingActivity } from "../../types";

interface UpcomingCardProps {
  activity: UpcomingActivity;
}

export function UpcomingCard({ activity }: UpcomingCardProps) {
  const isWorkout = activity.artType === "workout";

  return (
    <article
      className={`upcoming-card ${isWorkout ? "workout-card" : "pushups-card"}`}
    >
      <div className="card-copy">
        <div className="card-heading">
          <h3>{activity.title}</h3>
          <span
            className={`chip ${activity.category === "Fitness" ? "fitness" : "warmup"}`}
          >
            {activity.category}
          </span>
        </div>
        <p>{activity.scheduledTime}</p>
      </div>

      {activity.location && (
        <div className="card-location">
          <img src={asset(ASSET_MAP.LOCATION_PIN_SM)} alt="" />
          <span>{activity.location}</span>
        </div>
      )}

      {isWorkout ? (
        <div className="workout-art" aria-hidden="true">
          <img
            className="runner"
            src={asset(ASSET_MAP.WORKOUT_RUNNER)}
            alt=""
          />
          <img
            className="treadmill"
            src={asset(ASSET_MAP.WORKOUT_TREADMILL)}
            alt=""
          />
        </div>
      ) : (
        <img
          className="pushups-art"
          src={asset(ASSET_MAP.PUSHUPS_ART)}
          alt=""
          aria-hidden="true"
        />
      )}
    </article>
  );
}
