require 'spec_helper'
require 'puppet/util/execution_stub'

def merge_recursively(a, b)
  a.merge(b) {|key, a_item, b_item| merge_recursively(a_item, b_item) }
end

def stub_execution(result_expected, args_expected = {})
  Puppet::Util::ExecutionStub.set do |command, args|
    # /bin/su path depends of the system, we don't assert it.
    command[0] = '/bin/su'
    command_line = command.join(' ')

    if command_line != result_expected
      fail "Unexpected command #{command_line} executed, needed #{result_expected}"
    else
      begin
        Puppet::Util::Execution::ProcessOutput.new('', 1)
      rescue
        ''
      end
    end
  end
end

describe Puppet::Type.type(:pip).provider(:default) do

  let(:resource) { Puppet::Type.type(:pip).new({:name => 'yoda', :user => 'got'}) }
  let(:provider) { resource.provider }

  describe 'installing' do
    context 'when install package' do
      it 'should execute pip install yoda with ensure installed' do
        resource[:ensure] = 'installed'
        command_expected = "/bin/su - got -c pip install yoda"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install mock' do
        resource[:package] = 'mock'
        command_expected = "/bin/su - got -c pip install mock"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install yoda>=1.0.0' do
        resource[:package_version] = '>=1.0.0'
        command_expected = "/bin/su - got -c pip install yoda>=1.0.0"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install with pyenv_root path' do
        resource[:pyenv_root] = '/home/got/.pyenv'
        command_expected = "/bin/su - got -c /home/got/.pyenv/shims/pip install yoda"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install with python_version path' do
        resource[:python_version] = '2.7.5'
        command_expected = "/bin/su - got -c PYENV_VERSION=2.7.5 pip install yoda"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install multiple packages from array' do
        resource[:package] = [ 'yoda', 'nosetests', 'mock' ]
        command_expected = "/bin/su - got -c pip install yoda nosetests mock"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install multiple packages with package version' do
        resource[:package] = [ 'yoda', 'nosetests', 'mock' ]
        resource[:package_version] = [ '==1.0.0', '==2.1.0', '==3.2.1' ]
        command_expected = "/bin/su - got -c pip install yoda==1.0.0 nosetests==2.1.0 mock==3.2.1"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install multiple packages with some versions specified' do
        resource[:package] = [ 'yoda', 'nosetests', 'mock' ]
        resource[:package_version] = [ '==1.0.0' ]
        command_expected = "/bin/su - got -c pip install yoda==1.0.0 nosetests mock"
        stub_execution(command_expected)
        provider.install().should eq('')
      end

      it 'should execute pip install multiple packages with too many package version specified' do
        resource[:package] = [ 'yoda', 'nosetests', 'mock' ]
        resource[:package_version] = [ '==1.0.0', '==2.1.0', '==3.2.1', '==3.2.2' ]
        command_expected = "/bin/su - got -c pip install yoda==1.0.0 nosetests==2.1.0 mock==3.2.1"
        stub_execution(command_expected)
        provider.install().should eq('')
      end
    end
  end

  describe 'uninstalling' do
    context 'when uninstall -y package' do
      it 'should execute pip uninstall -y yoda with ensure purged' do
        resource[:ensure] = 'purged'
        command_expected = "/bin/su - got -c pip uninstall -y yoda"
        stub_execution(command_expected)
        provider.uninstall().should eq('')
      end

      it 'should execute pip uninstall -y mock' do
        resource[:package] = 'mock'
        command_expected = "/bin/su - got -c pip uninstall -y mock"
        stub_execution(command_expected)
        provider.uninstall().should eq('')
      end

      it 'should execute pip uninstall -y yoda with user' do
        resource[:user] = 'sliim'
        command_expected = "/bin/su - sliim -c pip uninstall -y yoda"
        stub_execution(command_expected)
        provider.uninstall().should eq('')
      end

      it 'should execute pip uninstall -y with pyenv_root path' do
        resource[:pyenv_root] = '/home/got/.pyenv'
        command_expected = "/bin/su - got -c /home/got/.pyenv/shims/pip uninstall -y yoda"
        stub_execution(command_expected)
        provider.uninstall().should eq('')
      end

      it 'should execute pip uninstall -y with python version' do
        resource[:python_version] = '2.7.5'
        command_expected = "/bin/su - got -c PYENV_VERSION=2.7.5 pip uninstall -y yoda"
        stub_execution(command_expected)
        provider.uninstall().should eq('')
      end
    end
  end

  describe 'updating' do
    context 'when updating package' do
      it 'should execute pip install --upgrade yoda' do
        command_expected = "/bin/su - got -c pip install --upgrade yoda"
        stub_execution(command_expected)
        provider.update().should eq('')
      end

      it 'should execute pip install --upgrade mock' do
        resource[:package] = 'mock'
        command_expected = "/bin/su - got -c pip install --upgrade mock"
        stub_execution(command_expected)
        provider.update().should eq('')
      end

      it 'should execute pip install --upgrade yoda with user' do
        resource[:user] = 'sliim'
        command_expected = "/bin/su - sliim -c pip install --upgrade yoda"
        stub_execution(command_expected)
        provider.update().should eq('')
      end

      it 'should execute pip install --upgrade with pyenv_root path' do
        resource[:pyenv_root] = '/home/got/.pyenv'
        command_expected = "/bin/su - got -c /home/got/.pyenv/shims/pip install --upgrade yoda"
        stub_execution(command_expected)
        provider.update().should eq('')
      end

      it 'should execute pip install --upgrade with python_version' do
        resource[:python_version] = '2.7.5'
        command_expected = "/bin/su - got -c PYENV_VERSION=2.7.5 pip install --upgrade yoda"
        stub_execution(command_expected)
        provider.update().should eq('')
      end
    end
  end
end
