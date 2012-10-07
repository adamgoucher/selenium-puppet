class selenium::server {
  if $operatingsystem == 'windows' {
    file { "c:/selenium":
      ensure => directory,
    }

    file { "c:/selenium/selenium-server-standalone-2.25.0.jar":
      ensure => present,
      source => "puppet:///modules/selenium/selenium-server-standalone-2.25.0.jar",
    }

    exec { 'start server':
      path => $path,
      command => "cmd.exe /c start cmd /k \"\"${jre7_home}\\bin\\java.exe\" -jar c:\\selenium\\selenium-server-standalone-2.25.0.jar\"",
      require => File["c:/selenium/selenium-server-standalone-2.25.0.jar"],
    }


  } else {
    file {"/usr/local/selenium":
      ensure => directory,
    }

    file {"/usr/local/selenium/selenium-server-standalone-2.25.0.jar":
      ensure => present,
      source => "puppet:///modules/selenium/selenium-server-standalone-2.25.0.jar",
    }

    file {"/etc/init.d/selenium-server":
      ensure => present,
      source => "puppet:///modules/selenium/selenium-server",
      mode => 0755,
    }

    service { "selenium-server":
      ensure => running,
      pattern => "selenium-server-standalone-2.0b2.jar",
    }
  }
}
