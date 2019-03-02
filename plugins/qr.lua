local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

function plugin.onTextMessage(msg, blocks)

  if blocks[1] == 'qr' then
    local link = 'https://qrickit.com/api/qr.php?qrsize=512&d=' .. blocks[2] .. ''
    local keyboard = {
        inline_keyboard = {
            {{text = ("Acessar codigo"), url = link}} 
        }
    }
    api.sendMessagePreview(msg.chat.id, '*QRcode* [⠀]('.. link ..')' , true)
    end
end

plugin.triggers = {
  onTextMessage = {
    config.cmd..'(qr) (.*)$',
    config.cmd..'(qr)$',
  }
}

return plugin