require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Unfuddle::Project do
  before(:all) do
    @headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/xml'}
    @headers_post_put = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Content-Type' => 'application/xml'}
  end
  let(:project_id) { 33041 }
  let(:taskmapper) { TaskMapper.new(:unfuddle, {:username => 'foo', :password => '000000', :account => 'taskmapper'}) }
  let(:project_class) { TaskMapper::Provider::Unfuddle::Project }

  describe "Retrieving projects" do 
    before(:each) do 
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api/v1/projects.xml', @headers, fixture_for('projects'), 200
        mock.get '/api/v1/projects/33041.xml', @headers, fixture_for('projects/33041'), 200
      end
    end

    context "when calling #projects to an instance of taskmapper" do 
      subject { taskmapper.projects } 
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
    end

    context "when calling #projects with an array of id's" do 
      subject { taskmapper.projects([project_id]) }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
      it { subject.first.id.should be_eql project_id }
    end

    context "when calling #projects with a hash attributes" do 
      subject { taskmapper.projects(:id => project_id) }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
      it { subject.first.id.should be_eql project_id }
    end
  end

  describe "Retrieving a single project" do 
    context "when calling #project with an id" do 
      subject { taskmapper.project project_id }
      it { should be_an_instance_of project_class }
      it { subject.id.should be_eql project_id }
    end

    context "when calling #project with hash attributes" do 
      subject { taskmapper.project :id => project_id } 
      it { should be_an_instance_of project_class }
      it { subject.id.should be_eql project_id }
    end
  end

  describe "Update and create" do 
    context "when calling #save" do 
      pending 
    end
  end
end
