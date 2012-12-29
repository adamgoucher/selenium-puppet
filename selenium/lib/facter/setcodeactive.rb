Facter.add(:screencodeactive) do
  confine :kernel => :windows
  setcode do
    version = `reg query "hkcu\\control panel\\desktop" /v screensaveactive`
    version.match(/screensaveactive\s*\w*\s*(\S)/).captures
  end
end