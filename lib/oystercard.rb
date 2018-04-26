class Oystercard
  attr_reader :balance, :journey_log, :current_journey
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(current_journey = Journey.new)
    @balance = 0
    @journey_log = []
    @current_journey = current_journey
  end

  def top_up(amount)
    fail "Max balance is #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @current_journey.on_journey? #refactor later
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    deduct(6) if in_journey?
    @current_journey.start_journey(entry_station)
  end

  def touch_out(station_2)
    deduct(MINIMUM_FARE)
    @current_journey.end_journey
    @station_2 = station_2
    @journey_log.push({@station => @station_2})
    @station = nil

  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
