# Class: polipo::install
#
#
class polipo::install {
  package {
    "${polipo::params::polipo_pkg}":
      ensure => installed;
  }
}
