Puppet::Type.newtype(:pip) do
  desc 'Install pip packages inside a Pyenv setup'

  ensurable do
    newvalue(:present, :event => :package_installed) do
      provider.install
    end

    newvalue(:absent, :event => :package_removed) do
      provider.uninstall
    end

    newvalue(:latest, :event => :package_installed) do
      provider.update
    end

    aliasvalue(:installed, :present)
    aliasvalue(:purged, :absent)
    defaultto(:present)

    def retrieve
      provider.query[:ensure]
    end

    def insync?(is)
      @should.each { |should|
        case should
        when :present
          return true unless is == :absent
        when :absent
          return true if is == :absent
        when *Array(is)
          return true
        end
      }
      false
    end
  end

  newparam(:name) do
    desc 'Package qualified name withing an pyenv repository'
    isrequired
    validate do |value|
      raise ArgumentError, 'Empty values are not allowed' if value == ''
    end
  end

  newparam(:package) do
    desc 'Package name, can be an Array for multiple package installation'

    defaultto do
      @resource[:name]
    end
  end

  newparam(:package_version) do
    desc 'Force the package to specific version, for multiple package this param can be an Array'
  end

  newparam(:python_version) do
    desc 'Use specific version of Python'
  end

  newparam(:user) do
    desc 'The pyenv user'
    isrequired
  end

  newparam(:pyenv_root) do
    desc 'Defined the path to pyenv directory'
  end
end
