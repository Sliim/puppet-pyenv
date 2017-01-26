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

    it "adds a line to the rc file, a command to include .pyenv/bin folder in PATH env variable" do
      should contain_file_line("pyenv::shrc #{user}").
        with_line("source /home/#{user}/.pyenvrc").
        with_path("/home/#{user}/.profile")
    end
  end
end
