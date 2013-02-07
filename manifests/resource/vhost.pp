define nginx::resource::vhost (
  $server_name = undef,
  $listen_ip = '*',
  $listen_port = '80',
  $listen_options = undef,
  $root = undef,
  $index = ['index.html', 'index.htm'],
  $options = undef
) {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if ($server_name == undef) {
    fail('You must define a server name for this virtual host')
  }
  if ($root == undef) {
    fail('You must define a root directory')
  }

  file { "${nginx::params::temp_dir}/${server_name}-001":
    ensure  => file,
    content => template('nginx/templates/vhost/vhost_header.erb')
  }

  file { "${nginx::params::temp_dir}/${server_name}-999":
    ensure  => file,
    content => template('nginx/templates/vhost/vhost_footer.erb')
  }
}