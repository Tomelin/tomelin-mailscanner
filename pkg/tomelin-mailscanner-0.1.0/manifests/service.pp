class mailscanner::service {


	service { 'MailScanner':
		ensure      => 'running',
		enable      => true,
		hasrestart  => true,
		hasstatus   => true,
	}

}
