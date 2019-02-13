## COLE NO TERMINAL O CÓDIGO A SEGUIR: rm -rf PDUrobot fast-install.sh&&wget https://raw.githubusercontent.com/matheusbach/PDUrobot/versão2.0/fast-install.sh&&sudo chmod -R 755 *&&./fast-install.sh

sudo apt-get update

sudo apt-get upgrade

sudo apt-get install libreadline-dev libssl-dev lua5.2 liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev -y

ps -ef | grep bot | grep -v grep | awk '{print $2}' | xargs kill -9
killall lua

git clone -b versão2.0 --single-branch https://github.com/matheusbach/PDUrobot.git

sudo chmod -R 755 *

cd PDUrobot

./install.sh

screen ./launch.sh