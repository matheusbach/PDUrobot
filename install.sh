#!/usr/bin/env bash

echo -e "\e[1;36mUpdating packages\e[0m"
sudo apt-get update -y
sudo apt-get upgrade -y

echo -e "\e[1;36mInstalling dependencies\e[0m"
sudo apt-get install libreadline-dev libssl-dev lua5.2 luarocks liblua5.2-dev git make unzip redis-server curl lua-curl wget screen libcurl4-gnutls-dev gcc -y

git clone https://github.com/george0884/lua-curl-error && cd lua-curl-error && tar -xzvf curl.tar.gz && sudo cp curl -r /usr/include/ && cd .. && sudo rm -Rf lua-curl-error
    
echo -e "\e[1;36mInstalling LuaRocks from sources\e[0m"
    
git clone http://github.com/keplerproject/luarocks
cd luarocks
./configure --lua-version=5.2
make build
sudo make install
cd ..
    
echo -e "\e[1;36mInstalling rocks\e[0m"
    
rocks="luasocket luasec redis-lua lua-term dkjson Lua-cURL lua-cjson luautf8"
for rock in $rocks; do
    sudo luarocks install $rock
done

sudo luarocks install serpent 0.28-1

sudo chmod -R 755 .
