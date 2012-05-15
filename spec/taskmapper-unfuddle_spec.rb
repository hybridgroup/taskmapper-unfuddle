require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapper::Provider::Unfuddle" do
  before(:each) do 
    @taskmapper = TaskMapper.new(:unfuddle, {:account => 'taskmapper', :username => 'foo', :password => '000000'})
    headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects.xml', headers, fixture_for('projects'), 200
    end
  end

  it "should be able to instantiate a new instance" do
    
    @taskmapper.should be_an_instance_of(TaskMapper)
    @taskmapper.should be_a_kind_of(TaskMapper::Provider::Unfuddle)
  end

  it "should allow to use SSL" do
    @taskmapper = TaskMapper.new(:unfuddle, {:account => 'taskmapper', :username => 'foo', :password => '000000', :protocol => 'https'})
    @taskmapper.provider::TICKET_API.site.should be_an_instance_of(URI::HTTPS)
    @taskmapper.provider::PROJECT_API.site.should be_an_instance_of(URI::HTTPS)
  end

  it "should return true for a valid authentication" do 
    @taskmapper.valid?.should be_true
  end
end
