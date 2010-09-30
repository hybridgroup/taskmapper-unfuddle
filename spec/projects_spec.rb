require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Unfuddle::Project" do
  before(:all) do
    headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
    @project_id = 33041
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects.xml', headers, fixture_for('projects'), 200
      mock.get '/api/v1/projects/33041.xml', headers, fixture_for('projects/33041'), 200
      mock.get '/api/v1/projects/create.xml', headers, fixture_for('projects/create'), 200
      mock.delete '/api/v1/projects/33041.xml', headers, '', 200
      mock.put '/api/v1/projects/33041.xml', headers_post_put, '', 200
      mock.post '/api/v1/projects.xml', headers_post_put, '', 201, 'Location' => '/projects/create.xml'
      mock.get '/api/v1/projects/33041/tickets.xml', headers, fixture_for('tickets'), 200
    end
  end
  
  before(:each) do
    @ticketmaster = TicketMaster.new(:unfuddle, {:username => 'foo', :password => '000000', :account => 'ticketmaster'})
    @klass = TicketMaster::Provider::Unfuddle::Project
  end
  
  it "should be able to load all projects" do
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load projects from an array of ids" do
    @projects = @ticketmaster.projects([@project_id])
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == @project_id
  end
  
  it "should be able to load all projects from attributes" do
    @projects = @ticketmaster.projects(:id => @project_id)
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == @project_id
  end
  
  it "should be able to find a project" do
    @ticketmaster.project.should == @klass
    @ticketmaster.project.find(@project_id).should be_an_instance_of(@klass)
  end
  
  it "should be able to find a project by id" do
    @ticketmaster.project(@project_id).should be_an_instance_of(@klass)
    @ticketmaster.project(@project_id).id.should == @project_id
  end
  
  it "should be able to find a project by attributes" do
    @ticketmaster.project(:id => @project_id).id.should == @project_id
    @ticketmaster.project(:id => @project_id).should be_an_instance_of(@klass)
  end
  
  it "should be able to update and save a project" do
    @project = @ticketmaster.project(@project_id)
    @project.save.should == nil
    @project.update!(:short_name => 'some new name').should == true
    @project.short_name = 'this is a change'
    @project.save.should == true
  end
  
  it "should be able to create a project" do
    @project = @ticketmaster.project.create(:name => 'Project #1')
    @project.should be_an_instance_of(@klass)
  end

end
