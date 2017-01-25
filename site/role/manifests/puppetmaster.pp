class role::puppetmaster inherits role::generic {
  include ::profile::foreman_aio
}
