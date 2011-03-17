class selenium-server {
	file { "/usr/local/selenium":
		ensure => directory,
	}
	file { "/usr/local/selenium/selenium-server-standalone-2.0b2.jar":
		ensure => present,
		source => "puppet:///modules/selenium/selenium-server-standalone-2.0b2.jar"
	}
}
