require 'spec_helper_acceptance'

describe 'pyenv class' do

  context 'default parameters' do
    it 'install should work with no errors' do
      pp = <<-EOS
      include pyenv
      pyenv::install { 'vagrant': }
      EOS

      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it 'compile should work with no errors' do
      pp = <<-EOS
      include pyenv
      pyenv::compile { 'compile 2.7.5 vagrant':
        user => 'vagrant',
        python => '2.7.5',
        global => true,
      }
      EOS

      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it 'pyenv version 2.7.5 directory must exists' do
      expect(on(master, 'ls /home/vagrant/.pyenv/versions/2.7.5').exit_code).to eq 0
    end

    it 'pyenv global version must be' do
      expect(on(master, 'cat /home/vagrant/.pyenv/version').stdout).to eq "2.7.5\n"
    end
  end
end
