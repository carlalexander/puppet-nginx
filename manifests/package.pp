# Class: nginx::package
#
# This module manages NGINX package installation
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
class nginx::package {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { 'nginx_signing.key':
    command => 'wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add -',
    unless  => 'apt-key list | grep -c nginx_signing',
  }

  exec { 'nginx.list':
    command => "echo 'deb http://nginx.org/packages/ubuntu/ quantal nginx' >> /etc/apt/sources.list.d/nginx.list && apt-get update",
    creates => '/etc/apt/sources.list.d/nginx.list',
    require => Exec['nginx_signing.key']
  }

  package { 'nginx':
    ensure => latest,
    require => Exec['nginx.list'],
  }
}
