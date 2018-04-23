class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Max balance is #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
