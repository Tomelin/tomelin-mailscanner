#Install dependencies and mailscanner this module
class mailscanner::install(

	$pkg_perl = [ 'Archive::Tar','Archive::Zip','Carp','Compress::Raw::Zlib','Convert::BinHex','Convert::TNEF','Data::Dumper','Digest::HMAC','Digest::MD5','Digest::SHA1','ExtUtils::MakeMaker','File::Copy::Recursive','File::Path','File::Spec::Native','File::Temp','FileHandle::Unget','Filesys::Df','IO::Handle::Util::tests','IO::Pipely','IO::stringy','HTML::Entities::Numbered','HTML::Parser','HTML::Tagset','Mail::IMAPClient','Math::BigInt::GMP','MIME::tools','Net::CIDR','Net::DNS','Net::IP','OLE::Storage_Lite','Pod::Escapes','Pod::Simple','POSIX::strptime','Socket','Storable','Test::Pod','Test::Simple','Time::HiRes','Sys::Hostname::Long','Sys::SigAction','Sys::Syslog','Env','File::ShareDir::Install','Business::ISBN','Business::ISBN::Data','Data::Dump','DB_File','DBD::SQLite','DBI','Digest','Encode::Detect','Error','ExtUtils::CBuilder','ExtUtils::ParseXS','Getopt::Long','Inline','IO::String','IO::Zlib','Mail::SPF','Module::Build','Net::CIDR::Lite','Net::DNS::Resolver::Programmable','NetAddr::IP','Parse::RecDescent','Test::Harness','Test::Manifest','URI','Version::Requirements','bignum','Compress::Zlib','Date::Parse','DirHandle','Fcntl','File::Basename','File::Copy','Inline::C','IO','IO::File','IO::Pipe','HTML:Entities:Numbered','HTML::TokeParser','Mail::Field','Mail::Header','Mail::Internet','MIME::Base64','MIME::Decoder','MIME::Decoder::UU','MIME::Head','MIME::Parser','MIME::QuotedPrint','MIME::WordDecoder','POSIX','Scalar::Util','Time::localtime','IP::Country','IO::Compress::Bzip2','Mail::ClamAV','Mail::SpamAssassin','Mail::SpamAssassin::Plugin::DCC','Mail::SpamAssassin::Plugin::Pyzor','Mail::SpamAssassin::Plugin::Rule2XSBody','Mail::SPF::Query','Math::BigInt','Math::BigRat','Net::LDAP','Net::Server','Razor2::Client::Agent'],

	$pkg = ['vim','bash-completion','binutils','gcc','glibc-devel','libaio','make','man-pages','man-pages-overrides','patch','rpm','tar','time','unzip','which','zip','libtool-ltdl','perl','curl','wget','openssl','openssl-devel','bzip2-devel','tnef','unar','perl-CPAN','perl-core'],

) {


	include perl

	package { 'epel-release': 
		ensure => present,
	}

	package { $pkg:
		ensure => present,
		require => Package['epel-release'],
	}

  if $::facts['mailscanner']['installed'] == false {
	  perl::perl_modules { $pkg_perl:
		  ensure => 'present',
		  use_package => 'false',
		  require => Package['perl-CPAN'],
	  }->

	  file{'/tmp/MailScanner-5.0.3-7.noarch.rpm':
  		ensure => file,
  		source => 'puppet:///modules/mailscanner/MailScanner-5.0.3-7.noarch.rpm',
  	}->

	  package { 'MailScanner-5.0.3-7.noarch.rpm':
  		ensure => present,
  		source => '/tmp/MailScanner-5.0.3-7.noarch.rpm',
  		require => File['/tmp/MailScanner-5.0.3-7.noarch.rpm'],
  		provider => 'rpm',
  	}
  }

	file {'/etc/MailScanner/spamassassin':
		ensure => 'directory',
	}
}
