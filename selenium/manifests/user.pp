# Installs a user to run the Selenium server as
class selenium::user {
  $selenium_user_username = hiera('selenium_user_username', 'monkey')
  $selenium_user_password = hiera('selenium_user_password', 'butt')

  if $::operatingsystem == 'windows' {
    extended_windows_user { $selenium_user_username:
      comment   => 'user for selenium scripts',
      password  => $selenium_user_password,
      groups    => ['Administrators'],
      managehome => true,
      provider => extended_windows_adsi,
      screensaver_enabled => false,
      notify    => Class['selenium::user::reboot'],
    }

    file { "${::profiles_directory}/$selenium_user_username/Start Menu/Programs/Startup/selenium-server.bat":
      ensure => present,
      content => template('selenium/selenium-server-windows.erb'),
      require => User["$selenium_user_username"],
      notify => Class['selenium::user::reboot'],
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

    if $::env_username == $selenium_user_username {
      registry::value { 'disable screensaver':
        key    => 'HKCU\Control Panel\Desktop',
        value  => 'ScreenSaveActive',
        data   => '0'
      }
    }
  }
}

class selenium::user::reboot {
  if $::operatingsystem == 'windowsx' {
    exec { 'reboot':
      path        => $::path,
      command     => 'cmd.exe /c shutdown -r -t 0',
      refreshonly => true,
    }
  }
}
