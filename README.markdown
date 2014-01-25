Puppet module for installing, but not configuring, Nginx.

[![Build
Status](https://secure.travis-ci.org/garethr/garethr-nginx.png)](http://travis-ci.org/garethr/garethr-nginx)


## Usage

The module can use the distribution packages or alternatively the
official [Nginx packages](http://nginx.org/en/linux_packages.html).

```puppet
include nginx
```

Alternatively use the stable or mainline releases:

```puppet
class { 'nginx':
  repo => 'mainline',
}
```

or 

```puppet
class { 'nginx':
  repo => 'stable',
}
```

if you want to remove Nginx and it's associated service then you can
set:

```puppet
class { 'nginx':
  ensure => 'absent',
}
```

## Rationale

It is pretty much impossible to abstract away all the features and
functionality of Nginx configuration, and I'm not sure it would be a
good idea even if you could. Plus I quite like writing Nginx config
files. All the other Nginx modules I've seen bring too many opinions
with them for my liking.
