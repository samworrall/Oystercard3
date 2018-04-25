class Oystercard

  attr_reader :balance, :station, :station_2, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1


  def initialize
    @balance = 0
    @journey_log = []
    
  end

  def top_up(amount)
    fail "Max balance is #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @station != nil
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @station = station
  end

  def touch_out(station_2)
    deduct(MINIMUM_FARE)
    @station_2 = station_2
    @journey_log.push({@station => @station_2})
    @station = nil

  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
