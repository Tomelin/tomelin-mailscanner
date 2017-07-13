define mailscanner::resource::config (

  Enum['present','absent','blank']  $ensure = 'present',
  $value  = undef,
  $path   = '/etc/MailScanner/MailScanner.conf',

  ){

    case $ensure {
      'present': {
        $line = "${title} = '${value}'"
        $changes = "set ${name} '${value}'"
      }
      'absent': {
        $line = "#${title} = '${value}'"
        $changes = "rm ${name}"
      }
      'blank': {
        $line = "#${title} = "
        $changes = "clear ${name}"
      }
      default: {
        fail "Unknown value for ensure '${ensure}'"
      }
    }

/*
  augeas { "manage postfix '${title}'":
    incl    => '/etc/MailScanner/MailScanner.conf',
    lens    => 'mailscanner.aug',
    changes => $changes,
#    require => File['/etc/postfix/main.cf'],
  }
*/

    file_line { "manage MailScanner '${title}'":
      path    => $path,
      line    => $line,
      match   => "^${title}.*$",
    }

}
