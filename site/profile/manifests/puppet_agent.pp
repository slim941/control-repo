class profile::puppet_agent {
  class { '::puppet':
    pluginsync   => true,
    runmode      => 'service',
    agent        => true,
    puppetmaster => 'puppet.localdomain',
    ca_server    => 'puppet.localdomain',
  }
}
