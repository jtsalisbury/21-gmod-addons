adminCommands = {}

hook.Add("PlayerSay", "RegisterCommands", function(ply, text, teamc, alive)
	local chat_string = string.Explode(" ", text)
	
	for k, v in pairs( adminCommands ) do
		if( chat_string[1] == k ) then
			table.remove(chat_string, 1)
			v(ply, chat_string)
			
			return ""
		end
		
		if( string.find(k, chat_string[1]) != nil ) then
			local start, endp, word = string.find(k, chat_string[1])
			
			if( endp - (start - 1) > 2 ) then
				ply:ChatPrint("Invalid command! Did you mean '"..tostring( k ).."'?")
				
				return ""
			end
		end
	end
	
	return text
end)

function AddChatCommand(strCommand, Func)
	if( !strCommand || !Func ) then return end
	
	for k, v in pairs( adminCommands ) do
		if( strCommand == k ) then
			return
		end
	end
	
	adminCommands[ tostring( strCommand ) ] = Func
end