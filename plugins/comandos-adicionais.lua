local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local socket = require 'socket'

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
          {{text = ("Download Files"), url = 'https://tinyurl.com/pack-cp-zip'}} 
      }
    }
    api.sendMessage(msg.chat.id, '_Por razões de segurança não poderei le enviar nesse grupo, acesse o `pack-cp.zip` usando o botão_' , true, keyboard)
    end
  end

  if blocks[1] == '/hora' or blocks[1] == '/time' then
    hora_UTC = os.date('!%H')
    minuto_UTC = os.date('!%M')
    segundo_UTC = os.date('!%S')
    timezone_horas = -3       --coloque seu fuso horário em horas aqui
    timezone_minutos = 00     --coloque seu fuso horário em minutos aqui
    hora_local = hora_UTC+timezone_horas
    if hora_local < 0 then hora_local = hora_local + 24 end
    minuto_local = minuto_UTC+timezone_minutos
    horario_local = hora_local..":"..minuto_local..":"..segundo_UTC

    api.sendMessage(msg.chat.id, '*Horário de Brasília:* ' .. horario_local ..' ('..hora_UTC..":"..minuto_UTC..":"..segundo_UTC..' UTC)', true)
  end

  if blocks[1] == '/fileid' or blocks[1] == '/fileinfo' then
    local replied_to = u.get_media_type(msg.reply)
    local file_id
    file_id = u.get_media_id(msg.reply)
    if file_id == false then
      api.sendMessage(msg.chat.id, 'tipo: `' .. replied_to ..'`\nfile id: `nulo`' , true, keyboard)
    else
      api.sendMessage(msg.chat.id, 'tipo: `' .. replied_to ..'`\nfile id: `' .. file_id .. '`' , true, keyboard)
    end
  end

  if blocks[1] == '/send' or blocks[1] == '/enviar' then
    api.sendDocumentId(msg.from.id, blocks[2])
    api.sendMediaId(msg.from.id, blocks[2], 'photo')
    api.sendMediaId(msg.from.id, blocks[2], 'voice')
    api.sendMediaId(msg.from.id, blocks[2], 'video')
  end

  if blocks[1] == 'Bom dia' or blocks[1] == 'Bodia' or blocks[1] == 'Bom Dia' or blocks[1] == 'bodia' or blocks[1] == 'bom dia' then
    local bodia = {
    'CAADAQADowIAAoe7Lx_Tqx3y7MrcgAI', -- stiker bom dia caralho
    'CQADAQADbAADQjUZRDcJzQXatxYTAg', -- bom dia torcida jovem do flamengo
    'CAADAQAD-AIAAoe7Lx-igkIFPnnonwI', -- sticker bom dia viadoes
    'CAADAQADlQoAAoyTExTTrDAlRzetwgI', -- sticker seu dia vai ser uma bosta
    'CAADAQADQQADrYvUFYlPxYGOiRUyAg', -- ohayo
    'CAADAQADQQADrYvUFYlPxYGOiRUyAg', -- ohayo
    'AwADBAADEqIAAmUXZAdVri1Cp3gkfAI', -- que tem de bom
    'AwADBAADmAADXzxMUPhM8seNqS8ZAg', -- xuxa
    'AwADBAAD5qEAAsoYZAcP89dXazhJlgI', -- saudades de você musica
    'AwADBAADfacAArMZZAcT20N7X6xCegI', -- booom diaaa!
    'AwADBAADJ6MAApAcZAczqtG8_khsVgI', -- ^m^
    'AwADBAADu6UAAlcYZAc3Kj7VWBLa8AI', -- bom dia povo do meu brasil varonil
    'AwADBAADeqIAAp4cZAfLmxlYcBQuyAI', -- bom dia xuxuzinho
    }
    mensagemBodia = bodia[math.random(#bodia)]

    local key_comando = 'chat:'..msg.chat.id..':bodia'
    local last_user = db:get(key_comando)
    if last_user then
    else
      local nome = u.getname_final(msg.from)
      db:setex(key_comando, 61200, nome) -- 17 horas
      api.sendDocumentId(msg.chat.id, mensagemBodia, msg.message_id)
      api.sendMediaId(msg.chat.id, mensagemBodia, 'photo', msg.message_id)
      api.sendMediaId(msg.chat.id, mensagemBodia, 'voice', msg.message_id)
      api.sendMediaId(msg.chat.id, mensagemBodia, 'video', msg.message_id)
    end
  end

  if blocks[1] == 'acordar_o_baiano' or blocks[1] == 'acordar_um_baiano' or blocks[1] == 'acordar_baiano' or blocks[1] == 'acordar_o_bayano' or blocks[1] == 'acordar_um_bayano' or blocks[1] == 'acordar_bayano' then
    local mensagemAcordar = {
      'O baiano foi acordado',
      'O 👋🏿3️⃣6️⃣5️⃣ foi acordado',
    }
    local mensageFioDormir = {
     'Já votou para a rede',
     'Já voltou a dormir',
     'Está dormindo novamente',
    }
  
    mensagemAcordarR = mensagemAcordar[math.random(#mensagemAcordar)]
    mensageFioDormirR = mensageFioDormir[math.random(#mensageFioDormir)]

    local key_comando = 'chat:'..msg.chat.id..':acordar'
    local last_user = db:get(key_comando)
    if last_user then
    else
      local nome = u.getname_final(msg.from)
      db:setex(key_comando, 14400, nome)
      api.sendMessage(msg.chat.id, mensagemAcordarR, true)
      api.sendMessage(msg.chat.id, mensageFioDormirR, true)
    end
  end

  if blocks[1] == '/ping' then
    local tempoInicial = socket.gettime()
    local message = api.getMe()
    local tempoFinal = socket.gettime()-tempoInicial
    tempoFinal = string.format('%.3f', tempoFinal)
    chat_id = msg.chat.id,
    api.sendMessage(msg.chat.id, 'pingado \n`' ..math.ceil(tempoFinal*1000).. ' ms`', true)
  end

  if blocks[1] == '/echo' or blocks[1] == '/falar' or blocks[1] == '/repetir' then
    if not blocks[2] then
      api.sendReply(msg, 'Quer que eu repita oque? você não falou nada. Use: `/falar mensagem para falar`', true)
    else
      api.sendMessage(msg.chat.id, blocks[2], true)
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
    '(/hora)$',
    '(/time)$',
    '(/fileid)$',
    '(/fileinfo)$',
    '(/send) (.*)$',
    '(/ping)$',
    '(/enviar) (.*)$',
    '(acordar_o_baiano)', '(acordar_um_baiano)', '(acordar_baiano)', '(acordar_o_bayano)', '(acordar_um_bayano)', '(acordar_bayano)', --acordar baiano
    '(Bom dia)', '(Bodia)', '(Bom Dia)', '(bodia)', '(bom dia)', --bodia
    '(/falar) (.*)$', '(/repetir) (.*)$', '(/falar)$', '(/repetir)$',
  }
}

return plugin
