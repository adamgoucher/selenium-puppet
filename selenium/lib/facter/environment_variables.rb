# from http://projects.puppetlabs.com/projects/puppet/wiki/Environment_Variables_Patterns
#
# Copyright 2008 Tim Dysinger
# Distributed under the same license as Facter

ENV.each do |k,v| 
  Facter.add("env_#{k.downcase}".to_sym) do 
    setcode do 
      v
    end
  end
end