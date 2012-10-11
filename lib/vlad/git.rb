class Vlad::Git

  # Duh.
  VERSION = "2.2.0"

  set :source,  Vlad::Git.new
  set :git_cmd, "git"
  set :revision, "master" ##This can be either branch, tag or git-commit

  # Returns the command that will check out +revision+ from the
  # repository into directory +destination+.  +revision+ can be any
  # SHA1 or equivalent (e.g. branch, tag, etc...)

  def checkout(revision, destination)
    destination = File.join(destination, 'repo')
    depth = is_commit_id?(revision) ? "0" : "1"
    [ "rm -rf #{destination}",
      "#{git_cmd} clone --depth=#{depth} #{repository} #{destination}",
      "cd #{destination}",
      "#{git_cmd} checkout -q #{revision}",
      submodule_cmd,
      "cd -"
    ].join(" && ")
  end

  # Returns the command that will export +revision+ from the current
  # directory into the directory +destination+. Expects to be run
  # from +scm_path+ after Vlad::Git#checkout.

  def export(revision, destination)
    [ "mkdir -p #{destination}",
      "cd repo",
      "#{git_cmd} archive --format=tar #{revision} | (cd #{destination} && tar xf -)",
      "#{git_cmd} submodule foreach '#{git_cmd} archive --format=tar $sha1 | (cd #{destination}/$path && tar xf -)'",
      "cd -",
      "cd .."
    ].join(" && ")
  end

  # Returns a command that maps human-friendly revision identifier
  # +revision+ into a git SHA1.

  def revision(revision)
    "`#{git_cmd} rev-parse #{revision}`"
  end

  private

  def is_commit_id?(revision)
    revision.match(/^[0-9a-f]{6,40}$/) ? true : false
  end

  def submodule_cmd
    "#{git_cmd} submodule sync && #{git_cmd} submodule update --init --recursive"
  end
end
