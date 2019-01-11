#This installs the tmux package.
class profile::tmux {
  package { 'tmux':
    ensure => installed,
  }
}
