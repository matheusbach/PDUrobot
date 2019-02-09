## COLE NO TERMINAL O CÓDIGO A SEGUIR: rm -rf PDUrobot fast-install.sh&&wget https://raw.githubusercontent.com/matheusbach/PDUrobot/master/fast-install.sh&&sudo chmod -R 755 *&&./fast-install.sh

sudo apt-get update

sudo apt-get upgrade

sudo apt-get install libreadline-dev libssl-dev lua5.2 liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev -y

git clone https://github.com/matheusbach/PDUrobot

sudo chmod -R 755 *

cd PDUrobot

./install.sh

./launch.sh
