## COLE NO TERMINAL O CÓDIGO A SEGUIR: rm -rf PDUrobot fast-install.sh&&wget https://raw.githubusercontent.com/matheusbach/PDUrobot/master/fast-install.sh&&sudo chmod -R 755 *&&./fast-install.sh

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install libreadline-dev libssl-dev lua5.2 liblua5.2-dev git make unzip redis-server curl lua-curl libcurl4-gnutls-dev -y

ps -ef | grep bot | grep -v grep | awk '{print $2}' | xargs kill -9
killall lua

./install.sh

./clone-run.sh
