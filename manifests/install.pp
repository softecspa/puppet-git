class git::install (
  $tmp_dir = ''
){

  case $::operatingsystem {
    'ubuntu': {
      if !defined(Package['git-core']) {
      # abilitare il mirror non appena cassiamo le hardy
      # non abbiamo i deb per quella dist
        softec_apt::ppa{'git-core/ppa':
          mirror  => true,
          key     => 'E1DF1F24'
        } ->
        package { 'git-core':
          ensure => latest
        }
      }
    }
    'windows': {
      if $tmp_dir == '' {
        fail('you must specify tmp_dir in git class for OS windows')
      }

      $source   = 'https://github.com/msysgit/msysgit/releases/download/Git-1.9.2-preview20140411/Git-1.9.2-preview20140411.exe'
      $filename = "${tmp_dir}\\Git-1.9.2-preview20140411.exe"
      $pkg_name = 'Git version 1.9.2-preview20140411'

      exec {'download git':
        command   => "\$(New-Object System.Net.WebClient).DownloadFile('$source','$filename')",
        creates   => $filename,
        provider  => powershell,
        path      => $::path,
        before    => Package[$pkg_name],
      }

      package {$pkg_name:
        ensure          => installed,
        source          => $filename,
        provider        => 'windows',
        install_options => ['/verysilent']
      }
    }
  }
}
