class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @status = nil
  end

  def on_journey?
    @status
  end

  def start_journey(entry_station = Station.new)
    @status = true
    @entry_station = entry_station.name
  end

  def end_journey(exit_station)
    @status = false
    @exit_station = exit_station.name
  end

  def fare
    @entry_station == nil || @exit_station == nil ? PENALTY_FARE : MINIMUM_FARE
  end
end
