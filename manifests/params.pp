# Class: polipo::params
#
#
class polipo::params {
  $method          = "${polipo::method}"
  $proxyaddress    = "${polipo::proxyaddress}"
  $allowedclients  = "${polipo::allowedclients}"
  $proxyname       = "${polipo::proxyname}"
  $sharedcache     = "${polipo::sharedcache}"

  case $::operatingsystem {
    'debian', 'ubuntu': {
      $polipo_confdir  = '/etc/polipo'
      $polipo_cachedir = '/var/cache/polipo/'
      $polipo_pidfile  = '/var/run/polipo/polipo.pid'
      $polipo_name     = 'polipo'
      $polipo_pkg      = 'polipo'
      $polipo_user     = 'proxy'
      $polipo_group    = 'proxy'
    }

    'centos', 'rhel': {
      fail 'Operating system not supported yet.'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
