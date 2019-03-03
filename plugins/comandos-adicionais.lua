local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.onTextMessage(msg, blocks)
  if blocks[1] == '/comer_cu_de_quem_ta_lendo' or blocks[1] == '/comer_o_cu_de_quem_ta_lendo' then
    local key_comando = 'chat:'..msg.chat.id..':ultimocudequemtalendo'
    local last_user = db:get(key_comando)
    if last_user then
    else
      local nome = u.getname_final(msg.from)
      db:setex(key_comando, 14400, nome)
      api.sendMessage(msg.chat.id, 'comi o cu de quem ta lendo kkkkkkk' , true)
    end
  end

  if blocks[1] == '/comer_cu_de_curioso' or blocks[1] == '/comer_o_cu_de_curioso' then
    local key_comando = 'chat:'..msg.chat.id..':ultimocudecurioso'
    local last_user = db:get(key_comando)
    if last_user then
    else
      local nome = u.getname_final(msg.from)
      db:setex(key_comando, 14400, nome)
      api.sendMessage(msg.chat.id, 'comi o cu de curioso kkkkkkk' , true)
    end
  end

  if blocks[1] == '/cp' or blocks[1] == '/fotosdecriancapelada@kuruminha_bot' then
  local key_comando = 'chat:'..msg.chat.id..':ultimopedola'
  local last_user = db:get(key_comando)
  if last_user then
  else
    local nome = u.getname_final(msg.from)
    db:setex(key_comando, 9000, nome)
    local keyboard = {
      inline_keyboard = {
          {{text = ("Download Files"), url = 'https://bit.ly/2tNAhQQ'}} 
      }
  }
  api.sendMessage(msg.chat.id, '_não posso mandar aqui no grupo, mas clica no botão que te levo pra um lugar onde tem_' , true, keyboard)
  end
end
end

plugin.triggers = {
  onTextMessage = {
    '(/comer_cu_de_quem_ta_lendo)$',
    '(/comer_o_cu_de_quem_ta_lendo)$',
    '(/comer_cu_de_curioso)$',
    '(/comer_o_cu_de_curioso)$',
    '(/cp)$',
    '(/fotosdecriancapelada@kuruminha_bot)$',
  }
}

return plugin
