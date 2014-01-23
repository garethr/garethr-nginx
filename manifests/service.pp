# == Class nginx::service
#
# This class is meant to be called from nginx
# It ensures the nginx service is running
#
class nginx::service {
  if $nginx::ensure != 'absent' {
    service { 'nginx':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
