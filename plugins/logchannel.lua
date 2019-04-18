local config = require 'config'
local u = require 'utilities'
local api = require 'methods'

local plugin = {}

local function get_alert_text(key)
	if key == 'new_chat_member' then
		return _("Registra sempre que um membro entra no grupo")
	elseif key == 'ban' then
		return _("Registra bans. Apenas bans com comando /ban")
	elseif key == 'kick' then
		return _("Registra kicks. Apenas kicks com comando /kick")
	elseif key == 'warn' then
		return _("Alertas serão registrados")
	elseif key == 'mediawarn' then
		return _("Medias não permitidas serão registradas")
	elseif key == 'spamwarn' then
		return _("Spam links/encainhamentos serão registrados (caso não sejam permitidos)")
	elseif key == 'flood' then
		return _("Registrar flood")
	elseif key == 'new_chat_photo' then
		return _("Registrar mudanças na foto do grupo")
	elseif key == 'delete_chat_photo' then
		return _("Registrar quando a foto do grupo é deletada")
	elseif key == 'new_chat_title' then
		return _("Registrar quando um admin muda o nome do grupo")
	elseif key == 'pinned_message' then
		return _("Registrar mensagens fixadas")
	elseif key == 'blockban' then
		return _("Registrar blockbans")
	elseif key == 'promote' then
		return _("Registrar quando um user recebe cargos de moderador")
	elseif key == 'demote' then
		return _("Registrar quando um user perde o mod")
	elseif key == 'cleanmods' then
		return _("Registrar quando um admin usa '/modlist -' para tirar mod de todos")
	elseif key == 'nowarn' then
		return _("Registrar quando advertências forem removidas de um user")
	elseif key == 'report' then
		return _("Registro de denúncias com o @admin como resposta")
	else
		return _("Descrição não disponível")
	end
end

local function toggle_event(chat_id, event)
	local hash = ('chat:%s:tolog'):format(chat_id)
	local current_status = db:hget(hash, event) or config.chat_settings['tolog'][event]
	
	if current_status == 'yes' then
		db:hset(hash, event, 'no')
	else
		db:hset(hash, event, 'yes')
	end
end	

local function doKeyboard_logchannel(chat_id)
	local event_pretty = {
		['ban'] = _('Ban'),
		['kick'] = _('Kick'),
		['unban'] = _('Desban'),
		['tempban'] = _('Tempban'),
		['report'] = _('Report'),
		['warn'] = _('Avisos'),
		['nowarn'] = _('Avisos resetados'),
		['new_chat_member'] = _('Novos membros'),
		['mediawarn'] = _('Avisos de midia'),
		['spamwarn'] = _('Avisos de Spam'),
		['flood'] = _('Flood'),
		['promote'] = _('Promoções de cargo'),
		['demote'] = _('Rebaixamentos de cargo'),
		['cleanmods'] = _('Todos moderadores rebaixados'),
		['new_chat_photo'] = _('Nova foto de grupo'),
		['delete_chat_photo'] = _('Foto de grupo removida'),
		['new_chat_title'] = _('Novo nome de grupo'),
		['pinned_message'] = _('Mensagens fixadas'),
		['blockban'] = _("Usuários bloqueados e banidos"),
		['block'] = _("Usuários bloqueados"),
		['unblock'] = _("Usuários desbloqueados")
	}
	
	local keyboard = {inline_keyboard={}}
	local icon
	
	for event, default_status in pairs(config.chat_settings['tolog']) do
		local current_status = db:hget('chat:'..chat_id..':tolog', event) or default_status
		icon = '✅'
		if current_status == 'no' then icon = '☑️' end
		table.insert(keyboard.inline_keyboard, {{text = event_pretty[event] or event, callback_data = 'logchannel:alert:'..event..':'..locale.language}, {text = icon, callback_data = 'logchannel:toggle:'..event..':'..chat_id}})
	end
	
	--back button
    table.insert(keyboard.inline_keyboard, {{text = '🔙', callback_data = 'config:back:'..chat_id}})
    
    return keyboard
end	

function plugin.onCallbackQuery(msg, blocks)
	if blocks[1] == 'logcb' then
		local chat_id = msg.target_id
		if not msg.from.admin then
			api.answerCallbackQuery(msg.cb_id, _("Você não é um administrador"), true)
		else
			if blocks[2] == 'unban' or blocks[2] == 'untempban' then
				local user_id = blocks[3]
				api.unbanUser(chat_id, user_id)
				api.answerCallbackQuery(msg.cb_id, _("Usuário desbanido!"), true)
			end
		end
	else
		if blocks[1] == 'alert' then
			if config.available_languages[blocks[3]] then
				locale.language = blocks[3]
			end
		    local text = get_alert_text(blocks[2])
		    api.answerCallbackQuery(msg.cb_id, text, true, config.bot_settings.cache_time.alert_help)
		else
		    local chat_id = msg.target_id
		    if not u.is_allowed('config', chat_id, msg.from) then
		    	api.answerCallbackQuery(msg.cb_id, _("Você não é mais admin"))
		    else
    	        local text
    	        
    	        if blocks[1] == 'toggle' then
    	            toggle_event(chat_id, blocks[2])
    	            text = '👌🏼'
    	        end
    	        
    	        local reply_markup = doKeyboard_logchannel(chat_id)
    	        if blocks[1] == 'config' then
    	        	local logchannel_first = _([[*Selecione oque vai ser registrado no canal de log*
✅ = Será registrado
☑️ = Não será registrado

Clique nas opções para ter mais informações sobre]])
    	        	api.editMessageText(msg.chat.id, msg.message_id, logchannel_first, true, reply_markup)
    	        else
    	        	api.editMarkup(msg.chat.id, msg.message_id, reply_markup)
    	        end
    	        
    	        if text then api.answerCallbackQuery(msg.cb_id, text) end
    	    end
    	end
	end
end

function plugin.onTextMessage(msg, blocks)
    if msg.chat.type ~= 'private' then
    	if not msg.from.admin then return end
	    
	    if blocks[1] == 'setlog' then
	    	if msg.forward_from_chat then
	    		if msg.forward_from_chat.type == 'channel' then
	    			if not msg.forward_from_chat.username then
	    				local res, code = api.getChatMember(msg.forward_from_chat.id, msg.from.id)
	    				if not res then
	    					if code == 429 then
	    						api.sendReply(msg, _('_Muitos pedidos!. Tente mais tarde_'), true)
	    					else
	    						api.sendReply(msg, _('_Eu preciso ser administrador do canal_'), true)
	    					end
	    			    else
	    					if res.result.status == 'creator' then
	    						local text
	    						local old_log = db:hget('bot:chatlogs', msg.chat.id)
	    						if old_log == tostring(msg.forward_from_chat.id) then
	    							text = _('_Já está usando esse canal_')
	    						else
	    							db:hset('bot:chatlogs', msg.chat.id,  msg.forward_from_chat.id)
	    							text = _('*Canal de log adicionado!*')
	    							if old_log then
	    								api.sendMessage(old_log, _("<i>%s</i> mudou o canal de log"):format(msg.chat.title:escape_html()), 'html')
	    							end
	    							api.sendMessage(msg.forward_from_chat.id, _("Registros de <i>%s</i> Serão postados aqui"):format(msg.chat.title:escape_html()), 'html')
	    						end
	    						api.sendReply(msg, text, true)
	    					else
	    						api.sendReply(msg, _('_Apenas o criador do canal pode sincronizar o grupo com o canal_'), true)
	    					end
	    				end
	    			else
	    				api.sendReply(msg, _('_Perdão, po enquanto apenas canais privados são suportados_'), true)
	    			end
	    		end
			else
				api.sendReply(msg, _("Você precisa *encminhar* a mensagem do canal pra cá"), true)
			end
    	end
    	if blocks[1] == 'unsetlog' then
    		local log_channel = db:hget('bot:chatlogs', msg.chat.id)
    		if not log_channel then
    			api.sendReply(msg, _("_Este grupo não está usando um canal de log_"), true)
    		else
    			db:hdel('bot:chatlogs', msg.chat.id)
    			api.sendReply(msg, _("*Canal de log removido*"), true)
    		end
		end
		if blocks[1] == 'logchannel' then
			local log_channel = db:hget('bot:chatlogs', msg.chat.id)
    		if not log_channel then
    			api.sendReply(msg, _("_Este grupo não está usando um canal de log_"), true)
    		else
    			local channel_info, code = api.getChat(log_channel)
    			if not channel_info and code == 403 then
    				api.sendReply(msg, _("_Esse grupo tem um canal de log salvo, porém eu não sou membro dele. Por isso eu nãop consigo te dar informações_"), true)
    			else
    				local channel_identifier = log_channel
    				if channel_info and channel_info.result then
    					channel_identifier = channel_info.result.title
    				end
    				api.sendReply(msg, _("<b>Esse grupo possui um canal de log</b>\nCanal: <code>%s</code>"):format(channel_identifier:escape_html()), 'html')
    			end
    		end
    	end
	else
		if blocks[1] == 'photo' then
			api.sendPhotoId(msg.chat.id, blocks[2])
		end
	end
end

plugin.triggers = {
	onTextMessage = {
		config.cmd..'(setlog)$',
		config.cmd..'(unsetlog)$',
		config.cmd..'(logchannel)$',
		
		--deeplinking from log buttons
		'^/start (photo):(.*)$'
	},
	onCallbackQuery = {
		 --callbacks from the log channel
		'^###cb:(logcb):(%w-):(%d+):(-%d+)$',
		
		--callbacks from the configuration keyboard
        '^###cb:logchannel:(toggle):([%w_]+):(-?%d+)$',
        '^###cb:logchannel:(alert):([%w_]+):([%w_]+)$',
        '^###cb:(config):logchannel:(-?%d+)$'
    }
}

return plugin
