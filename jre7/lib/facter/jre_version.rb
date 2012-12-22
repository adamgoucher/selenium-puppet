require 'facter'
require 'facter/util/registry'

Facter.add(:jre7_version) do
  confine :kernel => :windows
  setcode do
    version = Facter::Util::Registry.hklm_read('SOFTWARE\JavaSoft\Java Runtime Environment', 'Java7FamilyVersion')
    version ||= nil
  end
end

