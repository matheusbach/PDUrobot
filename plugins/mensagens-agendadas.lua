local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.cron()

  --FIODOALMO
  local hora = os.date('%H:%M')
  if hora == '11:30' then
  api.sendDocumentId(-1001178906515, 'AgADAQADgagxG0mWqUdin5qFO1dxw4t3DDAABDseGiWMd1q59MQDAAEC', nil)
  end
  
end

return plugin