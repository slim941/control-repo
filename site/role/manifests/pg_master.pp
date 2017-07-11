# This role configures a Postgresql Master.
class role::pg_master {
  include ::profile::base
  include ::profile::pg_master
}
