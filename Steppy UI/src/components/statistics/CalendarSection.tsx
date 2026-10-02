import { CALENDAR_DATES, WEEKDAYS } from "../../data/mockData";
import { useApp } from "../../context/AppContext";

export function CalendarSection() {
  const { selectedDate, setSelectedDate, showToast } = useApp();

  const handleSelectDate = (date: number) => {
    setSelectedDate(date);
    showToast(`Viewing activity for June ${date}, 2022`);
  };

  return (
    <section className="calendar-section">
      <p>June 2022</p>
      <div className="calendar">
        <div className="calendar-row weekdays">
          {WEEKDAYS.map((day, index) => (
            <span key={`${day}-${index}`}>{day}</span>
          ))}
        </div>
        <div className="calendar-row dates">
          {CALENDAR_DATES.map((date) => (
            <button
              key={date}
              onClick={() => handleSelectDate(date)}
              className={date === selectedDate ? "selected-date" : ""}
            >
              {date}
            </button>
          ))}
        </div>
      </div>
    </section>
  );
}
