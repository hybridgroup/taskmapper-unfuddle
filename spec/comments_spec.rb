require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Unfuddle::Comment" do
  before(:all) do
    headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects/33042.xml', headers, fixture_for('projects/33042'), 200
      mock.get '/api/v1/projects/33042/tickets.xml', headers, fixture_for('tickets'), 200
      mock.get '/api/v1/projects/33042/tickets/476834.xml', headers, fixture_for('tickets/476834'), 200
      mock.put '/api/v1/projects/33042/tickets/476834.xml', headers_post_put, '', 200
      mock.get '/api/v1/projects/33042/tickets/476834/comments.xml', headers, fixture_for('comments'), 200
      mock.get '/api/v1/projects/33042/tickets/476834/comments/0.xml', headers, fixture_for('comments/0'), 200
      mock.get '/api/v1/projects/33042/tickets/476834/comments/2.xml', headers, fixture_for('comments/2'), 200
      mock.get '/api/v1/projects/33042/tickets/476834/comments/3.xml', headers, fixture_for('comments/3'), 200
      mock.put '/api/v1/projects/33042/tickets/476834/comments/0.xml', headers_post_put, '', 200
      mock.post '/api/v1/projects/33042/tickets/476834/comments.xml', headers_post_put, fixture_for('comments/create'), 200
    end
    @project_id = 33042
    @ticket_id = 476834
  end
  
  before(:each) do
    @ticketmaster = TicketMaster.new(:unfuddle, :account => 'ticketmaster', :password => '000000', :username => 'foo')
    @project = @ticketmaster.project(@project_id)
    @ticket = @project.ticket(@ticket_id)
    @ticket.project_id = @project.id
    @klass = TicketMaster::Provider::Unfuddle::Comment
  end
  
  it "should be able to load all comments" do
    @comments = @ticket.comments
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load all comments based on 'id's" do
    @comments = @ticket.comments([0,2,3])
    @comments.should be_an_instance_of(Array)
    @comments.first.id.should == 0
    @comments.last.id.should == 3
    @comments[1].should be_an_instance_of(@klass)
  end
  
  it "should be able to load all comments based on attributes" do
    @comments = @ticket.comments(:parent_id => @ticket.id)
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load a comment based on id" do
    @comment = @ticket.comment(2)
    @comment.should be_an_instance_of(@klass)
    @comment.id.should == 2
  end
  
  it "should be able to load a comment based on attributes" do
    @comment = @ticket.comment(:parent_id => @ticket.id)
    @comment.should be_an_instance_of(@klass)
  end
  
  it "should return the class" do
    @ticket.comment.should == @klass
  end
  
  it "should be able to create a comment" do
    @comment = @ticket.comment!(:body => 'New comment created.', :body_format => 'markdown')
    @comment.should be_an_instance_of(@klass)
  end
end
