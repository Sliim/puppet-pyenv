Puppet::Type.type(:exec).provide :bash, :parent => :shell do
  include Puppet::Util::Execution

  commands :su => 'su'
  desc <<-EOS
    Run command with /bin/bash interpreter
  EOS

  def run(command, check = false)
    puts 'Run bash command `' + command + '`'
    output = su('-', resource[:user], '-c', command)
    return output, output
  end
end
