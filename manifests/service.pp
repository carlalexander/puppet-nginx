# Class: nginx::service
#
# This module manages NGINX service management
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
class nginx::service {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  file { "${nginx::config::conf_dir}/conf.d/vhost_autogen.conf":
    ensure  => absent,
    require => File[$nginx::params::temp_dir],
  }

  exec { 'rebuild-nginx-vhosts':
    command => "cat ${nginx::params::temp_dir}/* > ${nginx::params::conf_dir}/conf.d/vhost_autogen.conf",
    unless  => "test ! -f ${nginx::params::temp_dir}/*",
    require => File["${nginx::config::conf_dir}/conf.d/vhost_autogen.conf"]
  }

  service { "nginx":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-nginx-vhosts'],
  }
}