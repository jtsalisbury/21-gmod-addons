hook.Add("Initialize", "CheckStockVersion", function()
	local url = "https://raw.githubusercontent.com/crazyscouter/Report-System/master/report/version.txt";
	http.Fetch( url,
		function( body, len, headers, code )
			if (string.Trim(body) == report.Version) then return; end
			
			print("------------REPORTS------------");
			print("Your local version is OUT OF DATE! Download a new version here: ");
			print("https://github.com/crazyscouter/DarkRP-Stocks");
			print("New version:", body);
			print("Your version: ", report.Version);
			print("----------REPORTS END----------");
		end,
		function( error )
			print(error)
		end
	);
end)