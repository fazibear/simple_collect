class LocalhostExecutor
  
  def initialize(name)
    @name = name
  end
  
  def exec(command)
    `#{command}`
  end

  def name
    name
  end
end
