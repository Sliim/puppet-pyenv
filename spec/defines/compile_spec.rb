require 'spec_helper'

describe 'pyenv::compile', :type => :define do
  let(:user)         { 'tester' }
  let(:python_version) { '2.7.5' }
  let(:title)        { "pyenv::compile::#{user}::#{python_version}" }
  let(:dot_pyenv)    { "/home/#{user}/.pyenv" }
  let(:params)       { {:user => user, :python => python_version, :global => true} }

  it "installs python of the chosen version" do
    should contain_exec("pyenv::compile #{user} #{python_version}").
      with_command("pyenv install #{python_version}")
  end

  it "issues a rehash command" do
    should contain_exec("pyenv::rehash #{user} #{python_version}").
      with_command("pyenv rehash")
  end

  it "sets the global python version for the specific user" do
    should contain_file("pyenv::global #{user}").
      with_content("#{python_version}\n").
      with_require("Exec[pyenv::compile #{user} #{python_version}]")
  end
end
