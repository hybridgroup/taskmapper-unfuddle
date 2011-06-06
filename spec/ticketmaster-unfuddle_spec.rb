require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Unfuddle" do
  before(:each) do 
    @ticketmaster = TicketMaster.new(:unfuddle, {:account => 'ticketmaster', :username => 'foo', :password => '000000'})
    headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects.xml', headers, fixture_for('projects'), 200
    end
  end

  it "should be able to instantiate a new instance" do
    
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Unfuddle)
  end

  it "should allow to use SSL" do
    @ticketmaster = TicketMaster.new(:unfuddle, {:account => 'ticketmaster', :username => 'foo', :password => '000000', :protocol => 'https'})
    @ticketmaster.provider::TICKET_API.site.should be_an_instance_of(URI::HTTPS)
    @ticketmaster.provider::PROJECT_API.site.should be_an_instance_of(URI::HTTPS)
  end

  it "should return true for a valid authentication" do 
    @ticketmaster.valid?.should be_true
  end
end
