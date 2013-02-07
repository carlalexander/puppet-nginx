# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the nginx::params class
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx (
  $worker_processes   = $nginx::params::worker_processes,
  $worker_connections = $nginx::params::worker_connections
) inherits nginx::params {
  class { 'nginx::package':
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    worker_processes  => $worker_processes,
    worker_connections  => $worker_connections,
    require     => Class['nginx::package'],
    notify      => Class['nginx::service'],
  }

  class { 'nginx::service': }
}