# == Define: git::clone
#
# Clone a GIT repository
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
# [*protocol*]
#   Protocol used to clone. If protocol is specified in url, this parameter will be ignored.
#   Default: https
#
# === Authors
#
# Author Name <lorenzo.salvadorini@softecspa.it>
#
# === Copyright
#
# Copyright 2012 Softec SpA
#
define git::clone(
  $url,
  $path,
  $protocol = 'https',
  $user     = ''
) {

  include git

  if $url == undef {
    fail('Repository URL is needed')
  }

  if $path == undef {
    fail('Path where to put repository is needed')
  }

  $proto= inline_template("<%= @url.split(':').at(0) %>")
  if $proto == 'git' or $proto == 'https' {
    $prefix_proto=''
  }
  else {
    $prefix_proto="$protocol://"
  }

  $x86 = $::architecture ?{
    'x64'   => ' (x86)',
    'amd64' => ' (x86)',
    default => ''
  }

  $git_clone_path = $::operatingsystem? {
    'windows' => "C:\\Program Files${x86}\\Git\\cmd",
    default   => $::path
  }

  $real_user = $user?{
    ''      => undef,
    default => $user
  }

  exec { "clone-$url":
    command   => "git clone ${prefix_proto}${url} $path",
    creates   => $path,
    require   => Class['git'],
    path      => $git_clone_path,
    user      => $real_user
  }
}
