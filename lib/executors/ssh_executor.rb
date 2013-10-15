class SshExecutor
  def initialize(name, host, user, password)
    @name = name
    @host = host
    @user = user
    @password = password
  end

  def exec(command)
    result = nil
    Net::SSH.start(@host, @user, :password => @password ) do |ssh|
      result = ssh.exec!(command)
    end
    result
  end 
  
  def name
    @name
  end
end
