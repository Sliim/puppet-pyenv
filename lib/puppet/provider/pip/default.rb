require 'puppet/util/execution'

Puppet::Type.type(:pip).provide :default do
  desc "Maintains programs inside an Pyenv setup"

  commands :su => 'su'

  def install
    command = ['install']
    command << @resource[:package] + @resource[:package_version].to_s

    execute(command)
  end

  def uninstall
    command = ['uninstall', '-y', @resource[:package]]
    execute(command)
  end

  def update
    command = ['install', '--upgrade']
    command << @resource[:package]

    execute(command)
  end

  def pip
    if @resource[:pyenv_root].is_a? NilClass
      'pip'
    else
      "#{@resource[:pyenv_root]}/shims/pip"
    end
  end

  def query
    list().detect { |r|
      r[:package] == @resource[:package]
    } || {:ensure => :absent}
  end

  private
  def execute(command)
    command.unshift(pip)

    if !@resource[:python_version].is_a? NilClass
      command.unshift("PYENV_VERSION=#{resource[:python_version]}")
    end

    return su('-', @resource[:user], '-c', command.join(' '))
  end

  def list(options = {})
    command = ['freeze']
    packages = execute(command)
    Array.new.tap do |item|
      packages.split("\n").each do |package|
        match = /^(.*)==(.*)$/.match(package)
        item << {
          :package => match[1],
          :ensure  => match[2],
        }
      end
    end.compact
  end
end
