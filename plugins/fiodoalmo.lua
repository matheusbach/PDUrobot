local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local UTF8 = require'lua-utf8'
local json = require('dkjson')

local plugin = {}

function plugin.onTextMessage(msg, blocks)
  if msg.photo then
    local key_comando = 'chat:'..msg.from.id..':fiodoalmo'
    local last_user = db:get(key_comando)
    if last_user then
      api.sendReply(msg, "Você já fez seu fiodoalmo")
    else
      local nome = u.getname_final(msg.from)
      db:setex(key_comando, 61200, nome) -- 17 horas
      id_canal_fiodoalmo = -1001458172993

      api.forwardMessage(id_canal_fiodoalmo, msg.from.id, msg.message_id)
      api.sendReply(msg, "Rango postado no [canal](t.me/fiodoalmo)", true)
    end
  end
end

function plugin.cron()

  hora_UTC = os.date('!%H')
  minuto_UTC = os.date('!%M')
  timezone_horas = -3       --coloque seu fuso horário em horas aqui
  timezone_minutos = 00     --coloque seu fuso horário em minutos aqui
  hora_local = hora_UTC+timezone_horas
  if hora_local < 0 then hora_local = hora_local + 24 end
  minuto_local = minuto_UTC+timezone_minutos
  horario_local = hora_local..":"..minuto_local

  local fiodoalmo = {
    'AgADAQADgagxG0mWqUdin5qFO1dxw4t3DDAABDseGiWMd1q59MQDAAEC',
  }
  
  fileid = fiodoalmo[math.random(#fiodoalmo)]
    
  if horario_local == '11:45' then
    legenda = 'Mande uma foto de sua refeição com a legenda contendo "@fiodoalmo"'

    api.sendMediaId(-1001178906515, fileid, 'photo', nill, legenda) --Panelinha do Bananal
    api.sendMediaId(-1001340438412, fileid, 'photo', nill, legenda) --Auschwitz
  end
end

plugin.triggers = {
  onTextMessage = {
    '(@fiodoalmo)',
  }
}

return plugin