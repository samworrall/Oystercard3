class Journey

  def initialize
    @status = nil
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

end
