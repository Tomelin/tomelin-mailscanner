class mailscanner::service {


	service { 'mailscanner':
		ensure      => 'running',
		enable      => true,
		hasrestart  => true,
		hasstatus   => true,
	}

}
