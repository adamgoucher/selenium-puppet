# Installs and starts the Selenium server
class selenium::hub {
  file {'/usr/local/selenium':
    ensure => directory,
  }

  file {'/usr/local/selenium/selenium-server-standalone-3.141.59.jar':
    ensure => present,
    source => 'puppet:///modules/selenium/selenium-server-standalone-3.141.59.jar',
  }

  file {'/etc/init.d/selenium-hub':
    ensure  => present,
    source  => 'puppet:///modules/selenium/selenium-hub',
    mode    => '0755',
  }

  service {'selenium-server':
    ensure  => running,
    pattern => 'selenium-server-standalone-2.28.jar',
  }
}
