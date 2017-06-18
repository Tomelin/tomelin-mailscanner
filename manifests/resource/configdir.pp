define mailscanner::resource::configdir (

  Enum['present','absent']  $ensure = 'present',
  $source   = undef,
  $content  = undef,
  $path,
  $mode     = '0644',
  ){

    if $source and $content {
      fail 'You must provide either \'source\' or \'content\', not both'
    }

    if $ensure == 'present' {
	$ensure = 'directory',
    }

    file { "Create directory ${title} for MailScanner":
      ensure  => $ensure,
      path    => $path,
      mode    => $mode,
      owner   => 'root',
      group   => 'root',
    }
}
