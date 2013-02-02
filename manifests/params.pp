# Class: nginx::params
# 
# This class manages nginx parameters.
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
class nginx::params {
  $temp_dir = '/tmp'
  $www_dir  = '/var/www'
  $log_dir  = '/var/log/nginx'
  $conf_dir = '/etc/nginx'

  $worker_processes   = 1
  $worker_connections = 768
  $multi_accept       = on
  $epoll              = on
  $sendfile           = on
  $send_timeout       = 60
  $keepalive_timeout  = 60
  $tcp_nodelay        = on
  $tcp_nopush         = on
  $gzip               = on

  $daemon_user = 'www-data'
}