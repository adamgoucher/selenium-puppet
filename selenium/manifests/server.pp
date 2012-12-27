# Installs and starts the Selenium server
class selenium::server {
  if $::operatingsystem == 'windows' {
    file { 'c:/selenium':
      ensure => directory,
    }

    file { 'c:/selenium/selenium-server-standalone-2.28.0.jar':
      ensure => present,
      source => 'puppet:///modules/selenium/selenium-server-standalone-2.28.0.jar',
    }

    notice("server is running? ${::selenium_server_running}")

    unless $::selenium_server_running {
      exec { 'start server':
        path    => $::path,
        command => "cmd.exe /c start cmd /k \"\"${jre7_home}\\bin\\java.exe\" -jar c:\\selenium\\selenium-server-standalone-2.28.0.jar\"",
        require => File['c:/selenium/selenium-server-standalone-2.28.0.jar'],
      }
    }


  } else {
    file {'/usr/local/selenium':
      ensure => directory,
    }

    file {'/usr/local/selenium/selenium-server-standalone-2.28.0.jar':
      ensure => present,
      source => 'puppet:///modules/selenium/selenium-server-standalone-2.28.0.jar',
    }

    file {'/etc/init.d/selenium-server':
      ensure  => present,
      source  => 'puppet:///modules/selenium/selenium-server',
      mode    => '0755',
    }

    service {'selenium-server':
      ensure  => running,
      pattern => 'selenium-server-standalone-2.28.jar',
    }
  }
}
