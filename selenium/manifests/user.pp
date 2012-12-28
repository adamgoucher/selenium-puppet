# Installs a user to run the Selenium server as
class selenium::user {
  $::selenium_user_username      = hiera('selenium_user_username', 'selenium_user')
  $::selenium_user_username_password  = hiera('selenium_user_password', 'selenium')
  
  if $::operatingsystem == 'windows' {
    file { "${::profiles_directory}/${::selenium-user}":
      ensure => directory
    }

    file { "${::profiles_directory}/${::selenium-user}/NTUSER.dat":
      ensure => present,
      source => "${::profiles_directory}/Default User/NTUSER.dat",
    }

    user { $::selenium_user_username:
      comment   => 'user for selenium scripts',
      password  => ${::selenium_user_password},
      groups    => ['Administrators'],
    }

    registry::value { 'autologin-username':
      key   => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => 'DefaultUserName',
      data  => $::selenium_user_username
    }

    registry::value { 'autologin-password':
      key   => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => 'DefaultPassword',
      data  => $::selenium_user_username_password
    }

    registry::value { 'autologin-enable':
      key   => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => 'AutoAdminLogon',
      data  => '1'
    }
  }
}
