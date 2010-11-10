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
      
      def author
        @author ||= begin
          UnfuddleAPI::People.find(self.author_id).username
          rescue ActiveResource::UnauthorizedAccess
          ''
          end
      end
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def project_id
        self.prefix_options[:project_id]
      end
      
      def ticket_id
        self.prefix_options[:ticket_id]
      end
      
    end
  end
end
