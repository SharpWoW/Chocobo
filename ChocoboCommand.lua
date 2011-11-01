--[[
    Copyright (c) 2010-2011 by Adam Hellberg
    
    This file is part of Chocobo.
    
    Chocobo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    Chocobo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with Chocobo. If not, see <http://www.gnu.org/licenses/>.
--]]

Chocobo.Command = {
	Slash = {
		"chocobo"
	},
	Commands = {}
}

local CLib = ChocoboLib
local L = _G["ChocoboLocale"]

-- Argument #1 (command) can be either string or a table.
function Chocobo.Command:Register(command, func)
	if type(command) == "string" then
		command = {command}
	end
	for _,v in pairs(command) do
		if not self:HasCommand(v) then
			if v ~= "__DEFAULT__" then v = v:lower() end
			self.Commands[v] = func
		end
	end
end

function Chocobo.Command:HasCommand(command)
	return self.Commands[command]
end

function Chocobo.Command:HandleCommand(command, args)
	if self:HasCommand(command) then
		self.Commands[command](args)
	elseif self:HasCommand("__DEFAULT__") then
		self.Commands["__DEFAULT__"](args)
	else
		Chocobo:ErrorMsg((L["InvalidCommand"]):format(command))
	end
end

Chocobo.Command:Register("__DEFAULT__", function(args)
	Chocobo:Msg(L["HelpMessage1"])
	Chocobo:Msg(L["HelpMessage2"])
	Chocobo:Msg(L["HelpMessage3"])
	Chocobo:Msg(L["HelpMessage4"])
	Chocobo:Msg(L["HelpMessage5"])
	Chocobo:Msg(L["HelpMessage6"])
	Chocobo:Msg(L["HelpMessage7"])
	Chocobo:Msg(L["HelpMessage8"])
	Chocobo:Msg(L["HelpMessage9"])
	Chocobo:Msg(L["HelpMessage10"])
	Chocobo:Msg(L["HelpMessage12"])
	Chocobo:Msg(L["HelpMessage13"])
	Chocobo:Msg(L["HelpMessage14"])
	Chocobo:Msg(L["HelpMessage15"])
	Chocobo:Msg(L["HelpMessage16"])
	Chocobo:Msg(L["HelpMessage11"])
end)

Chocobo.Command:Register({"options", "o", "config", "gui"}, function(args)
	InterfaceOptionsFrame_OpenToCategory(ChocoboSoundControl)
	InterfaceOptionsFrame_OpenToCategory(ChocoboOptions)
end)

Chocobo.Command:Register({"allmounts", "am", "all"}, function(args) Chocobo:FilterMount(false) end)
Chocobo.Command:Register({"hawkstrider", "hs", "hawk"}, function(args) Chocobo:FilterMount(true) end)
Chocobo.Command:Register({"modetoggle", "mounttoggle", "mt"}, function(args) Chocobo:FilterMount() end)
Chocobo.Command:Register({"toggle", "t"}, function(args) Chocobo:Toggle() end)
Chocobo.Command:Register({"ravenlordtoggle", "ravenlord", "rl"}, function(args) Chocobo:RavenLordToggle() end)
Chocobo.Command:Register({"amazinghorsetoggle", "amazinghorse", "horsetoggle", "horse", "amazing"}, function(args) Chocobo:HorseToggle() end)

Chocobo.Command:Register({"soundcontrol", "sc", "sndctrl", "sound"}, function(args)
	local handled = false
	if #args > 0 then
		local vol = tonumber(args[3])
		if args[1] == "gui" or args[1] == "options" then
			InterfaceOptionsFrame_OpenToCategory(ChocoboSoundControl)
			handled = true
		elseif args[1] == "toggle" or args[1] == "t" then
			Chocobo.SoundControl:Toggle()
			handled = true
		elseif args[1] == "default" or args[1] == "d" then
			Chocobo.SoundControl:ToggleDefault()
			handled = true
		elseif args[1] == "music" or args[1] == "m" then
			if #args > 1 then
				if args[2] == "toggle" or args[2] == "t" then
					Chocobo.SoundControl:ToggleMusic()
					handled = true
				elseif args[2]:match("^mount") or args[2] == "m" then
					Chocobo.SoundControl:ToggleMusicMount()
					handled = true
				elseif args[2]:match("^not?mount") or args[2] == "nm" then
					Chocobo.SoundControl:ToggleMusicNoMount()
					handled = true
				elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
					if type(vol) == "number" then
						Chocobo.SoundControl:SetMusicVolume(vol)
						handled = true
					elseif args[3] == "toggle" or args[3] == "t" then
						Chocobo.SoundControl:ToggleMusicVolume()
						handled = true
					else
						Chocobo.SoundControl:PrintMusicVolume()
						handled = true
					end
				end
			end
		elseif args[1] == "sfx" or args[1] == "sound" or args[1] == "s" then
			if #args > 1 then
				if args[2] == "toggle" or args[2] == "t" then
					Chocobo.SoundControl:ToggleSFX()
					handled = true
				elseif args[2]:match("^mount") or args[2] == "m" then
					Chocobo.SoundControl:ToggleSFXMount()
					handled = true
				elseif args[2]:match("^not?mount") or args[2] == "nm" then
					Chocobo.SoundControl:ToggleSFXNoMount()
					handled = true
				elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
					if type(vol) == "number" then
						Chocobo.SoundControl:SetSFXVolume(vol)
						handled = true
					elseif args[3] == "toggle" or args[3] == "t" then
						Chocobo.SoundControl:ToggleSFXVolume()
						handled = true
					else
						Chocobo.SoundControl:PrintSFXVolume()
						handled = true
					end
				end
			end
		elseif args[1] == "ambience" or args[1] == "amb" or args[1] == "a" then
			if #args > 1 then
				if args[2] == "toggle" or args[2] == "t" then
					Chocobo.SoundControl:ToggleAmbience()
					handled = true
				elseif args[2]:match("^mount") or args[2] == "m" then
					Chocobo.SoundControl:ToggleAmbienceMount()
					handled = true
				elseif args[2]:match("^not?mount") or args[2] == "nm" then
					Chocobo.SoundControl:ToggleAmbienceNoMount()
					handled = true
				elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
					if type(vol) == "number" then
						Chocobo.SoundControl:SetAmbienceVolume(vol)
						handled = true
					elseif args[3] == "toggle" or args[3] == "t" then
						Chocobo.SoundControl:ToggleAmbienceVolume()
						handled = true
					else
						Chocobo.SoundControl:PrintAmbienceVolume()
						handled = true
					end
				end
			end
		end
	end
	if not handled then
		Chocobo:Msg(L["SCSyntax1"])
		Chocobo:Msg(L["SCSyntax2"])
	end
end)

Chocobo.Command:Register({"list", "l", "ls"}, function(args) Chocobo:PrintMusic() end)
Chocobo.Command:Register({"reset", "r"}, function(args) Chocobo:ResetMusic() end)
Chocobo.Command:Register({"listmounts", "lm"}, function(args) Chocobo:PrintMounts() end)
Chocobo.Command:Register({"resetmounts", "rm"}, function(args) Chocobo:ResetMounts() end)

Chocobo.Command:Register({"debug", "d"}, function(args)
	if not args[1] then
		Chocobo:Debug()
	else
		Chocobo:Debug(args[1]:lower())
	end
end)

Chocobo.Command:Register({"add", "a"}, function(args)
	if #args > 0 then
		local song = args[1]
		if #args > 1 then
			for i=2,#args do
				song = song .. " " .. args[i]
			end
		end
		Chocobo:AddMusic(song)
	else
		Chocobo:Msg(L["AddSyntax"])
	end
end)

Chocobo.Command:Register({"remove", "rem", "delete", "del"}, function(args)
	if #args > 0 then
		local song = args[1]
		if #args > 1 then
			for i=2,#args do
				song = song .. " " .. args[i]
			end
		end
		Chocobo:RemoveMusic(song)
	else
		Chocobo:Msg(L["RemoveSyntax"])
	end
end)

Chocobo.Command:Register({"addmount", "addm"}, function(args)
	if #args > 0 then
		local mount = args[1]
		if #args > 1 then
			for i=2,#args do
				mount = mount .. " " .. args[i]
			end
		end
		Chocobo:AddMount(mount)
	else
		Chocobo:Msg(L["AddMountSyntax"])
	end
end)

Chocobo.Command:Register({"removemount", "remm", "deletemount", "delmount", "delm"}, function(args)
	if #args > 0 then
		local mount = args[1]
		if #args > 1 then
			for i=2,#args do
				mount = mount .. " " .. args[i]
			end
		end
		Chocobo:RemoveMount(mount)
	else
		Chocobo:Msg(L["RemoveMountSyntax"])
	end
end)

for i,v in ipairs(Chocobo.Command.Slash) do
	_G["SLASH_" .. Chocobo.Name:upper() .. i] = "/" .. v
end

SlashCmdList[Chocobo.Name:upper()] = function(msg, editBox)
	msg = CLib:Trim(msg)
	local args = CLib:Split(msg)
	local cmd = args[1]
	local t = {}
	if #args > 1 then
		for i=2,#args do
			table.insert(t, args[i])
		end
	end
	Chocobo.Command:HandleCommand(cmd, t)
end
