git
=================

Manage install of git package and include function like clone, pull or submodule

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
 * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview
This module manage installation of git. It work and it's tested on:
 * Windows 7 (x86/x64) (only package install and git::clone define)
 * Ubuntu 10.04 and earlier

##Module Description
 * In a windows environment this module:
    * download the installation file in a tmp\_dir and, after, it installs it
 * in a linux environment it use the package resource. Add a repository and install last version present

##Setup

 * in windows parameter *tmp_dir* is mandatory:
    * *class{'git': tmp_dir => "C:\\tmp_path"}*
 * in Ubuntu
    * *include git*

###Setup Requirements
in windows it require modules:
 * softecspa/puppet-cygwin
 * basti1302/puppet-windows-path

In Ubuntu it require modules:
 * softecspa/apt

##Usage
 * simple install git:

    include git
 * windows

    class{'git': tmp_dir => 'C:\\tmp_path'}


## Limitations
