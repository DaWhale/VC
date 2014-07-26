
require("vttf")

function string.Check(str,check)
	return tostring(str):sub(1,#check) == check
end


local function LogThis(what,safe)
	file.Append("file_vfft.txt", "\r\n["..os.date().."] "..what.." - "..tostring(safe) )
	ErrorNoHalt("VFFT: "..what.." "..tostring(safe).."\n")
end

function IsValidFileForTransfer(what,safe)
	//Up dirs
	if what:find(":", nil,true) or what:find("../", nil,true) or what:find("..\\", nil,true) then
		LogThis(what,safe)
		return false
	end
	
	//Allow spray
	if (what:Check("user_custom/") and what:EndsWith(".dat")) then
		return true
	end
	
	//Block everything else
	LogThis(what,safe)
	return false
end
hook.Add("IsValidFileForTransfer", "IsValidFileForTransfer", IsValidFileForTransfer)



