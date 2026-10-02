import { useApp } from "../../context/AppContext";

export function RewardStoreModal() {
  const { activeModal, closeModal, user, rewards, redeemReward } = useApp();

  if (activeModal !== "rewards") return null;

  return (
    <div className="modal-backdrop" onClick={closeModal}>
      <div className="modal-sheet" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <div>
            <h3>Rewards Store</h3>
            <span className="balance-pill">Balance: {user.coins} 🪙 Coins</span>
          </div>
          <button className="modal-close-btn" onClick={closeModal}>
            ✕
          </button>
        </div>

        <div className="modal-content">
          <div className="rewards-grid">
            {rewards.map((reward) => {
              const canAfford = user.coins >= reward.cost;
              return (
                <div
                  key={reward.id}
                  className={`reward-item-card ${reward.redeemed ? "redeemed" : ""}`}
                >
                  <span className="reward-icon">{reward.icon}</span>
                  <strong>{reward.name}</strong>
                  <p>{reward.description}</p>
                  <div className="reward-bottom">
                    <span className="reward-cost">{reward.cost} 🪙</span>
                    <button
                      className="redeem-btn"
                      disabled={reward.redeemed || !canAfford}
                      onClick={() => redeemReward(reward.id)}
                    >
                      {reward.redeemed ? "Redeemed ✓" : canAfford ? "Redeem" : "Locked 🔒"}
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}
