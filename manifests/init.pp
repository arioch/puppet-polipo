# Class: polipo
#
# This class installs polipo
#
# Parameters:
#
# Actions:
#   - Install polipo
#
# Requires:
#   - ... module
#
# Sample usage:
#   node host01 {
#     class { 'polipo':
#       proxyname => 'host01'
#     }
#   }
#
# Valid options:
#
#   method         => 'any',
#   proxyaddress   => '::0',        # default: '::0' | ipv4 + ipv6: '::0', ipv4: '0.0.0.0'
#   allowedclients => '127.0.0.1',  # default: any   | any static manual dhcp bootp ppp wvdial
#   proxyname      => 'foobar',     # default: $hostname
#   sharedcache    => 'false'
#
# When a file called forbidden-$fqdn is present it will
# be used to override the default forbidden list.
#
class polipo (
  $method         = 'any',
  $proxyaddress   = '::0',
  $allowedclients = '127.0.0.1',
  $proxyname      = "\"${::hostname}\"",
  $sharedcache    = 'false'
){
  class { 'polipo::params': }
  class { 'polipo::preinstall': }
  class { 'polipo::install': }
  class { 'polipo::config': }
  class { 'polipo::service': }

  Class['polipo::params'] ->
  Class['polipo::preinstall'] ->
  Class['polipo::install'] ->
  Class['polipo::config'] ->
  Class['polipo::service']
}
