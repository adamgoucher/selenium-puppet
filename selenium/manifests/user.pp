class selenium::user {
  if $operatingsystem == 'windows' {
    file { "${profiles_directory}/selenium":
      ensure => directory
    }

    file { "${profiles_directory}/selenium/NTUSER.dat":
      ensure => present,
      source => "${profiles_directory}/Default User/NTUSER.dat",
    }

    user { selenium-user:
      comment => "user for selenium scripts",
      password => "selenium",
      groups => ["Administrators"],
    }

    registry::value { 'autologin-username':
      key => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => "DefaultUserName",
      data => "selenium-user"
    }

    registry::value { 'autologin-password':
      key => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => "DefaultPassword",
      data => "selenium"
    }

    registry::value { 'autologin-enable':
      key => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      value => "AutoAdminLogon",
      data => "1"
    }
  } 
}
