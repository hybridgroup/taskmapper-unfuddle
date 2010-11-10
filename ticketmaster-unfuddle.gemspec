# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ticketmaster-unfuddle}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luis Hurtado"]
  s.date = %q{2010-11-09}
  s.description = %q{Unfuddle provider for ticketmaster implemented with ActiveResource}
  s.email = %q{luis@hybridgroup.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.md",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/provider/comment.rb",
     "lib/provider/project.rb",
     "lib/provider/ticket.rb",
     "lib/provider/unfuddle.rb",
     "lib/ticketmaster-unfuddle.rb",
     "lib/unfuddle/unfuddle-api.rb",
     "spec/comments_spec.rb",
     "spec/fixtures/comments.xml",
     "spec/fixtures/comments/0.xml",
     "spec/fixtures/comments/2.xml",
     "spec/fixtures/comments/3.xml",
     "spec/fixtures/comments/create.xml",
     "spec/fixtures/projects.xml",
     "spec/fixtures/projects/33041.xml",
     "spec/fixtures/projects/33042.xml",
     "spec/fixtures/projects/create.xml",
     "spec/fixtures/tickets.xml",
     "spec/fixtures/tickets/476814.xml",
     "spec/fixtures/tickets/476816.xml",
     "spec/fixtures/tickets/476834.xml",
     "spec/fixtures/tickets/create.xml",
     "spec/projects_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/ticketmaster-unfuddle_spec.rb",
     "spec/tickets_spec.rb",
     "ticketmaster-unfuddle.gemspec"
  ]
  s.homepage = %q{http://github.com/hybridgroup/ticketmaster-unfuddle}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{The Unfuddle provider for ticketmaster.}
  s.test_files = [
    "spec/comments_spec.rb",
     "spec/projects_spec.rb",
     "spec/spec_helper.rb",
     "spec/ticketmaster-unfuddle_spec.rb",
     "spec/tickets_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

