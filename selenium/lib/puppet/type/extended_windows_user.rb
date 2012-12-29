Puppet::Type.newtype(:extended_windows_user, {:parent => Puppet::Type::User}) do
  newproperty(:screensaver_enabled) do
    desc "boilerplate"
  end
end

