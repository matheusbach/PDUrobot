## COLE NO TERMINAL O CÓDIGO A SEGUIR: rm -rf PDUrobot fast-install.sh&&wget https://raw.githubusercontent.com/matheusbach/PDUrobot/master/fast-install.sh&&sudo chmod -R 755 *&&./clone-run.sh


ps -ef | grep bot | grep -v grep | awk '{print $2}' | xargs kill -9
killall lua

git clone -b master --single-branch https://github.com/matheusbach/PDUrobot.git

sudo chmod -R 755 *

cd PDUrobot

screen ./launch.sh
