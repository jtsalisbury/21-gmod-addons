if (!PW.Enabled) then return; end

require("mysqloo");

local host = PW.Mysql.Host;
local user = PW.Mysql.User;
local pass = PW.Mysql.Password;
local dbName = PW.Mysql.Database;
local port = PW.Mysql.Port;

local db = mysqloo.connect(host, user, pass, dbName, port);
local queue = {}; // If the sql can't be queried now, we'll queue for when we connect again.

function db:onConnectionFailed(err)
	print("Perma Weapons - Database connection failed! Error: ", err);
end

db:connect();

function escape(str)
	return db:escape(str);
end

function Query(sql, callback)
	
	local q = db:query(sql);
	
	function q:onSuccess(data)
		if (callback) then
			callback(data);
		end
	end
	
	function q:onError(err)
		if (db:status() == mysqloo.DATABASE_NOT_CONNECTED) then
			table.insert(queue, {sql, callback});
			db:connect()
			return
		end
		print("Query error! Error: ", err, ". Sql: ", sql);
	end
	q:start();
end

function db:onConnected()
	print("Perma Weapons - Database connected!");
	for k,v in pairs(queue) do
		Query(v[1], v[2]);
	end
	queue = {};
	
	--	Run this query on your db:
	--	CREATE TABLE IF NOT EXISTS `pw_general` ( `weps` VarChar(255) NOT NULL default '', `steamid` VarChar(255) NOT NULL default '' )
end