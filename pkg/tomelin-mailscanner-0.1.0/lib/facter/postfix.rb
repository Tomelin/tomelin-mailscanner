Facter.add(:postfix) do

    setcode do

      confine :kernel => 'Linux'

      postfix = {}

      postfix_path = Facter::Core::Execution.exec('which postfix')
      if postfix_path == ""
       postfix_installed = false
      else
       postfix_installed = true
      end

      if postfix_installed
        distid = Facter.value(:osfamily)
        case distid
        when /RedHat|Suse/
            postfix_version = Facter::Core::Execution.exec('rpm -q --queryformat "%{VERSION}" postfix')
        when "Debian"
            postfix_version = Facter::Core::Execution.exec('dpkg-query -W -f=\'${Version}\' postfix')
        else
         postfix_version = 'Desconhecida'
        end
      end

      if postfix_installed
        postconf_tls_string = Facter::Core::Execution.exec('postconf smtpd_use_tls|awk \'{ print $3 }\'')
        if postconf_tls_string == 'yes'
          postfix_tls = true
        else
          postfix_tls = false
        end
      end

      if postfix_installed
        postfix_submission_check = Facter::Core::Execution.exec('cat /etc/postfix/master.cf |grep ^submission')
        if postfix_submission_check == ""
          postfix_submission = false
        else
          postfix_submission = true
        end
      end

      if postfix_tls
        postfix_crt_path = Facter::Core::Execution.exec('postconf smtpd_tls_cert_file|awk \'{ print $3 }\'')
        postfix_key_path = Facter::Core::Execution.exec('postconf smtpd_tls_key_file|awk \'{ print $3 }\'')
      end

      postfix[:installed] = postfix_installed

      if postfix_installed && postfix_version
        postfix[:version] = postfix_version
      end

      if postfix_installed
        postfix[:submission] = postfix_submission
      end

      if postfix_installed
        postfix[:smtpd_tls] = postfix_tls
      end

      if postfix_tls && postfix_crt_path != ""
        postfix[:smtpd_tls_crt_path] = postfix_crt_path
      end

      if postfix_tls
        if ( postfix_key_path != "" ) && ( postfix_key_path != "$smtpd_tls_cert_file" )
          postfix[:smtpd_tls_key_path] = postfix_key_path
        end
      end

      postfix

   end
end

