require 'facter'

Facter.add(:selenium_server_running) do
  confine :kernel => :windows
  setcode do
    tasks = Facter::Util::Resolution.exec('tasklist.exe /V /FO csv')
    tasks.each do |task|
      if task.match('.*-jar c:\\\selenium\\\selenium-server-standalone.*.jar"$')
        running = true
        break
      end
    end
    running ||= nil
  end
end
