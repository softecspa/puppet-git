define git::config_usermail (
  $git_username="root on ${::hostname}",
  $git_usermail="root@${::fqdn}"
) {

  exec { 'set-git-username':
    command => "/usr/bin/git config --global user.name '${git_username}'",
    unless  => "/usr/bin/git config --global user.name | egrep '^${git_username}\$'",
  }

  exec { 'set-git-usermail':
    command => "/usr/bin/git config --global user.email '${git_usermail}'",
    unless  => "/usr/bin/git config --global user.email | egrep '^${git_usermail}\$'",
  }
}
