local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local socket = require 'socket'

local plugin = {}

--local function get_welcome(msg)

--local sem_username = _('*%s*, se você não definir um @username será banido. [Aprenda a definir um](https://t.me/panelinhadobananal/263467)'):format(msg.from.first_name)
--local sem_foto = _('*%s*, se você não botar uma foto de perfil será banido. [Aprenda a botar uma](https://t.me/panelinhadobananal/263466)'):format(msg.from.first_name)
--local sem_ambos = _('*%s*, se você não definir um @username e uma foto de perfil será banido. [Aprenda a definir um @username](https://t.me/panelinhadobananal/263467) e [Aprenda a definir uma foto de perfil](https://t.me/panelinhadobananal/263466)'):format(msg.from.first_name)

--if fotos.result.total_count == 0 then
--	local aviso_novouser = sem_foto
--if msg.from.username == nil then
--local sem_username = _('*%s*, se você não definir um @username será banido. [Aprenda a definir um](https://t.me/panelinhadobananal/263467)'):format(msg.from.first_name)
--local res = api.sendMessage(msg.chat.id, sem_username, true)
--	local fotos = api.getUserProfilePhotos(msg.from.id)
--	if fotos.result.total_count == 0
--	local aviso_novouser = sem_ambos
--end
--end

--function plugin.onTextMessage(msg, blocks)
--	if blocks[1] == 'new_chat_member' then
--		local text, reply_markup = get_welcome(msg)
--		api.sendMessage(msg.chat.id, text, true, reply_markup, nil, link_preview)
--	end
--end



function plugin.onTextMessage(msg, blocks)
	api.sendMessage(msg.chat.id, 'testado', true, nil, nil, link_preview)
if blocks[1] == 'new_chat_member' then
if msg.user.id == nil then
local sem_username = _('*%s*, se você não definir um @username será banido. [Aprenda a definir um](https://t.me/panelinhadobananal/263467)'):format(msg.from.first_name)
api.sendMessage(msg.chat.id, sem_username, true, nil, nil, link_preview)
end
end
end



plugin.triggers = {
	onTextMessage = {
		'^###(new_chat_member)$',
	}
}

return plugin