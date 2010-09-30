module TicketMaster::Provider
  # This is the Unfuddle Provider for ticketmaster
  module Unfuddle
    include TicketMaster::Provider::Base
    TICKET_API = UnfuddleAPI::Ticket # The class to access the api's tickets
    PROJECT_API = UnfuddleAPI::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Unfuddle.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:unfuddle, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.account.nil? or auth.username.nil? or auth.password.nil?
        raise "Please provide at least an account (subdomain), username and password)"
      end
      UnfuddleAPI.account = auth.account || auth.subdomain
      UnfuddleAPI.authenticate(auth.username, auth.password)
    end
    
    # declare needed overloaded methods here
    
  end
end


