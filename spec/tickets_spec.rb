require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Unfuddle::Ticket" do
  before(:all) do
    headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects/33041.xml', headers, fixture_for('projects/33041'), 200
      mock.get '/api/v1/projects/33041/tickets.xml', headers, fixture_for('tickets'), 200
      mock.get '/api/v1/projects/33041/tickets/476816.xml', headers, fixture_for('tickets/476816'), 200
      mock.put '/api/v1/projects/33041/tickets/476816.xml', headers_post_put, '', 200
      mock.post '/api/v1/projects/33041/tickets.xml', headers_post_put, fixture_for('tickets/create'), 200
    end
    @project_id = 33041
  end
  
  before(:each) do
    @ticketmaster = TicketMaster.new(:unfuddle, :account => 'ticketmaster', :username => 'foo', :password => '000000')
    @project = @ticketmaster.project(@project_id)
    @klass = TicketMaster::Provider::Unfuddle::Ticket
  end
  
  it "should be able to load all tickets" do
    @project.tickets.should be_an_instance_of(Array)
    @project.tickets.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load all tickets based on an array of ids" do
    @tickets = @project.tickets([476816])
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.id.should == 476816
  end
  
  it "should be able to load all tickets based on attributes" do
    @tickets = @project.tickets(:id => 476816)
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.id.should == 476816
  end
  
  it "should return the ticket class" do
    @project.ticket.should == @klass
  end
  
  it "should be able to load a single ticket" do
    @ticket = @project.ticket(476816)
    @ticket.should be_an_instance_of(@klass)
    @ticket.id.should == 476816
  end
  
  it "should be able to load a single ticket based on attributes" do
    @ticket = @project.ticket(:id => 476816)
    @ticket.should be_an_instance_of(@klass)
    @ticket.id.should == 476816
  end
  
  it "should be able to update and save a ticket" do
    @ticket = @project.ticket(476816)
    @ticket.save.should == nil
    @ticket.description = 'hello'
    @ticket.save.should == true
  end
  
  it "should be able to create a ticket" do
    @ticket = @project.ticket!(:title => 'Ticket #12', :description => 'Body')
    @ticket.should be_an_instance_of(@klass)
  end
  
end
