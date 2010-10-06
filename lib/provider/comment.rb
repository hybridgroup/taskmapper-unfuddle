module TicketMaster::Provider
  module Unfuddle
    # The comment class for ticketmaster-unfuddle
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      API = UnfuddleAPI::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
    end
  end
end
