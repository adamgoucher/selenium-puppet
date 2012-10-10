class selenium::user {
  if $operatingsystem == 'windows' {
    user { selenium-user:
      comment => "user for selenium scripts",
      password => "selenium",
      before => Group['selenium-group'],
    }

    group { selenium-group:
      members => ["selenium-user"],
    }
  } 
}
