#!/bin/bash

echo -e "\e[1;36mAtualizando o Sistema\e[0m"
sudo apt update -y
sudo apt upgrade -y

echo -e "\e[1;36mInstallando dependencias\e[0m"
sudo apt install libreadline-dev libssl-dev lua5.2 luarocks liblua5.2-dev git make unzip redis-server curl lua-curl libcurl4-gnutls-dev tmux gcc -y

echo -e "\e[1;36mInstallando luarocks\e[0m"
git clone http://github.com/keplerproject/luarocks
cd luarocks
./configure --lua-version=5.2
make build
sudo make install
cd ..

echo -e "\e[1;36mInstallando bibliotecas luarocks\e[0m"

rocks="luasocket luasec redis-lua lua-term serpent dkjson Lua-cURL lua-cjson luautf8"
    for rock in $rocks; do
        sudo luarocks install $rock
    done

echo -e "\e[1;36mInstalando cURL lua\e[0m"
git clone https://github.com/george0884/lua-curl-error && cd lua-curl-error && tar -xzvf curl.tar.gz && sudo cp curl -r /usr/include/ && cd .. && sudo rm -Rf lua-curl-error

echo -e "\e[1;36mInstalacao da compatibilidade de sistema concluida. Lembre-se de configurar o arquivo config.lua\e[0m"

sudo chmod -R 755 .
