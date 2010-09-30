require 'rubygems'

begin
  require 'uri'
  require 'addressable/uri'

  module URI
    def decode(*args)
      Addressable::URI.decode(*args)
    end

    def escape(*args)
      Addressable::URI.escape(*args)
    end

    def parse(*args)
      Addressable::URI.parse(*args)
    end
  end
rescue LoadError => e
  puts "Install the Addressable gem (with dependencies) to support accounts with subdomains."
  puts "# sudo gem install addressable --development"
  puts e.message
end

require 'active_support'
require 'active_resource'

# Ruby lib for working with the Unfuddle API's XML interface.
# The first thing you need to set is the account name.  This is the same
# as the web address for your account.
#
#   UnfuddleAPI.account = 'activereload'
#
# Then, you should set the authentication with HTTP Basic Authentication.
#
#   # with basic authentication
#   UnfuddleAPI.authenticate('rick', 'spacemonkey')
#
#
# This library is a small wrapper around the REST interface.  You should read the docs at
# http://unfuddle.com/docs/api
#
module UnfuddleAPI
  class Error < StandardError; end
  class << self
    attr_accessor :username, :password, :host_format, :domain_format, :protocol, :port
    attr_reader :account

    # Sets the account name, and updates all the resources with the new domain.
    def account=(name)
      resources.each do |klass|
        klass.site = klass.site_format % (host_format % [protocol, domain_format % name, ":#{port}"])
      end
      @account = name
    end

    # Sets up basic authentication credentials for all the resources.
    def authenticate(username, password)
      @username    = username
      @password = password
      self::Base.user = username
      self::Base.password = password
    end

    def resources
      @resources ||= []
    end
  end
  
  self.host_format   = '%s://%s%s/api/v1'
  self.domain_format = '%s.unfuddle.com'
  self.protocol      = 'http'
  self.port          = ''

  class Base < ActiveResource::Base
    def self.inherited(base)
      UnfuddleAPI.resources << base
      class << base
        attr_accessor :site_format
      end
      base.site_format = '%s'
      super
    end
  end
  
  # Find projects
  #
  #   UnfuddleAPI::Project.find(:all) # find all projects for the current account.
  #   UnfuddleAPI::Project.find(44)   # find individual project by ID
  #
  # Creating a Project
  #
  #   project = UnfuddleAPI::Project.new(:name => 'Ninja Whammy Jammy')
  #   project.save
  #   # => true
  #
  #
  # Updating a Project
  #
  #   project = UnfuddleAPI::Project.find(44)
  #   project.name = "Lighthouse Issues"
  #   project.public = false
  #   project.save
  #
  # Finding tickets
  # 
  #   project = LighthouseAPI::Project.find(44)
  #   project.tickets
  #
  class Project < Base
    def tickets(options = {})
      Ticket.find(:all, :params => options.update(:project_id => id))
    end
  
    def messages(options = {})
      Message.find(:all, :params => options.update(:project_id => id))
    end
  
    def milestones(options = {})
      Milestone.find(:all, :params => options.update(:project_id => id))
    end
  end

  # Find tickets
  #
  #  UnfuddleAPI::Ticket.find(:all, :params => { :project_id => 44 })
  #  UnfuddleAPI::Ticket.find(:all, :params => { :project_id => 44, :q => "status:closed" })
  #
  #  project = UnfuddleAPI::Project.find(44)
  #  project.tickets
  #  project.tickets(:q => "status:closed")
  #  project.tickets(:params => {:status => 'closed'})
  #
  #
  #
  class Ticket < Base
    site_format << '/projects/:project_id'
  end

  class Comment < Base
    site_format << '/projects/:project_id/tickets/:ticket_id'
  end
  
  class Message < Base
    site_format << '/projects/:project_id'
  end
  
end
