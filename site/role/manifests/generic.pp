# This role applies a base set of profiles.
class role::generic {
  include ::profile::base
  include ::profile::puppet_agent
}
