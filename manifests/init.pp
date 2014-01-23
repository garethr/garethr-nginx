# == Class: nginx
#
# Full description of class nginx here.
#
# === Parameters
#
# [*ensure*]
#   Whether the package should be installed. Options are absent, present
#   or latest. Defaults to present
#
# [*repo*]
#   Which repository to use. Options are distro, stable or mainline
#   Defaults to distro
#
class nginx (
  $ensure  = $nginx::params::ensure,
  $repo    = $nginx::params::repo,
) inherits nginx::params {

  validate_re($repo, '^(distro|stable|mainline)$', 'Nginx.org provides only stable or mainline repositories')
  validate_re($ensure, '^(absent|present|latest)$', 'Package can be either absent or present')
  validate_re($::osfamily, '^(Debian|RedHat)$', 'This module only works on Debian or RedHat based systems')

  class { 'nginx::install': } ->
  class { 'nginx::config': } ~>
  class { 'nginx::service': } ->
  Class['nginx']
}
