Facter.add(:mailscanner) do

    setcode do

      confine :kernel => 'Linux'

      mailscanner = {}

      mailscanner_path = Facter::Core::Execution.exec('which MailScanner')
      if mailscanner_path == ""
       mailscanner_installed = false
      else
       mailscanner_installed = true
      end

      if mailscanner_installed
        distid = Facter.value(:osfamily)
        case distid
        when /RedHat|Suse/
            mailscanner_version = Facter::Core::Execution.exec('rpm -q --queryformat "%{VERSION}" MailScanner')
        when "Debian"
            mailscanner_version = Facter::Core::Execution.exec('dpkg-query -W -f=\'${Version}\' MailScanner')
        else
            mailscanner_version = 'Desconhecida'
        end
      end

      if mailscanner_installed
        postconf_tls_string = Facter::Core::Execution.exec('postconf smtpd_use_tls|awk \'{ print $3 }\'')
        if postconf_tls_string == 'yes'
          mailscanner_tls = true
        else
          mailscanner_tls = false
        end
      end

      if mailscanner_installed
        mailscanner_submission_check = Facter::Core::Execution.exec('cat /etc/postfix/master.cf |grep ^submission')
        if mailscanner_submission_check == ""
          mailscanner_submission = false
        else
          mailscanner_submission = true
        end
      end

      if mailscanner_tls
        mailscanner_crt_path = Facter::Core::Execution.exec('postconf smtpd_tls_cert_file|awk \'{ print $3 }\'')
        mailscanner_key_path = Facter::Core::Execution.exec('postconf smtpd_tls_key_file|awk \'{ print $3 }\'')
      end

      mailscanner[:installed] = mailscanner_installed

      if mailscanner_installed && mailscanner_version
        mailscanner[:version] = mailscanner_version
      end

      if mailscanner_installed
        mailscanner[:submission] = mailscanner_submission
      end

      if mailscanner_installed
        mailscanner[:smtpd_tls] = mailscanner_tls
      end

      if mailscanner_tls && mailscanner_crt_path != ""
        mailscanner[:smtpd_tls_crt_path] = mailscanner_crt_path
      end

      if mailscanner_tls
        if ( mailscanner_key_path != "" ) && ( mailscanner_key_path != "$smtpd_tls_cert_file" )
          mailscanner[:smtpd_tls_key_path] = mailscanner_key_path
        end
      end

      mailscanner

   end
end

