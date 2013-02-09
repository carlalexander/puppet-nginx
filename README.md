# NGINX Module

Puppet module for Nginx. This module is based off the [module](https://github.com/jfryman/puppet-nginx) built by [James Fryman](https://github.com/jfryman). The configuration defaults are based on this [article](http://calendar.perfplanet.com/2012/using-nginx-php-fpmapc-and-varnish-to-make-wordpress-websites-fly/).

## Requirements

Currently only tested using Ubuntu Quantal.

## Usage

To install and bootstrap nginx, simply add the class defintion:

    class { 'nginx': }

Creating a vhost is done using the vhost resouce defintion:

    nginx::resource::vhost { 'test.local':
      root        => '/var/www/test.local',
      index       => ['index.php']
    }

You can then add location entries using the location resource definition:

    nginx::resource::location { 'test.local-robot.txt':
      vhost    => 'test.local',
      location => '= /robot.txt',
      options  => {
        'allow'         => 'all',
        'log_not_found' => 'off',
        'access_log'    => 'off'
      }
    }