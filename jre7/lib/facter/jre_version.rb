require 'facter'

Facter.add(:jre7_version) do
  confine :kernel => :windows
  
  require 'facter/util/registry'

  setcode do
    version = Facter::Util::Registry.hklm_read('SOFTWARE\JavaSoft\Java Runtime Environment', 'Java7FamilyVersion')
    version ||= nil
  end
end

Facter.add(:jre7_version) do
  confine :operatingsystem => %w{CentOS RedHat}
  setcode do
    version = `rpm -qa jre | awk -F- ' { print $2 }'`.chomp
    version ||= nil
  end
end

Facter.add(:jre7_version) do
  confine :operatingsystem => %w{Ubuntu Debian}
  setcode do
    version = `dpkg -s jre 2>&1 | grep Version | awk '{print $2}'`.chomp
    version ||= nil
  end
end
