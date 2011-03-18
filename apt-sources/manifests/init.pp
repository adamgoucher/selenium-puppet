class apt-sources {
	file { "/etc/apt/sources.list":
		ensure => present,
		source => "puppet:///modules/apt-sources/sources.list",
		mode => 0644,
		owner => root,
		group => root,
		checksum => md5
	}

	exec { subscribe-echo:
               command     => "/usr/bin/apt-get -q -q update",
               logoutput   => false,
               refreshonly => true,
               subscribe   => file["/etc/apt/sources.list"]
	}
}
