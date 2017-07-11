# This role configres an HA Proxy node for Puppet and Foreman.
class role::proxy inherits role::generic {
  include ::profile::proxy_puppet
}
