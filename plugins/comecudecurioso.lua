local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.onTextMessage(msg, blocks)

  if blocks[1] == '/comer_cu_de_quem_ta_lendo' then
  local key_comando = 'chat:'..msg.chat.id..':ultimocomando'
  local last_user = db:get(key_comando)
  if last_user then
  else
    local nome = u.getname_final(msg.from)
    db:setex(key_comando, 3600, nome)
    api.sendMessage(msg.chat.id, 'comi o cu de quem ta lendo kkkkkkk' , true)
  end
end
end

plugin.triggers = {
  onTextMessage = {
    '(/comer_cu_de_quem_ta_lendo)$',
    --config.cmd..'(comer_cu_de_quem_ta_lendo)$',
    --config.cmd..'(comer_cu_de_quem_ta_lendo)$',
    --config.cmd..'(comer_cu_de_quem_ta_lendo)$',
  }
}

return plugin