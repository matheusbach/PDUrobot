local config = require 'config'
local api = require 'methods'
local u = require 'utilities'

local plugin = {}

function plugin.onTextMessage(msg, blocks)
	if not u.is_allowed('texts', msg.chat.id, msg.from) then 
		local ultimoComandoApertadoAgora = blocks[1]
		local hash = string.format('ultimoComandoUsado:%d', msg.chat.id)
		local ultimoComandoApertado = db:hget(hash, 'ultimoComandoApertado') --checa qual número está no contador de incinerados

		db:hset(hash, 'ultimoComandoApertado', ultimoComandoApertadoAgora) -- lembra o ultimo comando usado
		
		if ultimoComandoApertado == ultimoComandoApertadoAgora then
			local comandoKey = 'chat:'..msg.chat.id..':ultimoComandoUsadoTempo'
			local ultimaVezUsado = db:get(comandoKey)
			if ultimaVezUsado then
				api.deleteMessage(msg.chat.id, msg.message_id) -- apaga o comando redundante
				api.sendMessage(msg.from.id, 'você spammou um comando que já havia sido mandado nas ultimas 3 horas no grupo ' .. msg.chat.title .. ', por isso apaguei sua mensagem')
				return false
			else
	    		local uComando = msg.chat.id
				db:setex(comandoKey, 10800, uComando) --3 horas minimas para usar o mesmo comando
				return true
			end
		end
	else
		return true
	end
end



plugin.triggers = {
	onTextMessage = {
		'^([/][%w_]*)$',
	},
}

return plugin
