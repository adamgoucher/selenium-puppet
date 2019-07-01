# Installs the selenium-webdriver gem
class selenium::ruby {
  package { 'selenium-webdriver':
    ensure    => 3.142.3,
    provider  => gem
  }
}
