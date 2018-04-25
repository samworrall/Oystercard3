class Journey

  attr_reader :entry_station, :exit_station



  def initialize(entry_station, exit_station)
    @status = nil
    @entry_station = entry_station
    @exit_station = exit_station

  end

  def on_journey?
    @status
  end

  def start_journey
    @status = true
  end

  def end_journey
    @status = false
  end

  def fare
   1 unless @entry_station == nil || @exit_station == nil
   6
  end

end
