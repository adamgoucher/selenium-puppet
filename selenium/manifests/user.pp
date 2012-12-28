# Installs a user to run the Selenium server as
class selenium::user {
  $selenium_user_username = hiera('selenium_user_username', 'monkey')
  $selenium_user_password = hiera('selenium_user_password', 'butt')

  if $::operatingsystem == 'windows' {
    file { "${::profiles_directory}/${::selenium_user_username}":
      ensure => directory
    }

    file { "${::profiles_directory}/${::selenium_user_username}/NTUSER.dat":
      ensure => present,
      source => "${::profiles_directory}/Default User/NTUSER.dat",
    }

    user { $selenium_user_username:
      comment   => 'user for selenium scripts',
      password  => $selenium_user_password,
      groups    => ['Administrators'],
      notify    => Class['selenium::user::reboot'],
    }

    registry::value { 'autologin-username':
      key    => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value  => 'DefaultUserName',
      data   => "$selenium_user_username",
      notify => Class['selenium::user::reboot'],
    }

    registry::value { 'autologin-password':
      key    => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value  => 'DefaultPassword',
      data   => "$selenium_user_password",
      notify => Class['selenium::user::reboot'],
    }

    registry::value { 'autologin-enable':
      key   => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => 'AutoAdminLogon',
      data  => '1',
      notify    => Class['selenium::user::reboot'],
    }
  }
}

class selenium::user::reboot {
  if $::operatingsystem == 'windows' {
    exec { 'reboot':
      path        => $::path,
      command     => 'cmd.exe /c shutdown -r -t 0',
      refreshonly => true,
    }
  }
}
