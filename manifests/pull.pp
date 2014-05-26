# == Define: git::pull
#
# Pull form a GIT repository
#
# === Parameters
#
# [*namevar*]
#   The name of the define is only used to reference the Resource
#
# [*path*] (required)
#   Local directory where the working is located
#
# === Authors
#
# Andrea Cappelli <andrea.cappelli@softecspa.it>
#
# === Copyright
#
# Copyright 2013 Softec SpA
#
define git::pull($path) {

  include git

  if $path == undef {
    fail('Path where to put repository is needed')
  }

  exec { "pull-$path":
    command  => "git pull",
    cwd  => $path,
    require  => Class['git'],
  }
}
