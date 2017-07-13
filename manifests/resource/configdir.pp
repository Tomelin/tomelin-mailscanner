define mailscanner::resource::configdir (

  Enum['directory','absent']  $ensure = 'directory',
  $path,
  $mode     = '0644',
  $owner    = 'root',
  $group    = 'root',
  ){

    if $source and $content {
      fail 'You must provide either \'source\' or \'content\', not both'
    }

    file { "Create directory ${title} for MailScanner":
      ensure  => $ensure,
      path    => $path,
      mode    => $mode,
      owner   => $owner,
      group   => $group,
    }
}
