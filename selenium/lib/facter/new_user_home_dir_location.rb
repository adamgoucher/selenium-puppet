require 'facter'
require 'facter/util/registry'

Facter.add(:profiles_directory) do
  confine :kernel => :windows
  setcode do
    Facter::Util::Registry.hklm_read('SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList', 'ProfilesDirectory')
  end
end
