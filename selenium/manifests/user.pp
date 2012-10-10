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
  } 
}
