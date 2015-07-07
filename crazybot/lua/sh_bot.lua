cbot = cbot or {};

if (CLIENT) then return; end

cbot:AddCommand("!define", function(caller, text)
	print("CALLED");

	local splode = string.Explode(text);
	splode[1] = nil;
	local searc = table.concat(splode);

	http.Fetch("http://api.urbandictionary.com/v0/define?term="..searc, function(body)
		print(body);
	end, function(errr)

	end)
end)