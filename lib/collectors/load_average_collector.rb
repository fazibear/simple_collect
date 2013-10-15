class LoadAverageCollector
  include DataMapper::Resource

  storage_names[:default] = "load_average"

  property :id,         Serial
  property :name,       String
  property :created_at, DateTime

  property 'load_1',    String
  property 'load_5',    String
  property 'load_15',   String

  COMMAND = 'cat /proc/loadavg'
  REGEXP = /\A([0-9\.]+)\s+([0-9\.]+)\s+([0-9\.]+)\s+([0-9\/]+)\s+([0-9]+)\n\z/
  
  def parse(data)
    result = data.match(REGEXP)
    {
      :name => @name,
      :created_at => Time.now,
      
      'load_1' => result[1],
      'load_5' => result[2],
      'load_15' => result[3]
    }
  end
  
  def collect!(executor)
    @name = executor.name
    result = executor.exec(COMMAND)
    data = parse(result)
    self.class.create(data)
  end
end
