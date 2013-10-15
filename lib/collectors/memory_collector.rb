class MemoryCollector
  include DataMapper::Resource

  storage_names[:default] = "memory"

  property :id,         Serial
  property :name,       String
  property :created_at, DateTime

  property :total,      Integer
  property :used,       Integer
  property :free,       Integer
  property :shared,     Integer
  property :buffers,    Integer
  property :cached,     Integer
  
  COMMAND = 'free'
  REGEXP = /\AMem:\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\z/
  
  def parse(data)
    lines = data.split("\n")
    result = lines[1].match(REGEXP)
    {
      :name => @name,
      :created_at => Time.now,
      
      :total => result[1],
      :used => result[2],
      :free => result[3],
      :shared => result[4],
      :buffers => result[5],
      :cached => result[6]
    }
  end

  def collect!(executor)
    @name = executor.name
    result = executor.exec(COMMAND)
    data = parse(result)
    self.class.create(data)
  end

end
