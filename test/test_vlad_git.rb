require 'minitest/autorun'
require 'vlad'
require 'vlad/git'
require 'mocha'

class TestVladGit < MiniTest::Unit::TestCase
  def setup
    super
    @scm = Vlad::Git.new
    @scm.stubs(:fast_checkout_applicable?).returns(false)

    @scm_fast = Vlad::Git.new
    @scm_fast.stubs(:fast_checkout_applicable?).returns(true)

    set :repository, "git@myhost:/home/john/project1"
  end

  # Checkout the way the default :update task invokes the method
  def test_checkout
    cmd = @scm.checkout 'head', '/the/scm/path'
    assert_equal 'rm -rf /the/scm/path/repo && git clone git@myhost:/home/john/project1 /the/scm/path/repo && cd /the/scm/path/repo && git submodule init && git submodule update && git checkout -f -b deployed-HEAD HEAD && cd -', cmd
  end

  # (fast-mode) Checkout the way the default :update task invokes the method
  def test_checkout_fast
    cmd = @scm_fast.checkout 'head', '/the/scm/path'
    assert_equal 'cd /the/scm/path/repo && git checkout -q origin && git fetch && git reset --hard origin && git submodule init && git submodule update && git branch -f deployed-HEAD HEAD && git checkout deployed-HEAD && cd -', cmd
  end

  # This is not how the :update task invokes the method
  def test_checkout_revision
    # Checkout to the current directory
    cmd = @scm.checkout 'master', '.'
    assert_equal 'rm -rf ./repo && git clone git@myhost:/home/john/project1 ./repo && cd ./repo && git submodule init && git submodule update && git checkout -f -b deployed-master master && cd -', cmd

    # Checkout to a relative path
    cmd = @scm.checkout 'master', 'some/relative/path'
    assert_equal 'rm -rf some/relative/path/repo && git clone git@myhost:/home/john/project1 some/relative/path/repo && cd some/relative/path/repo && git submodule init && git submodule update && git checkout -f -b deployed-master master && cd -', cmd
  end

    # (fast-mode) This is not how the :update task invokes the method
  def test_checkout_revision_fast
    # Checkout to the current directory
    cmd = @scm_fast.checkout 'master', '.'
    assert_equal 'cd ./repo && git checkout -q origin && git fetch && git reset --hard master && git submodule init && git submodule update && git branch -f deployed-master master && git checkout deployed-master && cd -', cmd

    cmd = @scm_fast.checkout 'master', 'some/relative/path'
    assert_equal 'cd some/relative/path/repo && git checkout -q origin && git fetch && git reset --hard master && git submodule init && git submodule update && git branch -f deployed-master master && git checkout deployed-master && cd -', cmd
  end

  def test_export
    # default mode
    cmd = @scm.export 'master', 'the/release/path'
    assert_equal "mkdir -p the/release/path && cd repo && git archive --format=tar deployed-master | (cd the/release/path && tar xf -) && git submodule foreach 'git archive --format=tar \$sha1 | (cd the/release/path/\$path && tar xf -)' && cd - && cd ..", cmd
  end

  def test_revision
    ['head', 'HEAD'].each do |head|
      cmd = @scm.revision(head)
      expected = "`git rev-parse HEAD`"
      assert_equal expected, cmd
    end
  end
end

