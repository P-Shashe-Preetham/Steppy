import { asset, ASSET_MAP } from "../../constants/assets";
import { Gym } from "../../types";
import { useApp } from "../../context/AppContext";

interface GymCardProps {
  gym: Gym;
}

export function GymCard({ gym }: GymCardProps) {
  const { toggleBookmark } = useApp();

  return (
    <article className="gym-card">
      <div className="gym-card-header">
        <h3>{gym.name}</h3>
        <button
          className="bookmark-btn"
          onClick={() => toggleBookmark(gym.id)}
          aria-label="Save gym"
          title={gym.isBookmarked ? "Remove bookmark" : "Bookmark gym"}
        >
          {gym.isBookmarked ? "★" : "☆"}
        </button>
      </div>
      <p>
        <img src={asset(ASSET_MAP.GYM_HOURS_CLOCK)} alt="Hours" />
        {gym.hours}
      </p>
      <p>
        <img src={asset(ASSET_MAP.GYM_DISTANCE_PIN)} alt="Distance" />
        {gym.distance}
      </p>
      <p>
        <img src={asset(ASSET_MAP.GYM_RATING_STAR)} alt="Rating" />
        {gym.rating.toFixed(1)}
      </p>
    </article>
  );
}
