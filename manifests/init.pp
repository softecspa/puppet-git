# == Class: GIT
#
# Setup packages needed to manage GIT repos.
#
# === Parameters
#
# No one.
#
# === Variables
#
# No one
#
# === Authors
#
# Lorenzo Salvadorini <lorenzo.salvadorini@softecspa.>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class git (
  $tmp_dir = ''
){

  class {'git::install':
    tmp_dir => $tmp_dir
  }
  include git::config
  
  Class['git::install'] ->
  Class['git::config']
}
