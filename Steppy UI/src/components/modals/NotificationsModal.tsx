import { useApp } from "../../context/AppContext";

export function NotificationsModal() {
  const { activeModal, closeModal, notifications, markAllNotificationsRead } = useApp();

  if (activeModal !== "notifications") return null;

  return (
    <div className="modal-backdrop" onClick={closeModal}>
      <div className="modal-sheet" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h3>Notifications</h3>
          <div className="modal-header-actions">
            <button
              className="modal-action-btn"
              onClick={markAllNotificationsRead}
            >
              Mark all read
            </button>
            <button className="modal-close-btn" onClick={closeModal}>
              ✕
            </button>
          </div>
        </div>

        <div className="modal-content">
          {notifications.length === 0 ? (
            <p className="empty-state">No new notifications.</p>
          ) : (
            notifications.map((n) => (
              <div
                key={n.id}
                className={`notif-card ${!n.read ? "notif-unread" : ""}`}
              >
                <div className="notif-header">
                  <strong>{n.title}</strong>
                  <span className="notif-time">{n.time}</span>
                </div>
                <p>{n.message}</p>
              </div>
            ))
          )}
        </div>
      </div>
    </div>
  );
}
