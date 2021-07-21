## COLE NO TERMINAL O CÓDIGO A SEGUIR PARA MANTER O ARQUIVO DE CONFIGURAÇÃO E SUBSTITUIR O RESTANTE DO BOT: cp -f --remove-destination PDUrobot/config.lua config.lua&&  rm -rf PDUrobot clone-run.sh&&wget https://raw.githubusercontent.com/matheusbach/PDUrobot/master/clone-run.sh&&sudo chmod -R 755 *&&./clone-run.sh

### NOTA: Esse código só irá funcionar caso o bot já tenha sido instalado e o arquivo de configuração esteja no diretório exigido

if [${PWD##*/} = PDUrobot]
then
  cd ..
fi

ps -ef | grep bot | grep -v grep | awk '{print $2}' | xargs kill -9
killall lua

git clone -b master --single-branch https://github.com/matheusbach/PDUrobot.git

cp -f --remove-destination config.lua PDUrobot/config.lua

sudo chmod -R 755 PDUrobot

cd PDUrobot

screen ./launch.sh
