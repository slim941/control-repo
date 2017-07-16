# This role configures a Postgresql Master.
class role::pg_master inherits role::generic {
  include ::profile::base
  include ::profile::pg_master
}
