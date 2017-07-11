# This profile configures a Foreman All-in-One Puppet Master.
class role::puppetmaster {
  include ::profile::base
  include ::profile::foreman_aio
}
