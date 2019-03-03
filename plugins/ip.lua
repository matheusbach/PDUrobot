local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local UTF8 = require'lua-utf8'
local json = require('dkjson')

local plugin = {}

function plugin.onTextMessage(msg, blocks)
  if blocks[1] == 'ip' then
    if not  blocks[2] then
      api.sendMessage(msg.chat.id, 'Digite o comando seguido do ip. Ex: `/ip 190.232.207.225`', true)
    else
      local buscar = blocks[2]
      local dificuldade = 'curl -s http://ip-api.com/json/' .. buscar
      local handle = io.popen(dificuldade)
      local resposta = handle:read("*all")
      local v = UTF8.escape(resposta)
      local a = json.decode(v)
        pais = a['country']
        paisCode = a['countryCode']
        estado = a['regionName']
        estadoCode = a['region']
        provedora = a['isp']
        cidade = a['city']
        ipsolicitado = a['query']
        lat = a['lat']
        lon = a['lon']
        timezone = a['timezone']

      api.sendMessage(msg.chat.id, _([[*Informações* %s:

*País:* `%s (%s)`
*Estado:* `%s (%s)`
*Cidade:* `%s`
*Fuso Horário*: `%s`
*Hospedado por:* `%s`]]):format(ipsolicitado, pais, paisCode, estado, estadoCode, cidade, timezone, provedora), true)
    end
  end
end

plugin.triggers = {
  onTextMessage = {
    config.cmd..'(ip)$',
    config.cmd..'(ip) (.*)$'
  }
}

return plugin