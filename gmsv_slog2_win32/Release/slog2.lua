

require("slog2")

SLOG = {}

function SLOG.AddHook(ply)
	if not slog2 or ply:IsBot() then return end
	
	local Done,err = slog2.Add( ply:EntIndex() ) --Needs a player, any player, to start the hook
	
	if err or not Done then
		ErrorNoHalt("Slog2, can't hook: "..tostring(err).."\n")
		return
	end
	
	hook.Remove("PlayerInitialSpawn", "SLOG.AddHook")
end
hook.Add("PlayerInitialSpawn", "SLOG.AddHook", SLOG.AddHook)





//Requested
hook.Add("FileRequested", "FileRequested", function(what,sid)
	what = tostring(what)
	if not (what:Check("user_custom/") and what:EndsWith(".dat")) then
		//Log
		file.Append("file_rq.txt", "\r\n"..sid.." - "..what)
		ErrorNoHalt("FileRequested: "..what.." "..sid)
		return true
	end
end)

//Received
hook.Add("FileReceived", "FileReceived", function(what,sid)
	what = tostring(what)
	if not (what:Check("user_custom/") and what:EndsWith(".dat")) then
		//Log
		file.Append("file_rx.txt", "\r\n"..sid.." - "..what)
		ErrorNoHalt("FileReceived: "..what.." "..sid)
	end
end)





























