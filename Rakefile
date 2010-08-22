require "rubygems"
require "hoe"

Hoe.plugins.delete :rubyforge
Hoe.plugin :doofus, :git

Hoe.spec "vlad-git" do
  developer "John Barnette", "code@jbarnette.com"
  developer "Aaron Suggs", "aaron@ktheory.com"

  self.extra_rdoc_files = FileList["*.rdoc"]
  self.history_file     = "CHANGELOG.rdoc"
  self.readme_file      = "README.rdoc"
  self.testlib          = :minitest
  self.extra_deps       << ["vlad", ">= 2.1.0"]
end
