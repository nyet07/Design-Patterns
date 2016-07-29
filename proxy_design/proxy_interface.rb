class ProxyInterface
  def initialize
    #This is a hook method. If needed, it can be overridden.
  end

  def __makeRequest
    raise "Abstract method called."
  end

  def processInfo
    raise "Abstract method called."
  end
end