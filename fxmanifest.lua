fx_version 'cerulean'
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Polisek scripts'

client_script {
	'client/client.lua',
	'client/npc.lua',
	'config.lua'
}

server_script {
	'server/server.lua',
}

lua54 'yes'