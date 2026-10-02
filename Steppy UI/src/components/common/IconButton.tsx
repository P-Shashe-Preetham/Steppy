import { asset, ASSET_MAP } from "../../constants/assets";

interface IconButtonProps {
  icon: string;
  label: string;
  notification?: boolean;
  onClick?: () => void;
}

export function IconButton({
  icon,
  label,
  notification,
  onClick,
}: IconButtonProps) {
  return (
    <button className="icon-button" aria-label={label} onClick={onClick}>
      <img src={asset(ASSET_MAP.ICON_BUTTON_BG)} alt="" className="icon-button-bg" />
      <img src={asset(icon)} alt="" />
      {notification && <span className="notification-dot" />}
    </button>
  );
}
