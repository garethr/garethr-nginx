# == Class nginx::params
#
# This class is meant to be called from nginx
#
class nginx::params {
  $repo = 'distro'
  $ensure = 'present'
}
