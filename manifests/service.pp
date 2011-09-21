# Class: polipo::service
#
#
class polipo::service {
  service {
    "${polipo::params::polipo_name}":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      require    => Class['polipo::config'];
  }
}
