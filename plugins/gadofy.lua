 
-- Spotify plugin for bot based on otouto
-- ByTiagoDanin - Telegram.me/tiagodanin

local plugin = {}

plugin.doc = [[
	/gadofy <music>
]]

plugin.triggers = {
	'^/gadofy'
}

function plugin.action(msg)

	local input = get_input(msg.text)
	if not input then
		return send_msg(msg, plugin.doc)
	end

	local BASE_URL = "https://api.spotify.com/v1/search"
	local URLP = "?q=".. (URL.escape(input) or "").."&type=track&limit=5" -- Limit 5

	local decj, tim = HTTPS.request(BASE_URL..URLP)
	if tim ~=200 then return nil  end

	local spotify = JSON.decode(decj)
	local tables = {}
	for pri,result in ipairs(spotify.tracks.items) do
	table.insert(tables, {
		spotify.tracks.total,
		result.name,
		result.external_urls.spotify
	})
	end

	local gets = ""
	for pri,cont in ipairs(tables) do
		gets=gets.."▶️ "..cont[2].." - "..cont[3].."\n"
	end

	local text_end = gets -- Text END
	if gets == "" then
		text_end = "Não achei esse som anãozinho"
	end

	send_message(msg.chat.id, text_end)
end

return plugin