# Installs the Oracle JRE 1.7.0 u10
class jre7 {
  notice("jre7_version is '${::jre7_version}'")
  unless $::jre7_version == '1.7.0_10' {  
    case $::operatingsystem {
      windows: {
        file { 'c://temp//jre-7u10-windows-i586.exe':
          source  => 'puppet:///modules/jre7/jre-7u10-windows-i586.exe',
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          ensure          => installed,
          source          => 'c://temp//jre-7u10-windows-i586.exe',
          install_options => [
            '/s', '/v/qn" ADDLOCAL=jrecore REBOOT=Suppress JAVAUPDATE=0"'
          ],
          before          => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => 'cmd.exe /c del c:\temp\jre-7u10-windows-i586.exe',
        }
      }
      centos, redhat: {
        if $::architecture == 'x86_64' {
          $arch = 'x64'
        }
        else {
          fail("Module ${module_name} is not supported on ${::architecture}. Yet.")
        }
        file { '/tmp/jre-7u10-linux-x64.rpm':
          source  => 'puppet:///modules/jre7/jre-7u10-linux-x64.rpm',
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          ensure    => installed,
          source    => '/tmp/jre-7u10-linux-x64.rpm',
          provider  => rpm,
          before    => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => 'rm /tmp/jre-7u10-linux-x64.rpm',
        }
      }
      ubuntu, debian: {
        unless $::architecture in ['i386', 'amd64'] {
          fail("Module ${module_name} is not supported on ${::architecture}. Yet.")
        }
        
        file { "/tmp/jre-7u10-linux-${arch}.deb":
          source  => "puppet:///modules/jre7/jre-7u10-linux-${arch}.deb",
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          name      => 'jre',
          ensure    => installed,
          source    => "/tmp/jre-7u10-linux-${arch}.deb",
          provider  => dpkg,
          before    => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => "rm /tmp/jre-7u10-linux-${arch}.deb",
        }
      }
      default: {
        fail("Module ${module_name} is not supported on ${::operatingsystem}")
      }
    }
  }
}
