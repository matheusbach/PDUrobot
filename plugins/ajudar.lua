local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.onTextMessage(msg, blocks)

  if blocks[1] == 'ajudar' or blocks[1] == 'permitame' or blocks[1] == 'pesquisar' or blocks[1] == 'google' then
    if not  blocks[2] then
      api.sendMessage(msg.chat.id, 'Digite algo após o comando. EX: `/ajudar como desentortar o pau`', true)
    else

    local link = 'https://permita.me/?q=' .. blocks[2] .. ''
    local keyboard = {
        inline_keyboard = {
            {{text = ("Acessar Resultado"), url = link}} 
        }
    }
    api.sendMessage(msg.chat.id, 'Utilizei meus recursos avançados de *Inteligência Artificial* para encontrar o melhor resultado *baseado em suas últimas mensagens*', true, keyboard, msg.message_id)
    end
  end
end

plugin.triggers = {
  onTextMessage = {
    config.cmd..'(ajudar) (.*)$',
    config.cmd..'(ajudar)$',
    config.cmd..'(permitame) (.*)$',
    config.cmd..'(permitame)$',
    config.cmd..'(pesquisar) (.*)$',
    config.cmd..'(pesquisar)$',
    config.cmd..'(google) (.*)$',
    config.cmd..'(google)$',
  }
}

return plugin