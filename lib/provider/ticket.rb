module TicketMaster::Provider
  module Unfuddle
    # Ticket class for ticketmaster-unfuddle
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = UnfuddleAPI::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      
    end
  end
end
