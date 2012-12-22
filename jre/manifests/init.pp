class jre {
  case $operatingsystem {
    'windows': {
      notice("jre7_version is ${jre7_version}")
      unless $jre7_version == '1.7.0_10' {
        file { 'c://temp//jre-7u10-windows-i586.exe':
          source => 'puppet:///modules/jre/jre-7u10-windows-i586.exe',
          mode => '777',
        }

        package { 'Java 7 Update 10':
          ensure => installed,
          source => 'c://temp//jre-7u10-windows-i586.exe',
          install_options => [
            '/s', '/v/qn" ADDLOCAL=jrecore REBOOT=Suppress JAVAUPDATE=0"'
          ],
          before => Exec['cleanup'],
        }

        exec { 'cleanup':
          path => $path,
          command => 'cmd.exe /c del c:\temp\jre-7u10-windows-i586.exe',
        }
      }
    }
  }
}
