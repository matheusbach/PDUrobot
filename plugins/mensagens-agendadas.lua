local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.cron()

  hora_UTC = os.date('!%H')
  minuto_UTC = os.date('!%M')
  timezone_horas = -3       --coloque seu fuso horário em horas aqui
  timezone_minutos = 00     --coloque seu fuso horário em minutos aqui
  hora_local = hora_UTC+timezone_horas
  if hora_local < 0 then hora_local = hora_local + 24 end
  minuto_local = minuto_UTC+timezone_minutos
  horario_local = hora_local..":"..minuto_local

  --22:22 PDU
  if horario_local == '22:22' then
    chatid = '-1001178906515'
    api.sendMessage(chatid, "22:22")
  end
end

return plugin