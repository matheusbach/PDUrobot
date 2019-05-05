local config = require 'config'
local api = require 'methods'
local u = require 'utilities'

local plugin = {}


local function get_texto(bIncinerados)
	return _([[
	🔥 *INCINERADOR* 🔥
		
	Neste recinto:
	*%s* baianos
	Foram incinerados.
	
	Aproveite enquanto o [incinerador](https://t.me/joinchat/AAAAAFf8rRWSpUJNFqUPgA) está quente
	]]):format(bIncinerados)
end

local function get_botoes()
	return {
		inline_keyboard = {
			{
				{text = _("Incinerar Baiano"), callback_data = string.format('incinerador:adicionarBaiano')}
			},
		}
	}
end

function plugin.onTextMessage(msg, blocks)
	local FornalheiroKey = 'chat:'..msg.chat.id..':ultimoFornalheiro'
	local ultimoFornalheiro = db:get(FornalheiroKey)
	if ultimoFornalheiro then
		--local msg_id = tonumber(db:hget(hash, 'msg_id'))
		api.sendReply(msg, 'Um incinerador já está aceso.', true)
    else
    	local uFornalheiro = u.getname_final(msg.from)
		db:setex(FornalheiroKey, 43200, uFornalheiro) --12 horas mínimas entre mensagens
	  
		if blocks[1] == 'incinerador' then
			local hash = string.format('incinerador:%d', msg.chat.id)
			local bIncinerados = tonumber(db:hget(hash, 'bNumber')) --checa qual número está no contador de incinerados
			if bIncinerados == nil then bIncinerados = 0 end

			local botoes = get_botoes()
			local texto = get_texto(bIncinerados)

			local mensagemIncinerador = api.sendMessage(msg.chat.id, texto, true, botoes) --envia a mensagem
		end
	end
end

function plugin.onCallbackQuery(msg, blocks)
	local IncineradorKey = 'chat:'..msg.from.id..':ultimoIncinerador'
	local ultimoIncinerador = db:get(IncineradorKey)
	if ultimoIncinerador then
		api.answerCallbackQuery(msg.cb_id, "Você já usou o incinerador hoje")
	else
    	local uIncinerador = u.getname_final(msg.from)
		db:setex(IncineradorKey, 72000, uIncinerador) --20 horas minimas para usar o incinerador novamente
		local hash = string.format('incinerador:%d', msg.chat.id)
		local text
		local quem
		if blocks[1] == 'adicionarBaiano' then
			local bIncinerados = tonumber(db:hget(hash, 'bNumber')) --checa qual número está no contador de incinerados
			if bIncinerados == nil then bIncinerados = 0 end
			quem = "BAIANO"

			db:hset(hash, 'bNumber', math.ceil(bIncinerados+1)) --adiciona um novo incinerado ao contador

		end

		local bIncinerados = tonumber(db:hget(hash, 'bNumber')) --checa qual número está no contador de incinerados
		local botoes = get_botoes()
		local texto = get_texto(bIncinerados)

		api.editMessageText(msg.chat.id, msg.message_id, texto, true, botoes) -- atualiza a mensagem
	
		api.answerCallbackQuery(msg.cb_id, "🔥 Parabéns! Você incinerou mais um " ..quem.. " 🔥")

		api.sendMessage(-1001476177173, '[' .. msg.from.first_name .. '](https://t.me/' .. msg.from.username .. ') incinerou um *' ..quem .. '*', true, keyboard)
		
	end
end

plugin.triggers = {
	onTextMessage = {
		config.cmd..'(incinerador)$',
	},
	onCallbackQuery = {
		'^###cb:incinerador:(.*)$',
	},
}

return plugin
