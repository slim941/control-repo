#This installs the sysdig package.
class profile::sysdig {
  package { 'sysdig':
    ensure => installed,
  }
}
