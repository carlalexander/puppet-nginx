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
  exec { 'rebuild-nginx-vhosts':
    command     => "/bin/cat ${nginx::params::temp_dir}/* > ${nginx::params::nx_conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${nginx::params::temp_dir}/*",
    subscribe   => File["${nginx::params::temp_dir}"],
  }

  service { "nginx":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-nginx-vhosts'],
  }
}