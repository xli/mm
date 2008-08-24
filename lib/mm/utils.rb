module MM
  module SimpleHashable
    def eql?(another)
      to_s == another.to_s
    end
    
    def hash
      to_s.hash
    end
  end
end
