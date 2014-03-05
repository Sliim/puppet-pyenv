require 'spec_helper'

describe 'pyenv::dependencies' do
  let(:title) { 'pyenv::dependencies' }

  context 'Debian' do
    let(:facts) { {:osfamily => 'debian'} }
    it { should contain_class('pyenv::dependencies::debian') }
  end
end
