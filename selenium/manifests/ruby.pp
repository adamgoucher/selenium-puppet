# Installs the selenium-webdriver gem
class selenium::ruby {
  package { 'selenium-webdriver':
    ensure    => 2.27.2,
    provider  => gem
  }
}
