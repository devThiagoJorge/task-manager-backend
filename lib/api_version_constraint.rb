class ApiVersionConstraint
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
    end

    def matches?(req) #return true or false
       @default || req.headers['Accept'].include?("application/api.taskmanager.v#{@version}")
    end
    
    
end