Puppet::Type.type(:user).provide :extended_windows_adsi, :parent => :windows_adsi, :source => :windows_adsi do
  desc "Local user management for Windows -- with some extra goodies."

  confine    :operatingsystem => :windows

  has_features   :manages_homedir, :manages_passwords
  
  def screensaver_enabled
    v = `reg query "#{user.uid}\\control panel\\desktop" /v screensaveactive`
    v.match(/screensaveactive\s*\w*\s*(\S)/).captures
  end

  def screensaver_enabled=(value)
    if @resource.screensaver_enabled?
      `reg add "hku\\#{user.uid}\\control panel\\desktop" /v screensaveactive /f /t REG_SZ /d 1`
    else
      `reg add "hku\\#{user.uid}\\control panel\\desktop" /v screensaveactive /f /t REG_SZ /d 0`
    end
  end
end
