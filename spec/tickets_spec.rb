require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Unfuddle::Ticket do
  before(:each) do
    @headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    @headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api/v1/projects/33041.xml', @headers, fixture_for('projects/33041'), 200
    end
    @project = taskmapper.project project_id 
  end
  let(:taskmapper) { TaskMapper.new(:unfuddle, :account => 'taskmapper', :username => 'foo', :password => '000000') }
  let(:project_id) { 33041 }
  let(:ticket_id) { 476816 }
  let(:ticket_class) { TaskMapper::Provider::Unfuddle::Ticket }

  describe "Retrieving tickets" do 
    before(:each) do 
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api/v1/projects/33041/tickets.xml', @headers, fixture_for('tickets'), 200
        mock.get '/api/v1/projects/33041/tickets/476816.xml', @headers, fixture_for('tickets/476816'), 200
      end
    end

    context "when calling #tickets to a project instance" do 
      subject { @project.tickets } 
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of ticket_class }
    end

    context "when calling #tickets with an array of id's" do 
      subject { @project.tickets [ticket_id] }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of ticket_class }
      it { subject.first.id.should be_eql ticket_id }
    end

    context "when calling #tickets with a hash attributes" do 
      subject { @project.tickets :id => ticket_id }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of ticket_class }
      it { subject.first.id.should be_eql ticket_id }
    end
  end

  describe "Retrieving a single ticket" do 
    before(:each) do 
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api/v1/projects/33041/tickets.xml', @headers, fixture_for('tickets'), 200
        mock.get '/api/v1/projects/33041/tickets/476816.xml', @headers, fixture_for('tickets/476816'), 200
      end
    end

    context "when calling #ticket with a ticket_id" do 
      subject { @project.ticket ticket_id } 
      it { should be_an_instance_of ticket_class }
      it { subject.id.should be_eql ticket_id }
    end

    context "when calling #ticket with a attributes" do 
      subject { @project.ticket :id => ticket_id }
      it { should be_an_instance_of ticket_class }
      it { subject.id.should be_eql ticket_id }
    end
  end

  describe "Update and create" do 
    context "when calling #save" do 
      pending
    end

    context "when calling #ticket!" do 
      pending
    end
  end
  
end
