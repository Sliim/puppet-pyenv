require 'spec_helper'

describe 'pyenv::install', :type => :define do
  let(:user)   { 'tester' }
  let(:title)  { "pyenv::install::#{user}" }
  let(:params) { {:user => user} }

  context 'install pyenv' do
    it "clones pyenv from the official repository" do
      should contain_exec("pyenv::checkout #{user}").
        with_command("git clone https://github.com/yyuu/pyenv.git /home/#{user}/.pyenv")
    end

    it "appends in a rc file, a command to include .pyenv/bin folder in PATH env variable" do
      should contain_exec("pyenv::shrc #{user}").
        with_command("echo 'source /home/#{user}/.pyenvrc' >> /home/#{user}/.profile").
        with_path(['/bin','/usr/bin','/usr/sbin'])
    end
  end
end
