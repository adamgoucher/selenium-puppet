# Installs the Oracle JRE 1.7.0 u10
class jre7 {
  notice("jre7_version is '${::jre7_version}'")
  unless $::jre7_version =~ /1.7.0[_-]10/ {
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
        } elsif $::architecture == 'i386' {
          $arch = 'i586'
        } else {
          fail("Module ${module_name} is not supported on ${::architecture}. Yet.")
        }

        file { "/tmp/jre-7u10-linux-${arch}.rpm":
          source  => "puppet:///modules/jre7/jre-7u10-linux-${arch}.rpm",
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          ensure    => installed,
          source    => "/tmp/jre-7u10-linux-${arch}.rpm",
          provider  => rpm,
          before    => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => "rm /tmp/jre-7u10-linux-${arch}.rpm",
        }
      }
      ubuntu, debian: {
        unless $::architecture in ['i386', 'amd64'] {
          fail("Module ${module_name} is not supported on ${::architecture}. Yet.")
        }

        file { "/tmp/jre_1.7.0-10_${::architecture}.deb":
          source  => "puppet:///modules/jre7/jre_1.7.0-10_${::architecture}.deb",
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          ensure    => installed,
          name      => 'jre',
          source    => "/tmp/jre_1.7.0-10_${::architecture}.deb",
          provider  => dpkg,
          before    => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => "rm /tmp/jre_1.7.0-10_${::architecture}.deb",
        }
      }
      darwin: {
        file { "/tmp/jre-7u10-macosx-x64.dmg":
          source  => "puppet:///modules/jre7/jre-7u10_macosx-x64.dmg",
          mode    => '0777',
        }

        package { 'Java 7 Update 10':
          ensure    => installed,
          name      => 'jre',
          source    => "/tmp/jre-7u10-macosx-x64.dmg",
          provider  => pkgdmg,
          before    => Exec['cleanup'],
        }

        exec { 'cleanup':
          path    => $::path,
          command => "rm /tmp/jre-7u10-macosx-x64.dmg",
        }
      }
      default: {
        fail("Module ${module_name} is not supported on ${::operatingsystem}")
      }
    }
  }
}
