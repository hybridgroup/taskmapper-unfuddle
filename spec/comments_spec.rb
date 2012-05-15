require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Unfuddle::Comment do
  before(:each) do
    @headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    @headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects/33042.xml', @headers, fixture_for('projects/33042'), 200
      mock.get '/api/v1/projects/33042/tickets/476834.xml', @headers, fixture_for('tickets/476834'), 200
    end
    @project = taskmapper.project(project_id)
    @ticket = @project.ticket(ticket_id)
  end
  let(:project_id) { 33042 }
  let(:ticket_id) { 476834 }
  let(:taskmapper) { TaskMapper.new(:unfuddle, :account => 'taskmapper', :password => '000000', :username => 'foo') }
  let(:comment_class) { TaskMapper::Provider::Unfuddle::Comment }

  describe "Retrieving all comments" do 
    before(:each) do 
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api/v1/projects/33042/tickets/476834/comments.xml', @headers, fixture_for('comments'), 200
        mock.get '/api/v1/projects/33042/tickets/476834/comments/0.xml', @headers, fixture_for('comments/0'), 200
        mock.get '/api/v1/projects/33042/tickets/476834/comments/2.xml', @headers, fixture_for('comments/2'), 200
        mock.get '/api/v1/projects/33042/tickets/476834/comments/3.xml', @headers, fixture_for('comments/3'), 200
      end
    end

    context "when calling #comments to a ticket instance" do 
      subject { @ticket.comments } 
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of comment_class }
    end

    context "when calling #comments with an array of id's" do 
      subject { @ticket.comments([0,2,3]) }
      it { should be_an_instance_of Array }
      it { subject.first.id.should be_eql 0 }
      it { subject.last.id.should be_eql 3 }
    end

    context "when calling #comments with a hash of attributes" do 
      subject { @ticket.comments :parent_id => @ticket.id } 
      it { should be_an_instance_of Array } 
      it { subject.first.should be_an_instance_of comment_class }
      it { subject.first.id.should be_eql 2 }
    end
  end

  describe "Retrieve a single comment" do 
    before(:each) do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api/v1/projects/33042/tickets/476834/comments/0.xml', @headers, fixture_for('comments/0'), 200
        mock.get '/api/v1/projects/33042/tickets/476834/comments.xml', @headers, fixture_for('comments'), 200
      end
    end

    context "when calling #comment with an id" do 
      subject { @ticket.comment 0 }
      it { should be_an_instance_of comment_class }
      it { subject.id.should be_eql 0 }
    end

    context "when calling #comment with an attribute hash" do 
      subject { @ticket.comment :parent_id => @ticket.id }
      it { should be_an_instance_of comment_class }
      it { subject.id.should be_eql 2 }
    end
  end
  
  it "should be able to create a comment" do
    pending
    @comment = @ticket.comment!(:body => 'New comment created.', :body_format => 'markdown')
    @comment.should be_an_instance_of(@klass)
  end
end
