define mailscanner::resource::config (

  Enum['present','absent','blank']  $ensure = 'present',
  $value  = undef,
  $path   = '/etc/MailScanner/MailScanner.conf',

  ){

    case $ensure {
      'present': {
        $line = "${title} = '${value}'"
      }
      'absent': {
        $line = "#${title} = '${value}'"
      }
      'blank': {
        $line = "#${title} = "
      }
      default: {
        fail "Unknown value for ensure '${ensure}'"
      }
    }

    file_line { "manage MailScanner '${title}'":
      path    => $path,
      line    => $line,
      match   => "^${title}.*$",
    }
}
