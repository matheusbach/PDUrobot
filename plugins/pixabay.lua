local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.onTextMessage(msg, blocks)

  if blocks[1] == 'img' then
    local link = 'https://pixabay.com/api/?key=9491100-af4da1d320dc041cebec7cd64&q=' .. blocks[2] .. ''
    api.sendMessagePreview(msg.chat.id, 'Primeiro resultado da pixabay para ' .. blocks[2] .. '[⠀]('.. link ..')' , true)
    end
end

plugin.triggers = {
  onTextMessage = {
    config.cmd..'(img) (.*)$',
  }
}

return plugin