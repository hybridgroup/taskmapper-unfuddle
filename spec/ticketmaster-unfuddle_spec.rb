require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Unfuddle" do

  it "should be able to instantiate a new instance" do
    @ticketmaster = TicketMaster.new(:unfuddle, {:account => 'ticketmaster', :username => 'foo', :password => '000000'})
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Unfuddle)
  end

  it "should allow to use SSL" do
    @ticketmaster = TicketMaster.new(:unfuddle, {:account => 'ticketmaster', :username => 'foo', :password => '000000', :protocol => 'https'})
    @ticketmaster.provider::TICKET_API.site.should be_an_instance_of(URI::HTTPS)
    @ticketmaster.provider::PROJECT_API.site.should be_an_instance_of(URI::HTTPS)
  end
end
