#Install dependencies and mailscanner this module
class mailscanner::install(

	$pkg = ['vim','bash-completion','gcc','glibc-devel','libaio','make','man-pages','man-pages-overrides','patch','rpm','tar','time','unzip','which','zip','libtool-ltdl','perl','curl','wget','openssl','openssl-devel','bzip2-devel','tnef','unar','perl-CPAN','perl-core', 'cpp','binutils','zlib','zlib-devel','automake','pyzor'],
) {

	require epel 
	require mailscanner::perl

        if $::facts['mailscanner']['installed'] != true {

	  file{'/tmp/MailScanner-5.0.3-7.noarch.rpm':
  		ensure => file,
  		source => 'puppet:///modules/mailscanner/MailScanner-5.0.3-7.noarch.rpm',
  	  }->

	  package { 'MailScanner-5.0.3-7.noarch.rpm':
  		ensure => present,
  		source => '/tmp/MailScanner-5.0.3-7.noarch.rpm',
  		require => File['/tmp/MailScanner-5.0.3-7.noarch.rpm'],
    		install_options => ['--nodeps'],
  		provider => 'rpm',
  	  } ->

          file {'/etc/MailScanner/spamassassin':
		ensure => 'directory',
	  } 

	 Class[ '::mailscanner::service' ]


        }
}
