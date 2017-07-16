# This profile configures a Foreman All-in-One box.
class profile::foreman_aio {
  class { '::puppet':
    pluginsync                    => true,
    runmode                       => 'service',
    ca_server                     => 'foreman.localdomain',
    dns_alt_names                 => [ 'puppet', 'puppet.localdomain', ],
    agent                         => true,
    puppetmaster                  => 'foreman.localdomain',

    server                        => true,
    server_ca                     => true,
    server_implementation         => 'puppetserver',
    server_jvm_max_heap_size      => '768m',
    server_jvm_min_heap_size      => '768m',
    server_reports                => 'foreman,puppetdb',
    server_external_nodes         => '/etc/puppetlabs/puppet/node.rb',
    server_dynamic_environments   => false,
    server_directory_environments => true,
    server_environments           => [ ],
    server_environments_owner     => 'puppet',
    server_environments_group     => 'puppet',
    server_envs_dir               => '/etc/puppetlabs/code/environments',
    server_common_modules_path    => [],
    server_certname               => 'foreman.localdomain',

    server_service_fallback       => false,
    server_foreman_url            => 'https://foreman.localdomain',
    server_foreman_ssl_ca         => '/etc/puppetlabs/puppet/ssl/ca/ca_crt.pem',
    server_foreman_ssl_cert       => '/etc/puppetlabs/puppet/ssl/certs/foreman.localdomain.pem',
    server_foreman_ssl_key        => '/etc/puppetlabs/puppet/ssl/private_keys/foreman.localdomain.pem',
    #server_enc_api                => 'v2',
    #server_report_api             => 'v2',
  }

  class { '::puppetdb::server':
    database_host     => 'pg1.localdomain',
    database_name     => 'puppetdb',
    database_username => 'puppetdbuser',
    database_password => 'Pupp3t-DB-V00D00',
    manage_firewall   => false,
    #manage_package_repo => false,
  }

  class { '::puppetdb::master::config':
    manage_storeconfigs     => false,
    manage_report_processor => false,
  }

  if defined('$::control_repo_path') {
    $control_repo = $::control_repo_path
  } else {
    $control_repo = 'https://github.com/genebean/control-repo.git'
  }

  class { '::r10k':
    provider          => 'puppet_gem',
    cachedir          => '/opt/puppetlabs/puppet/cache/r10k',
    configfile        => '/etc/puppetlabs/r10k/r10k.yaml',
    manage_modulepath => false,
    sources           => {
      'vcs' => {
        'remote'  => $::control_repo,
        'basedir' => '/etc/puppetlabs/code/environments',
        'prefix'  => false,
      }
    },
  }

  class { '::hiera':
    hierarchy          => [
      'nodes/%{::trusted.certname}',
      'common',
    ],
    datadir            => '/etc/puppetlabs/code/environments/%{::environment}/hieradata',
    datadir_manage     => false,
    puppet_conf_manage => false,
  }

  class { '::puppetmaster_webhook':
    repo_control => 'control-repo',
    webhook_home => '/opt/puppetmaster_webhook',
    webhook_port => '8888',
  }
}
