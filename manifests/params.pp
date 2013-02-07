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
  $temp_dir = '/tmp/nginx.d'
  $www_dir  = '/var/www'
  $log_dir  = '/var/log/nginx'
  $conf_dir = '/etc/nginx'

  $worker_processes   = 1
  $worker_connections = 768
  $multi_accept       = on
  $epoll              = on
  $sendfile           = on
  $send_timeout       = 60
  $keepalive_timeout  = 20
  $tcp_nodelay        = on
  $tcp_nopush         = on
  
  $gzip              = on
  $gzip_static       = on
  $gzip_disable      = 'msie6'
  $gzip_vary         = on
  $gzip_proxied      = 'any'
  $gzip_comp_level   = 6
  $gzip_min_length   = 512
  $gzip_buffers      = '16 8k'
  $gzip_http_version = '1.1'
  $gzip_types        = 'text/css text/javascript text/xml text/plain text/x-component application/javascript application/x-javascript application/json application/xml application/rss+xml font/truetype application/x-font-ttf font/opentype application/vnd.ms-fontobject image/svg+xml'

  $daemon_user = 'www-data'
  $pid         = '/var/run/nginx.pid'
}