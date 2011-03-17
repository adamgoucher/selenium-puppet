class selenium-server {
        file { "/usr/local/selenium":
                ensure => directory,

                "/usr/local/selenium/selenium-server-standalone-2.0b2.jar":
                ensure => present,
                source => "puppet:///modules/selenium/selenium-server-standalone-2.0b2.jar";

                "/etc/init.d/selenium-server":
                ensure => present,
                source => "puppet:///modules/selenium/selenium-server",
                mode => 0755
        }
        service { "selenium-server":
                ensure => running,
                pattern => "selenium-server-standalone-2.0b2.jar"
        }
}
