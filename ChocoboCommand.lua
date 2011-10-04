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

function Chocobo.Command:HandleCommand(command, arg)
	if self:HasCommand(command) then
		self.Commands[command](arg)
	elseif self:HasCommand("__DEFAULT__") then
		self.Commands["__DEFAULT__"](arg)
	else
		Chocobo:ErrorMsg((L["InvalidCommand"]):format(command))
	end
end

Chocobo.Command:Register("__DEFAULT__", function(arg)
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

Chocobo.Command:Register({"options", "o", "config", "gui"}, function(arg) ChocoboOptionsFrame:Show() end)
Chocobo.Command:Register({"allmounts", "am", "all"}, function(arg) Chocobo:FilterMount(false) end)
Chocobo.Command:Register({"hawkstrider", "hs", "hawk"}, function(arg) Chocobo:FilterMount(true) end)
Chocobo.Command:Register({"toggle", "t"}, function(arg) Chocobo:Toggle() end)
Chocobo.Command:Register({"soundcontrol", "sc", "sndctrl", "sound"}, function(arg) Chocobo:ToggleSoundControl() end)
Chocobo.Command:Register({"list", "l", "ls"}, function(arg) Chocobo:PrintMusic() end)
Chocobo.Command:Register({"reset", "r"}, function(arg) Chocobo:ResetMusic() end)
Chocobo.Command:Register({"listmounts", "lm"}, function(arg) Chocobo:PrintMounts() end)
Chocobo.Command:Register({"resetmounts", "rm"}, function(arg) Chocobo:ResetMounts() end)
Chocobo.Command:Register({"debug", "d"}, function(arg) Chocobo:Debug(arg:lower()) end)

Chocobo.Command:Register({"add", "a"}, function(arg)
	if arg ~= "" then
		Chocobo:AddMusic(arg)
	else
		Chocobo:Msg(L["AddSyntax"])
	end
end)

Chocobo.Command:Register({"remove", "rem", "rm", "delete", "del"}, function(arg)
	if arg ~= "" then
		Chocobo:RemoveMusic(arg)
	else
		Chocobo:Msg(L["RemoveSyntax"])
	end
end)

Chocobo.Command:Register({"addmount", "addm"}, function(arg)
	if arg ~= "" then
		Chocobo:AddMount(arg)
	else
		Chocobo:Msg(L["AddMountSyntax"])
	end
end)

Chocobo.Command:Register({"removemount", "remm", "deletemount", "delmount", "delm"}, function(arg)
	if arg ~= "" then
		Chocobo:RemoveMount(arg)
	else
		Chocobo:Msg(L["RemoveMountSyntax"])
	end
end)

local slashCount = 1
for _,v in pairs(Chocobo.Command.Slash) do
	_G["SLASH_CHOCOBO" .. slashCount] = "/" .. v
	slashCount = slashCount + 1
end

function SlashCmdList.CHOCOBO(msg, editBox)
	local command, arg = msg:match("^(%S*)%s*(.-)$")
	command = command:lower()
	Chocobo.Command:HandleCommand(command, arg)
end
