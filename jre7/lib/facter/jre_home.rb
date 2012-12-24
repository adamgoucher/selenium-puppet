require 'facter'
require 'facter/util/registry'

Facter.add(:jre7_home) do
  confine :kernel => :windows
  setcode do
    version = Facter::Util::Registry.hklm_read('SOFTWARE\JavaSoft\Java Runtime Environment', 'Java7FamilyVersion')
    Facter::Util::Registry.hklm_read("SOFTWARE\\JavaSoft\\Java Runtime Environment\\#{version}", 'JavaHome')
  end
end

