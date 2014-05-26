class git::config {

  $git_username="root on $hostname"
  $git_usermail="root@${fqdn}"

  # fix per hardy: il pacchetto etckeeper su hardy si aspetterebbe una versione meno aggiornata di git-core rispetto a quella
  # che noi utilizziamo tramite ppa richiedendo alcuni binary che sono stati rimpiazzati da comandi di git.
  # Nello specifico git-ls-files è stato ripiazzato con git ls-files.

  case $::operatingsystem {
    'Ubuntu': {
      if $lsbdistcodename == 'hardy' {
        file {'/usr/bin/git-ls-files':
          ensure  => present,
                  mode    => 755,
                  owner   => root,
                  group   => root,
                  content => "#!/bin/bash\ngit ls-files \$*",
        }

        exec { 'disable-ssl-verify':
          command => "git config --global http.sslVerify false",
                  unless  => "git config --global http.sslVerify | egrep '^false\$'",
        }
      }

      exec { 'set-git-username':
        command => "git config --global user.name '${git_username}'",
                unless  => "git config --global user.name | egrep '^${git_username}\$'",
      }

      exec { 'set-git-usermail':
        command => "git config --global user.email '${git_usermail}'",
                unless  => "git config --global user.email | egrep '^${git_usermail}\$'",
      }   
    }
    'windows': {
      require windows_path
      
      windows_path {'git':
        ensure    => present,
        directory => 'C:\\Program Files\\Git\\cmd',
      }

    } 
  }
}
