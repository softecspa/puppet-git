# == Define: git::submodule
#
# Clone a GIT repo as a submodule of another repo
#
# === Parameters
#
# [*namevar*]
#   The name of the define is only used to reference the Resource
#
# [*url*] (required)
#   Public where to get the code from.  
#
# [*path*] (required)
#   Local directory where to create the working copy of the code.  
#
#
# === Authors
#
# Author Name <lorenzo.salvadorini@softecspa.it>
#
# === Copyright
#
# Copyright 2012 Softec SpA
#
define git::submodule($url, $path) {

  include git

  if $url == undef {
     fail('Repository URL is needed')
  }
  
  if $path == undef {
     fail('Path where to put repository is needed')
  }

  exec { "create-submodule-$repo":
    command => "git submodule add -f $url $path",
    creates  => $path,
    require  => Package['git-core'],
  }
}
