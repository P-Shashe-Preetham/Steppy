import { useApp } from "../../context/AppContext";

export function Toast() {
  const { toast } = useApp();
  if (!toast) return null;

  return (
    <div className="steppy-toast" role="status" aria-live="polite">
      <span className="toast-icon">✨</span>
      <span>{toast}</span>
    </div>
  );
}
