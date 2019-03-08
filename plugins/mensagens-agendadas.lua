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

  --BOM DIA
  if horario_local == '05:45' then
    fileid = 'CAADAQADowIAAoe7Lx_Tqx3y7MrcgAI'
    chatid = '-1001178906515'
    photo_voice_or_video = false   --true se a midia for foto, voz ou video, senão coloque false
    special_method = nill --photo, voice ou video
    if photo_voice_or_video == true then
      api.sendMediaId(chatid, fileid, special_method) --photo, voices, video precisam
    else
      api.sendDocumentId(chatid, fileid)
    end
  end

  --FIODOALMO
  if horario_local == '11:45' then
  --PDU
    fileid = 'AgADAQADgagxG0mWqUdin5qFO1dxw4t3DDAABDseGiWMd1q59MQDAAEC'
    chatid = '-1001178906515'
    photo_voice_or_video = true --true se a midia for foto, voz ou video, senão coloque false
    special_method = 'photo' --photo, voice ou video
    if photo_voice_or_video == true then
      api.sendMediaId(chatid, fileid, special_method) --photo, voices, video precisam
    else
      api.sendDocumentId(chatid, fileid)
    end

  --Auschwitz
    fileid = 'AgADAQADgagxG0mWqUdin5qFO1dxw4t3DDAABDseGiWMd1q59MQDAAEC'
    chatid = '1001340438412'
    photo_voice_or_video = true --true se a midia for foto, voz ou video, senão coloque false
    special_method = 'photo' --photo, voice ou video
    if photo_voice_or_video == true then
      api.sendMediaId(chatid, fileid, special_method) --photo, voices, video precisam
    else
      api.sendDocumentId(chatid, fileid)
    end
  end

  --22:22
  if horario_local == '22:22' then
    chatid = '-1001178906515'
    api.sendMessage(chatid, "22:22")
  end
end

return plugin