# Class: nginx::config
#
# This module manages NGINX bootstrap and configuration
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::config(
  $worker_processes    = $nginx::params::worker_processes,
  $worker_connections  = $nginx::params::worker_connections
) inherits nginx::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "${nginx::config::conf_dir}":
    ensure => directory,
  }

  file { "${nginx::config::conf_dir}/conf.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  
  file { "${nginx::config::www_dir}":
    ensure => directory,
  }

  file { "${nginx::config::conf_dir}/sites-enabled/default":
    ensure => absent,
  }

  file { "${nginx::config::conf_dir}/nginx.conf":
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
  }

  file { $nginx::params::temp_dir:
    ensure  => directory,
    purge   => true,
    recurse => true
  }
}