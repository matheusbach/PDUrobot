local config = require 'config'
local u = require 'utilities'
local api = require 'methods'
local UTF8 = require'lua-utf8'
local json = require('dkjson')

local plugin = {}

function plugin.onTextMessage(msg, blocks)
  if blocks[1] == 'btc' then
    fator = 1000000
    local curl = 'curl -s "https://blockchain.info/tobtc?currency=BRL&value=1000000"'
    local handle = io.popen(curl)
    local resposta = handle:read("*all")

    local curlUSD = 'curl -s "https://blockchain.info/tobtc?currency=USD&value=1000000"'
    local handleUSD = io.popen(curlUSD)
    local respostaUSD = handleUSD:read("*all")

    local curlSAT = 'curl -s "https://blockchain.info/tobtc?currency=BRL&value=1"'
    local handleSAT = io.popen(curlSAT)
    local respostaSAT = handleSAT:read("*all")

    api.sendMessage(msg.chat.id, 'Hoje, '..os.date("!%d/%m/%Y, "..os.date('!%H:%M UTC'))..'\n*Um bitcoin* vale *R$ '..math.ceil(fator/resposta)..'*\n*Um bitcoin* vale *U$ '..math.ceil(fator/respostaUSD)..'*\n*1 real* vale só *BTC '.. respostaSAT ..'*', true)
  
  end
end

plugin.triggers = {
  onTextMessage = {
    config.cmd..'(btc)$',
    config.cmd..'(btc) (.*)$'
  }
}

return plugin