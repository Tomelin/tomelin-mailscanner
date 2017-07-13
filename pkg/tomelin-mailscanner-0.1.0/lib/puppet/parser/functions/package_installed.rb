require"puppet"
module Puppet::Parser::Functions
  newfunction(:package_installed, :type => :rvalue) do |args|
    packageName = args[0]
    return system "rpm --quiet -q #{packageName}"
  end
end
