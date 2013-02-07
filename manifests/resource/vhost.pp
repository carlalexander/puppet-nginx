# Define: nginx::resource::vhost
#
# This definition creates a specific vhost
#
# Parameters:
#   [*server_name*]    - List of vhostnames for which this vhost will respond. Default [$name]
#   [*listen_ip*]      - Specifies the URI for the location entry
#   [*listen_port*]    - Expects an hash with the options for this location entry
#   [*listen_options*] - Priority for this location entry. Default: 500
#   [*root*]           - Specifies the location on disk for files to be read from.
#   [*index*]          - Default index files for NGINX to read when traversing a directory
#   [*options*]        - Expects an hash with the options for this vhost entry
#
# Actions:
#
# Requires:
#
# Sample Usage:
# nginx::resource::vhost { 'test.local':
#   root        => '/var/www/test.local',
#   index       => ['index.php']
# }
define nginx::resource::vhost (
  $server_name    = $name,
  $listen_ip      = '*',
  $listen_port    = '80',
  $listen_options = undef,
  $root           = undef,
  $index          = ['index.html', 'index.htm'],
  $options        = undef
) {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if ($root == undef) {
    fail('You must define a root directory')
  }

  file { "${nginx::params::temp_dir}/${name}-001":
    ensure  => file,
    content => template('nginx/vhost/vhost_header.erb')
  }

  file { "${nginx::params::temp_dir}/${name}-999":
    ensure  => file,
    content => template('nginx/vhost/vhost_footer.erb'),
    require => File["${nginx::params::temp_dir}/${name}-001"],
    notify  => Class['nginx::service']
  }
}