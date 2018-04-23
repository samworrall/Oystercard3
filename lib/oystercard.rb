class Oystercard

  attr_reader :balance, :station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
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

  def touch_out
    deduct(MINIMUM_FARE)
    @station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
