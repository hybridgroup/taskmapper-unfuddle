module TaskMapper::Provider
  module Unfuddle
    # The comment class for taskmapper-unfuddle
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      API = UnfuddleAPI::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
      def initialize(*options) 
        @system_data ||= {}
        @cache ||= {}
        first = options.shift
        case first
        when Hash
          super first.to_hash
        else
          @system_data[:client] = first
          super first.attributes.merge!(
                      :project_id => first.prefix_options[:project_id],
                      :ticket_id => first.prefix_options[:ticket_id])
        end
      end

      def author
        @author ||= begin
          UnfuddleAPI::People.find(self[:author_id]).username
          rescue
          ''
          end
      end
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
    end
  end
end
