import { useState } from "react";
import { GymCard } from "../components/home/GymCard";
import { asset, ASSET_MAP } from "../constants/assets";
import { useApp } from "../context/AppContext";

type FilterType = "all" | "saved" | "close" | "open24";

export function SearchScreen() {
  const { gyms, showToast } = useApp();
  const [query, setQuery] = useState("");
  const [filter, setFilter] = useState<FilterType>("all");

  const filteredGyms = gyms.filter((g) => {
    const matchesQuery =
      g.name.toLowerCase().includes(query.toLowerCase()) ||
      g.distance.toLowerCase().includes(query.toLowerCase());

    if (!matchesQuery) return false;

    if (filter === "saved") return g.isBookmarked;
    if (filter === "close") return g.distance.includes("meters");
    if (filter === "open24") return g.hours.includes("24/7");

    return true;
  });

  return (
    <main className="screen search-screen">
      <h1>Explore & Search</h1>

      {/* Search Input Bar */}
      <div className="search-bar-wrapper">
        <img
          src={asset(ASSET_MAP.NAV_SEARCH)}
          alt=""
          className="search-input-icon"
        />
        <input
          type="text"
          className="search-input"
          placeholder="Search gyms, workouts, locations..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        {query && (
          <button
            className="clear-search-btn"
            onClick={() => setQuery("")}
            title="Clear search"
          >
            ✕
          </button>
        )}
      </div>

      {/* Filter Tabs */}
      <div className="search-filter-pills">
        <button
          className={`filter-pill ${filter === "all" ? "active" : ""}`}
          onClick={() => setFilter("all")}
        >
          All Locations
        </button>
        <button
          className={`filter-pill ${filter === "saved" ? "active" : ""}`}
          onClick={() => setFilter("saved")}
        >
          ★ Saved ({gyms.filter((g) => g.isBookmarked).length})
        </button>
        <button
          className={`filter-pill ${filter === "close" ? "active" : ""}`}
          onClick={() => setFilter("close")}
        >
          Walking Distance
        </button>
        <button
          className={`filter-pill ${filter === "open24" ? "active" : ""}`}
          onClick={() => setFilter("open24")}
        >
          Open 24/7
        </button>
      </div>

      {/* Results */}
      <section className="content-section">
        <div className="section-heading">
          <h2>Nearby Locations</h2>
          <span className="results-count">{filteredGyms.length} found</span>
        </div>

        {filteredGyms.length === 0 ? (
          <div className="empty-search-state">
            <span>🔍</span>
            <p>No gyms match your search or filter.</p>
            <button
              className="reset-filter-btn"
              onClick={() => {
                setQuery("");
                setFilter("all");
              }}
            >
              Reset Filters
            </button>
          </div>
        ) : (
          <div className="gym-grid" style={{ gridTemplateColumns: "1fr" }}>
            {filteredGyms.map((gym) => (
              <div key={gym.id} className="search-gym-item">
                <GymCard gym={gym} />
                <button
                  className="gym-directions-btn"
                  onClick={() =>
                    showToast(`Starting navigation to ${gym.name} 📍`)
                  }
                >
                  Get Directions ↗
                </button>
              </div>
            ))}
          </div>
        )}
      </section>
    </main>
  );
}
