# This profile configres an HA Proxy node for Puppet and Foreman.
class profile::proxy_puppet {
  include ::haproxy
  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => '172.28.128.10',
    ports            => '8140',
    mode             => 'tcp',
    options          => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }

  haproxy::balancermember { 'master00':
    listening_service => 'puppet00',
    server_names      => 'foreman.localdomain',
    ipaddresses       => '172.28.128.20',
    ports             => '8140',
    options           => 'check',
  }

  haproxy::listen { 'stats':
    ipaddress => '0.0.0.0',
    ports     => '9000',
    options   => {
      'mode'  => 'http',
      'stats' => [
        'uri /',
        'auth admin:password',
        'realm HAProxy\ Statistics',
        'admin if TRUE'
      ],
    },
  }

  haproxy::listen { 'foreman-frontend443':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '443',
    mode             => 'tcp',
    options          => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }

  haproxy::balancermember { 'foreman-backend443':
    listening_service => 'foreman-frontend443',
    server_names      => 'foreman.localdomain',
    ipaddresses       => '172.28.128.20',
    ports             => '443',
    options           => 'check',
  }

  haproxy::listen { 'foreman-frontend8081':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '8081',
    mode             => 'tcp',
    options          => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }

  haproxy::balancermember { 'foreman-backend8081':
    listening_service => 'foreman-frontend8081',
    server_names      => 'foreman.localdomain',
    ipaddresses       => '172.28.128.20',
    ports             => '8081',
    options           => 'check',
  }

  # The two entries below are for the webhook receiver
  haproxy::listen { 'foreman-frontend8888':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '8888',
    mode             => 'tcp',
    options          => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
  }

  haproxy::balancermember { 'foreman-backend8888':
    listening_service => 'foreman-frontend8888',
    server_names      => 'foreman.localdomain',
    ipaddresses       => '172.28.128.20',
    ports             => '8888',
    options           => 'check',
  }

}
