class jre6 {
  package { "sun-java6-jre":
    require      => File["/var/cache/debconf/jre6.seeds"],
    responsefile => "/var/cache/debconf/jre6.seeds",
    ensure       => latest;
  }

  file { "/var/cache/debconf/jre6.seeds":
    source => "puppet:///jre6/jre6.seeds",
    ensure => present;
  }
}
