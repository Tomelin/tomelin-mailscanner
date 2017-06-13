Puppet::Functions.create_function(:'mailscanner::packageinstall')
#    newfunction(:package_install)
	    #packageName = args[0]
	    #installed = system "rpm -q  args[0]"
	    #installed
	    #return args[0]
	    b = system("rpm --quiet -q  #{args[0]}")
	    b
end
