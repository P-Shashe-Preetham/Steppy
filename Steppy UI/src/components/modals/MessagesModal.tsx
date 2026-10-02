import { useState } from "react";
import { useApp } from "../../context/AppContext";

const INITIAL_CHATS = [
  { id: "c1", name: "Sarah Walker", lastMsg: "Hey! Ready for today's 10k walk?", time: "12:30 PM", unread: true },
  { id: "c2", name: "Alex Runner", lastMsg: "You passed me on the leaderboard! 👏", time: "Yesterday", unread: false },
  { id: "c3", name: "Fitness Group Kraków", lastMsg: "Meeting at Starowiślna 12 tomorrow 8am", time: "Oct 24", unread: false },
];

export function MessagesModal() {
  const { activeModal, closeModal, showToast } = useApp();
  const [messages, setMessages] = useState(INITIAL_CHATS);

  if (activeModal !== "messages") return null;

  return (
    <div className="modal-backdrop" onClick={closeModal}>
      <div className="modal-sheet" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h3>Community Messages</h3>
          <button className="modal-close-btn" onClick={closeModal}>
            ✕
          </button>
        </div>

        <div className="modal-content">
          <div className="chat-list">
            {messages.map((chat) => (
              <div
                key={chat.id}
                className="chat-item"
                onClick={() => {
                  showToast(`Opened chat with ${chat.name}`);
                  setMessages((prev) =>
                    prev.map((c) => (c.id === chat.id ? { ...c, unread: false } : c))
                  );
                }}
              >
                <div className="chat-avatar">
                  {chat.name.split(" ").map((n) => n[0]).join("")}
                </div>
                <div className="chat-info">
                  <div className="chat-row">
                    <strong>{chat.name}</strong>
                    <span className="chat-time">{chat.time}</span>
                  </div>
                  <p>{chat.lastMsg}</p>
                </div>
                {chat.unread && <span className="chat-unread-dot" />}
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
