# Class: polipo::config
#
#
class polipo::config {
  File {
    owner   => "${polipo::params::polipo_user}",
    group   => "${polipo::params::polipo_group}",
    require => Class['polipo::install'],
    notify  => Service["${polipo::params::polipo_name}"],
  }

  file {
    "${polipo::params::polipo_confdir}":
      ensure => directory;

    "${polipo::params::polipo_confdir}/config":
      ensure  => file,
      content => template ('polipo/config.erb');

    "${polipo::params::polipo_confdir}/forbidden":
      ensure  => file,
      source => [
        "puppet:///modules/polipo/forbidden-${::fqdn}",
        'puppet:///modules/polipo/forbidden',
      ];

    "${polipo::params::polipo_confdir}/options":
      ensure  => file,
      content => template ('polipo/options.erb');

    "${polipo::params::polipo_cachedir}":
      ensure => directory,
  }

  cron {
    'Purge Polipo cache every two weeks':
      command  => "kill -USR1 $(cat ${polipo::params::polipo_pidfile}); sleep 1; polipo -x; kill -USR2 $(cat ${polipo::params::polipo_pidfile})",
      user     => 'root',
      month    => '*',
      monthday => ['1', '14'],
      hour     => '0',
      minute   => '0',
  }

  logrotate::file {
    "${polipo::params::polipo_name}":
      source     => "/etc/logrotate.d/${polipo::params::polipo_name}",
      log        => '/var/log/polipo/*.log',
      postrotate => "if [ -f '${polipo::params::polipo_pidfile}' ] ; then kill -USR1 '$(cat ${polipo::params::polipo_pidfile}') ; fi",
      rotation   => [
        'compress',
        'daily',
        'missingok',
        'rotate 7',
        "create 644 ${polipo::params::polipo_user} ${polipo::params::polipo_group}",
      ],
  }
}
