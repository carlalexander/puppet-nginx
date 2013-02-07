# Define: nginx::resource::location
#
# This definition creates a location directive for a specific vhost
#
# Parameters:
#   [*vhost*]    - Specifies the vhost that the location entry is added to
#   [*location*] - Specifies the URI for the location entry
#   [*options*]  - Expects an hash with the options for this location entry
#   [*priority*] - Priority for this location entry. Default: 500
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::location { 'test2.local-robot.txt':
#    vhost    => 'test2.local',
#    location => '= /robot.txt',
#    options  => {
#      'allow'         => 'all',
#      'log_not_found' => 'off',
#      'access_log'    => 'off'
#    }
#  }
define nginx::resource::location (
  $vhost    = undef,
  $location = undef,
  $options  = undef,
  $priority = 500
) {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['nginx::service'],
  }

  ## Check for various error conditions
  if ($vhost == undef) {
    fail('Cannot create a location reference without attaching to a virtual host')
  }
  if ($location == undef) {
    fail('Cannot create a location reference without a location')
  }
  if ($options == undef) {
    fail('Cannot create a location reference without location options')
  }

  file {"${nginx::params::temp_dir}/${vhost}-${priority}-${name}":
    ensure  => file,
    content => template('nginx/vhost/location.erb'),
  }
}