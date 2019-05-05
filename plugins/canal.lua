local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local UTF8 = require'lua-utf8'
local json = require('dkjson')

local plugin = {}

function plugin.onTextMessage(msg, blocks)
  local key_comando = 'chat:'..msg.from.id..':canaldobananal'
  local last_user = db:get(key_comando)
  if last_user then
    api.sendReply(msg, "Você pode sugerir apenas 1 post a cada minuto. Vá com calma")
  else
    local nome = u.getname_final(msg.from)
    db:setex(key_comando, 60, nome) -- 1 minuto
    id_canal_canaldobananal = -1001409465086

    api.forwardMessage(id_canal_canaldobananal, msg.chat.id, msg.message_id)
    api.sendReply(msg, "Post enviado para avaliação.", true)
  end
end

plugin.triggers = {
  onTextMessage = {
    '(@canaldobananal)',
  }
}

return plugin