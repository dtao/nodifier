class Stopper
  def initialize
    @stopped = false
  end

  def stop!
    @stopped = true
  end

  def stopped?
    @stopped
  end
end