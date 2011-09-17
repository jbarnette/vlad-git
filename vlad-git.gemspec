# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vlad-git}
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Barnette", "Aaron Suggs"]
  s.date = %q{2011-09-17}
  s.description = %q{Vlad plugin for Git support. This was previously part of Vlad, but all
modules outside the core recipe have been extracted.}
  s.email = ["code@jbarnette.com", "aaron@ktheory.com"]
  s.extra_rdoc_files = ["Manifest.txt", "CHANGELOG.rdoc", "README.rdoc"]
  s.files = [".autotest", "CHANGELOG.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "lib/vlad/git.rb", "test/test_vlad_git.rb"]
  s.homepage = %q{http://github.com/jbarnette/vlad-git}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{vlad-git}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Vlad plugin for Git support}
  s.test_files = ["test/test_vlad_git.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vlad>, [">= 2.1.0"])
      s.add_development_dependency(%q<hoe>, ["~> 2.12"])
    else
      s.add_dependency(%q<vlad>, [">= 2.1.0"])
      s.add_dependency(%q<hoe>, ["~> 2.12"])
    end
  else
    s.add_dependency(%q<vlad>, [">= 2.1.0"])
    s.add_dependency(%q<hoe>, ["~> 2.12"])
  end
end
