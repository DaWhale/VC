
require("serial")

print("! IsValid: ", serial.IsValid() )

serial.Close()
print("! IsValid: ", serial.IsValid() )

serial.Open("COM2", 1,1) --Read timeout, Write timeout, do not set too high, blocks main thread


//Will read 1 byte at a time from the serial buffer, add proper protocol here!
hook.Add("Think", "Serial", function()
	local Got,Size = serial.Read(1)
	
	if Got then
		MsgC( Color(255,255,0), Got)
		
		--fixme, add actual buffer here
	end
end)




do return end
//Arduino VFD control, ignore


//Clear VFD display on arduino
serial.Write("c\n")

concommand.Add("w", function(p,c,a,s)
	print("<: ", s)
	serial.Write(s.."\n")
end)
concommand.Add("vfd", function(p,c,a,s)
	print("<: ", s)
	serial.Write("v;"..s..";1\n")
end)




local Long = "BAN @ [12.02.2015] 13:12 BURST ME BAGPIPES! (STEAM:0:0_13371337)"

local Upto = 0
local Max = 16

local Last = ""
timer.Create("VFD", 0.2, 0, function()
	local New = ""
	local Len = #Long
	
	if Len > 16 then
		if Upto == Len then
			Upto = 0
		end
		Upto = Upto + 1
		
		New = Long:sub(Upto)
		if #New < Max then
			New = New.." "..Long:sub(0,Upto) --Shitty, make proper text scroller
		end
		New = New:Left(16)
	else
		New = Long
	end
	
	print(">"..New.."<")
	
	if New != Last then --Stop the flicker by writing only changes!
		Last = New
		
		--serial.Write("v;"..New..";1\n")
		serial.Write("v;"..New..(Len < 16 and ";1" or "").."\n")
	end
end)












