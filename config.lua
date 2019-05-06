return {
	Token = "592305753:AAFG1b_9LuP5YVjKE-207Q5A7Ve-3YW-k4s",
	allowed_updates = {"message", "edited_message", "callback_query"},
	human_readable_version = '2.4',
	source_code = 'https://github.com/matheusbach/PDUrobot',
	grupo_bot = 'https://t.me/joinchat/?',	
	canal_bot = 'https://t.me/?',
	nome_bot = 'PDUrobot',
	channel = '@canaldobananal',
	lang = 'pt_BR',
	cmd = '^[/!#]',
	db = 0,
	-- END of CUSTOM APIs
	superadmins = {366723664}, -- COLOQUE SEU ID
	log = {
		chat = 366723664, -- COLOQUE O ID DE UM GRUPO OU O SEU
		admin = 366723664,-- CLOQUE UM ID DE USUARIO
		stats = nil
	},
	bot_settings = {
		cache_time = {
			adminlist = 1800, -- Admin Cache time, in seconds.
			alert_help = 72,  -- amount of hours for cache help alerts
			chat_titles = 1800
		},
		report = {
			duration = 1200,
			times_allowed = 2
		},
		notify_bug = false, --Notify if a bug occurs!
		log_api_errors = true, --Log errors, which happening whilst interacting with the bot api.
		stream_commands = true,
		admin_mode = false,
		debug_connections = false,
		realm_max_members = 600,
		realm_max_subgroups = 60
	},
	plugins = {
		'onmessage', --THIS MUST BE THE FIRST: IF AN USER IS FLOODING/IS BLOCKED, THE BOT WON'T GO THROUGH PLUGINS
		'antispam', --SAME OF onmessage.lua
		'antispam-comandos',
		--'realms', --must stay here
		'backup',
		'banhammer',
		'block',
		'configure',
		'dashboard',
		'floodmanager',
		'help',
		'links',
		'logchannel',
		'mediasettings',
		'menu',
		'moderators',
		'pin',
		'private',
		'private_settings',
		'report',
		'rules',
		'service',
		'setlang',
		'users',
		'warn',
		'welcome',
		'admin',
		'votekick',
		'qr',
		'pixabay',
		'comandos-adicionais',
		'mensagens-agendadas',
		'ip',
		'btc',
		'ajudar',
		'canaldobananal',
		'fiodoalmo',
		'incinerador',
		'extra', --must be the last plugin in the list
	},
	multipurpose_plugins = {},
	available_languages = {
		['pt_BR'] = 'Português 🇧🇷',
	},
	allow_fuzzy_translations = false,
	chat_settings = {
		['settings'] = {
			['Welcome'] = 'off',
			['Goodbye'] = 'off',
			['Extra'] = 'on',
			['Flood'] = 'off',
			['Silent'] = 'off',
			['Rules'] = 'on',
			['Reports'] = 'on',
			['Welbut'] = 'off', -- "read the rules" button under the welcome message
			['User votekick'] = 'on',
			['Weldelchain'] = 'on', -- delete the previously sent welcome message when a new welcome message is sent
			['Antibot'] = 'off'
		},
		['antispam'] = {
			['links'] = 'alwd',
			['linkswp'] = 'alwd',
			['forwards'] = 'alwd',
			['antipo'] = 'alwd', -- anti palavrões
			['antico'] = 'alwd', -- anti comandos
			['anticsujos']  = 'alwd', -- anti conteúdo sujo
			['antiuser'] = 'alwd', -- anti usernames					
			['warns'] = 15,
			['action'] = 'mute'
		},
		['flood'] = {
			['MaxFlood'] = 5,
			['ActionFlood'] = 'kick'
		},
		['char'] = {
			['Arab'] = 'allowed', --'kick'/'ban'
			['Rtl'] = 'allowed'
		},
		['floodexceptions'] = {
			['text'] = 'no',
			['photo'] = 'no', -- image
			['forward'] = 'no',
			['video'] = 'no',
			['sticker'] = 'no',
			['gif'] = 'no',
		},
		['warnsettings'] = {
			['type'] = 'ban',
			['mediatype'] = 'ban',
			['max'] = 3,
			['mediamax'] = 2
		},
		['welcome'] = {
			['type'] = 'no',
			['content'] = 'no'
		},
		['goodbye'] = {
			['type'] = 'custom',
		},
		['votekick'] = {
			['quorum'] = 10,
			['duration'] = 900,  -- 15 minutos
		},	
		['media'] = {
			['photo'] = 'ok', --'notok' | image
			['audio'] = 'ok',
			['video'] = 'ok',
			['sticker'] = 'ok',
			['gif'] = 'ok',
			['voice'] = 'ok',
			['contact'] = 'ok',
			['document'] = 'ok', -- file
			['link'] = 'ok',
			['game'] = 'ok',
			['location'] = 'ok'
		},
		['tolog'] = {
			['ban'] = 'yes',
			['kick'] = 'yes',
			['unban'] = 'yes',
			['tempban'] = 'yes',
			['report'] = 'yes',
			['warn'] = 'yes',
			['yeswarn'] = 'yes',
			['mediawarn'] = 'yes',
			['spamwarn'] = 'yes',
			['flood'] = 'yes',
			['promote'] = 'yes',
			['demote'] = 'yes',
			['new_chat_member'] = 'yes',
			['new_chat_photo'] = 'yes',
			['delete_chat_photo'] = 'yes',
			['new_chat_title'] = 'yes',
			['pinned_message'] = 'yes',
			['blockban'] = 'yes',
			['block'] = 'yes',
			['unblock'] = 'yes'
		},
		['modsettings'] = {
			['promdem'] = 'yes', --'yes': admins can promote or demote moderators; 'no': only the owner can
			['hammer'] = 'yes',
			['config'] = 'no',
			['texts'] = 'no'
		}
	},
	private_settings = {
		rules_on_join = 'off',
		reports = 'off'
	},
	chat_hashes = {'extra', 'info', 'links', 'warns', 'mediawarn', 'spamwarns', 'blocked', 'report'},
	chat_sets = {'whitelist', 'mods'},
	bot_keys = {
		d3 = {'bot:general', 'bot:usernames', 'bot:chat:latsmsg'},
		d2 = {'bot:groupsid', 'bot:groupsid:removed', 'tempbanned', 'bot:blocked', 'remolden_chats'} --remolden_chats: chat removed with $remold command
	}
}
