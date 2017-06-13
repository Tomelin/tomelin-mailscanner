define mailscanner::resource::configfile (

  Enum['present','absent','blank']  $ensure = 'present',
  $source   = undef,
  $content  = undef,
  $path     = "/etc/MailScanner/${title}",
  $mode     = '0644',
  $options  = {},
  ){

    if $source and $content {
      fail 'You must provide either \'source\' or \'content\', not both'
    }

    $manage_content = $content ? {
      undef   => $source ? {
        undef   => template('mailscanner/conffile.erb'),
        default => undef,
      },
      default => $content,
    }

    file { "MailScanner conffile ${title}":
      ensure  => $ensure,
      path    => $path,
      mode    => $mode,
      owner   => 'root',
      group   => 'root',
      source  => $source,
      content => $manage_content,
    }
}
