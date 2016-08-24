#!/usr/bin/env sh
set -e
set -u

repoFilePath='/etc/yum.repos.d/hello-shellfile.repo'
repoFileContent='[hello-shellfile]
name=hello-shellfile
#baseurl=https://EvgeneOskin.github.io/hello-shellfire/download/yum/hello-shellfile
mirrorlist=https://EvgeneOskin.github.io/hello-shellfire/download/yum/hello-shellfile/mirrorlist
#gpgkey not set as repository is unsigned
gpgcheck=0
enabled=1
protect=0'

if [ -t 1 ]; then
	printf '%s\n' "This script will install the yum repository 'hello-shellfile'" "It will create or replace '$repoFilePath', update yum and display all packages in 'hello-shellfile'." 'Press the [Enter] key to continue.'
	read -r garbage
fi

printf '%s' "$repoFileContent" | sudo -p "Password for %p is required to allow root to install '$repoFilePath': " tee "$repoFilePath" >/dev/null
sudo -p "Password for %p is required to allow root to update yum cache: " yum --quiet makecache
yum --quiet info hello-shellfile 2>/dev/null
