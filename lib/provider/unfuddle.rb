module TaskMapper::Provider
  # This is the Unfuddle Provider for taskmapper
  module Unfuddle
    include TaskMapper::Provider::Base
    TICKET_API = UnfuddleAPI::Ticket # The class to access the api's tickets
    PROJECT_API = UnfuddleAPI::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Unfuddle.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:unfuddle, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth = @authentication
      if (auth.account.nil? and auth.subdomain.nil?) or auth.username.nil? or auth.password.nil?
        raise "Please provide at least an account (subdomain), username and password)"
      end
      UnfuddleAPI.protocol = auth.protocol if auth.protocol?
      UnfuddleAPI.account = auth.account || auth.subdomain
      UnfuddleAPI.authenticate(auth.username, auth.password)
    end
    
    # declare needed overloaded methods here
    
    def valid?
      begin 
        PROJECT_API.find(:first)
        true
      rescue
        false
      end
    end
  end
end


