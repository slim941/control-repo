# This profile applies a base level configuration.
class profile::base {
  case $::kernel {
    'Linux'   : {
      # make a system's hostname show up in /etc/hosts as part of localhost
      $hosts = hiera_hash('hosts')
      create_resources('host', $hosts)

      resources { 'host':
        purge => true,
      }
    }

    default : {
    }

  } # end case statement
} # end profile::base
