require'journey'

class Oystercard
  attr_reader :balance, :station, :station_2, :journey_log, :current_journey
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
    @current_journey.on_journey?
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @current_journey.start_journey
    @station = station
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
