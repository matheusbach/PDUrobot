#!/usr/bin/env bash

killall lua

    echo -e "\e[1;36mUpdating packages\e[0m"
    sudo apt-get update -y

    echo -e "\e[1;36mInstalling dependencies\e[0m"
    sudo apt-get install libreadline-dev libssl-dev lua5.2 luarocks liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev -y
    
    echo -e "\e[1;36mInstalling LuaRocks from sources\e[0m"
    
    git clone http://github.com/keplerproject/luarocks
    cd luarocks
    ./configure --lua-version=5.2
    make build
    sudo make install
    cd ..
    
    echo -e "\e[1;36mInstalling rocks\e[0m"
    
    rocks="luasocket luasec redis-lua lua-term serpent dkjson Lua-cURL"
    for rock in $rocks; do
        sudo luarocks install $rock
    done
       
