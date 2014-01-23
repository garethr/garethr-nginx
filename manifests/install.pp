# == Class nginx::intall
#
class nginx::install {

  if $nginx::repo != 'distro' {

    case $::osfamily {
      'Debian': {
        include apt

        if $nginx::repo == 'mainline' {
          $location = 'http://nginx.org/packages/mainline/ubuntu'
        } else {
          $location = 'http://nginx.org/packages/ubuntu'
        }

        apt::source { 'nginx':
          location          => $location,
          repos             => 'nginx',
          required_packages => 'debian-keyring debian-archive-keyring',
          key               => '7BD9BF62',
          key_source        => 'http://nginx.org/keys/nginx_signing.key',
          include_src       => false,
        }

        Apt::Source['nginx'] -> Package['nginx']
      }
      'RedHat': {
      }
      default: {}
    }
  }

  package { 'nginx':
    ensure => $nginx::ensure,
  }
}
