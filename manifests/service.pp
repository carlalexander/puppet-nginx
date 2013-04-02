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

  exec { 'rebuild-nginx-vhosts':
    command     => "cat ${nginx::params::temp_dir}/* > ${nginx::params::conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "test ! -f ${nginx::params::temp_dir}/*",
    subscribe   => File[$nginx::params::temp_dir],
  }

  service { "nginx":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-nginx-vhosts'],
  }
}