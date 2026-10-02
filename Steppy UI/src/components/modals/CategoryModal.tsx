import { useApp } from "../../context/AppContext";

export function CategoryModal() {
  const { activeModal, closeModal, user, syncSteps, showToast } = useApp();

  if (activeModal !== "categories") return null;

  return (
    <div className="modal-backdrop" onClick={closeModal}>
      <div className="modal-sheet" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h3>Categories & Preferences</h3>
          <button className="modal-close-btn" onClick={closeModal}>
            ✕
          </button>
        </div>

        <div className="modal-content">
          <div className="pref-section">
            <h4>Quick Step Simulator</h4>
            <p className="pref-sub">
              Test walking steps without real sensors to see XP, progress rings, and coin rewards update!
            </p>
            <div className="quick-step-buttons">
              <button
                className="step-btn"
                onClick={() => {
                  syncSteps(500);
                }}
              >
                +500 Steps
              </button>
              <button
                className="step-btn"
                onClick={() => {
                  syncSteps(1500);
                }}
              >
                +1,500 Steps
              </button>
              <button
                className="step-btn highlight"
                onClick={() => {
                  syncSteps(3000);
                }}
              >
                +3,000 Steps 🔥
              </button>
            </div>
          </div>

          <div className="pref-section">
            <h4>Workout Types</h4>
            <div className="category-tags">
              <span className="cat-tag active">All Workouts</span>
              <span className="cat-tag">Running & Cardio</span>
              <span className="cat-tag">Calisthenics</span>
              <span className="cat-tag">Strength & Weights</span>
              <span className="cat-tag">Recovery & Yoga</span>
            </div>
          </div>

          <div className="pref-section">
            <h4>Daily Target Goal</h4>
            <p className="pref-sub">Current: {user.dailyGoal.toLocaleString()} steps / day</p>
            <div className="goal-options">
              {[6000, 8000, 10000, 12000, 15000].map((goal) => (
                <button
                  key={goal}
                  className={`goal-btn ${user.dailyGoal === goal ? "selected" : ""}`}
                  onClick={() => {
                    user.dailyGoal = goal;
                    showToast(`Updated daily goal to ${goal.toLocaleString()} steps!`);
                    closeModal();
                  }}
                >
                  {(goal / 1000).toFixed(0)}k
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
