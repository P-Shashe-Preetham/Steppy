import { asset, ASSET_MAP } from "../../constants/assets";

interface PeriodChipProps {
  label?: string;
  onClick?: () => void;
}

export function PeriodChip({ label = "Weekly", onClick }: PeriodChipProps) {
  return (
    <button className="period-chip" onClick={onClick}>
      {label} <img src={asset(ASSET_MAP.CHEVRON_DOWN)} alt="" />
    </button>
  );
}
