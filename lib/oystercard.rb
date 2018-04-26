class Oystercard
  attr_reader :balance, :journey_log, :journey
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_log = []
    @journey = journey
  end

  def top_up(amount)
    fail "Max balance is #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    if @journey.entry_station != nil
      deduct(@journey.fare)
      @journey_log << ({:entry_station => @journey.entry_station, :exit_station => @journey.exit_station})
    end
    @journey.start_journey(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.end_journey(station)
    @journey_log << ({:entry_station => @journey.entry_station, :exit_station => @journey.exit_station})
    @station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
