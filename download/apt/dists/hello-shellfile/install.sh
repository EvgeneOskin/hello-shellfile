#!/usr/bin/env sh
set -e
set -u

if [ -t 1 ]; then
	printf '%s\n' 'This script will install the apt repository hello-shellfile' 'It will change your apt keys, create or replace /etc/apt/sources.list.d/00hello-shellfile.sources.list, install apt-transport-https and update apt.' 'Press the [Enter] key to continue.'
	read -r garbage
fi

sudo -p "Password for %p to allow root to update from new sources before installing apt-transport-https: " apt-get --quiet update
sudo -p "Password for %p to allow root to  apt-get install apt-transport-https (missing in Debian default installs)" apt-get install apt-transport-https

temporaryKeyFile="$(mktemp --tmpdir hello-shellfile.key.XXXXXXXXX)"
trap 'rm -rf "$temporaryKeyFile"' EXIT HUP INT QUIT TERM
cat >"$temporaryKeyFile" <<EOF

EOF
sudo -p "Password for %p is required to allow root to install repository 'hello-shellfile' public key to apt: " apt-key add "$temporaryKeyFile"

echo 'deb https://EvgeneOskin.github.io/hello-shellfire/download/apt hello-shellfile multiverse' | sudo -p "Password for %p is required to allow root to install repository 'hello-shellfile' apt sources list to '/etc/apt/sources.list.d/00hello-shellfile.sources.list': " tee /etc/apt/sources.list.d/00hello-shellfile.list >/dev/null
sudo -p "Password for %p to allow root to update from new sources: " apt-get --quiet update
