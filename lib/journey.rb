class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MINIMUM_FARE = 1


  def start_journey(entry_station = Station.new)
    @entry_station = entry_station.name
  end

  def end_journey(exit_station)
    @exit_station = exit_station.name
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    !!@entry_station && !!@exit_station
  end
end
