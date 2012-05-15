module TaskMapper::Provider
  module Unfuddle
    # Ticket class for taskmapper-unfuddle
    #
    
    class Ticket < TaskMapper::Provider::Base::Ticket
      API = UnfuddleAPI::Ticket # The class to access the api's tickets
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
          super first.attributes.merge! :project_id => first.prefix_options[:project_id]
        end
      end

      def title
        self.summary
      end
      
      def created_at
        @created_at ||= self[:created_at] ? Time.parse(self[:created_at]) : nil
      end
      
      def updated_at
        @updated_at ||= self[:updated_at] ? Time.parse(self[:updated_at]) : nil
      end
      
      def assignee
        @assignee ||= begin
          UnfuddleAPI::People.find(self[:assignee_id]).username
          rescue
          ''
          end
      end
      
      def requestor
        @requestor ||= begin
          UnfuddleAPI::People.find(self[:reporter_id]).username
          rescue
          ''
          end
      end
      
    end
  end
end
