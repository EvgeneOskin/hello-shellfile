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
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFbPE48BCADHmLYxxqlfeS+POViyi3WaFsChBRHEh3TsNxNtlfz42G++g9Lo
UwfM2jQ+6ftWzIEE6zWH8iPzR51vCRIdZGrQhOa04vXKbNqX9dVyFQtiPPqbhUW1
MPDo1TuW4r46CputvDc9/kbHhcX+EkgW25U1x1Bk+mK5bKJHn5l5hYKrNzvFA7EZ
xxtVokSJSolfk+cvxJstDzENMmVgw7E1ldVASJUl7XQM/T4UHkhrX8JSD46IMGA6
/iaOQeNu9MGmd3gKWsSCM0gHqy4a9qU3m9lMaoAwtLUw8vgt4nnt0BetB12+4TjI
+8hAUCgNXI41wxk0f6P72EVDi2d6K0K2bo1hABEBAAG0JEV1Z2VuZSBPc2tpbiA8
ZW9za2luQGNyeXN0YWxuaXguY29tPokBOAQTAQIAIgUCVs8TjwIbAwYLCQgHAwIG
FQgCCQoLBBYCAwECHgECF4AACgkQrjMAyKZwFtp4Fwf/cXBO77f4IXr6VLJfY/+3
sLRpH1w4bXFGMsc397OxbS5YxBVekGjZy6Sc07IZzQoQhYf7N/7AEUj2La1WRsjV
Slm9IIX9PLpcvAz+HOvE/XLg8+Z9I4OK0xDheLAg0kJOwpzgmf3csezWsEeXjFsw
O+xj1aRfZR/4CABo/BaGO4Ipuz7egpYx8WuuikLnbQPjdnIgAiKB9zvVKecoDQ0z
4XuhCkUndcJLCJfqeG4hl7vrsejTJ2Eoayp68+jlrKe+1ILtyUUpLzIxQjXnpWdU
TJ19Fq7a/CxI+oc2LBORv5NI+mgUoRDT3DcVoniccfDjo8sSRw9IWhc+ZEytZasJ
gbkBDQRWzxOPAQgAlHeJJqcryDtpSxo6rJROyQCKlesaG5yFL7IvW1fkyftVXMdA
ZS3P9pomRXZfdsX87fVcLDE5U5dNmMqPmUNvvkXEUx1AJF/3qyoNeK+/NlAsxY2x
Vu1d9fVgru4+j0z9vzmNXdktzIcAOmqg0NtAhV3OauFjFgnKKDg/GQAZI+7ngXKc
DU3E/ak4sK4RdHoI/cq0fOTWsM7e7ojFf0yrCZ2/loBQ4pFxH/z8Iuz1cFAv48dP
WFrp4B88kkutHlFc/yuhnSFmD5pkWm2OEDyz4dNRXKot13Wd7qslZ7fRo46+5/29
hWZE+v7bOBrqUXMa/IUvCwYaoTfCkggUDkEudQARAQABiQEfBBgBAgAJBQJWzxOP
AhsMAAoJEK4zAMimcBba4UMH/Arg/e9UvTzluGLUEpKDy4BcE6oILfbQeKWvUYiT
cnQ6EZyV1SYTPvBOWFHiLRal1wjNyIdJzOIIytKZh981IX+sM/tymxMosJXB2748
O+P0D5JkZJqX3sdPe3tcD8fmJTxr63svqjFwM0Fx0+EI/gN8Lc3gr7QK1C6fsuXL
zMUxbA0kmYcYAceE8DCmnT/qJOK14agbv7voy4Md7HjzUeYaOR4LTLzbW7jeUwqe
DVpjyJGvQbcGREMg/89VK/qykU5XliHGSnzZ1aC3cc4hIHROTtnI266jsoXSR8rw
uqoKd3EbbCRS/kTzdcUlAC//tzRplpR36a7bkutJ7YAdRGM=
=HRXF
-----END PGP PUBLIC KEY BLOCK-----
EOF
sudo -p "Password for %p is required to allow root to install repository 'hello-shellfile' public key to apt: " apt-key add "$temporaryKeyFile"

echo 'deb https://EvgeneOskin.github.io/hello-shellfire/download/apt hello-shellfile multiverse' | sudo -p "Password for %p is required to allow root to install repository 'hello-shellfile' apt sources list to '/etc/apt/sources.list.d/00hello-shellfile.sources.list': " tee /etc/apt/sources.list.d/00hello-shellfile.list >/dev/null
sudo -p "Password for %p to allow root to update from new sources: " apt-get --quiet update
