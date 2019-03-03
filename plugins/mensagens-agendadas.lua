local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.cron()

  --BOM DIA
  if hora == '05:45' then
    fileid = 'CAADAQADowIAAoe7Lx_Tqx3y7MrcgAI'
    chatid = '-1001178906515'
    photo_voice_or_video = no
    special_method = nill --photo, voice ou video
    hora = os.date('%H:%M')
    if photo_voice_or_video == true then
      api.sendMediaId(chatid, fileid, special_method) --photo, voices, video precisam
    else
      api.sendDocumentId(chatid, fileid)
    end
  end

  --FIODOALMO
  if hora == '11:45' then
    fileid = 'AgADAQADgagxG0mWqUdin5qFO1dxw4t3DDAABDseGiWMd1q59MQDAAEC'
    chatid = '-1001178906515'
    photo_voice_or_video = true
    special_method = 'photo' --photo, voice ou video
    hora = os.date('%H:%M')
    if photo_voice_or_video == true then
      api.sendMediaId(chatid, fileid, special_method) --photo, voices, video precisam
    else
      api.sendDocumentId(chatid, fileid)
    end
  end

end

return plugin