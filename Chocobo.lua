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

	------
	
	Chocobo AddOn
	Dedicated to Shishu (Flurdy) on Azuremyst-EU
--]]

Chocobo = {
	Name = "Chocobo",
	Version	= GetAddOnMetadata("Chocobo", "Version"),
	Loaded	= false,
	Mounted	= false,
	Running = false, -- True if the OnUpdate handler is running.
	MusicDir = "Interface\\AddOns\\Chocobo\\music\\",
	Global	= {},
	Events = {},
	Songs	= { -- Default songs loaded on first run
		-- Please note that you can't add custom songs here, this is only used when restoring default settings or on initial startup
		"chocobo.mp3",
		"chocobo_ffiv.mp3",
		"chocobo_ffxii.mp3",
		"chocobo_ffxiii.mp3"
	},
	IDs	= {
		Hawkstriders = {
			35022, -- Black Hawkstrider
			35020, -- Blue Hawkstrider
			35018, -- Purple Hawkstrider
			34795, -- Red Hawkstrider
			63642, -- Silvermoon Hawkstrider
			66091, -- Sunreaver Hawkstrider
			35025, -- Swift Green Hawkstrider
			33660, -- Swift Pink Hawkstrider
			35027, -- Swift Purple Hawkstrider
			65639, -- Swift Red Hawkstrider
			35028, -- Swift Warstrider (Thanks Khormin for pointing it out)
			46628  -- Swift White Hawkstrider
		},
		RavenLord = {41252}, -- Raven Lord (If enabled in options)
		DruidForms = {33943, 40120} -- When AllMounts is enabled
	}
}

--@debug@
if Chocobo.Version == "@".."project-version".."@" then Chocobo.Version = "Development" end
--@end-debug@

local t = 0

local L = _G["ChocoboLocale"]

assert(L, "Chocobo Locales not loaded")

function Chocobo:OnEvent(frame, event, ...)
	if Chocobo.Events[event] then Chocobo.Events[event](self, ...) end
end

function Chocobo.Events.ADDON_LOADED(self, ...)
	-- Currently, this seems a bit bugged when having multiple addons. The "loaded" message will disappear sometimes.
	local addonName = (select(1, ...)):lower()
	if addonName == "chocobo" then
		self:Msg((L["AddOnLoaded"]):format(self.Version))
		self:Msg(L["Enjoy"])
		self.Loaded = true
	end
	if type(_G["CHOCOBO"]) ~= "table" then _G["CHOCOBO"] = {} end
	self.Global = _G["CHOCOBO"]
	if self.Global["DEBUG"] == nil then
		-- Should be fired on first launch, set the saved variable to default value
		self:Msg(L["DebugNotSet"])
		self.Global["DEBUG"] = false
	end
	if self.Global["ALLMOUNTS"] == nil then
		-- Should be fired on first launch, set the saved variable to default value
		self:Msg(L["AllMountsNotSet"])
		self.Global["ALLMOUNTS"] = false
	end
	if self.Global["RAVENLORD"] == nil then
		self:Msg(L["RavenLordNotSet"])
		self.Global["RAVENLORD"] = false
	end
	if self.Global["SOUNDCONTROL"] == nil then
		self:Msg(L["SoundControlNotSet"])
		self.Global["SOUNDCONTROL"] = false
	end
	if self.Global["MUSIC"] == nil then -- If the song list is empty
		-- Populate the table with default songs
		self:Msg(L["NoMusic"])
		self.Global["MUSIC"] = {}
		for _,v in pairs(self.Songs) do -- Add all of the default songs
			self:AddMusic(v)
		end
	end
	if self.Global["MOUNTS"] == nil then
		self:Msg(L["NoMounts"])
		self.Global["MOUNTS"] = {}
	end
	if self.Global["ENABLED"] == nil then
		-- Should be fired on first launch, set the saved variable to default value
		self:Msg(L["EnabledNotSet"])
		self.Global["ENABLED"] = true
	end
end

function Chocobo.Events.UNIT_AURA(self, ...)
	local unitName = (select(1, ...)):lower()
	if unitName ~= "player" or not self.Global["ENABLED"] then return end -- Return if addon is disabled or player was unaffected
	self:DebugMsg((L["Event_UNIT_AURA"]):format(unitName))
	if self.Loaded == false then
		-- This should NOT happen
		self:ErrorMsg(L["NotLoaded"])
		return
	end
	if self.Running then return end -- Return if the OnUpdate script is already running.
	self.Running = true
	t = 0
	self.Frame:SetScript("OnUpdate", function (_, elapsed) Chocobo:OnUpdate(_, elapsed) end)
end

function Chocobo.Events.PLAYER_LOGOUT(self, ...)
	-- Save local copy of globals
	_G["CHOCOBO"] = self.Global
end

function Chocobo:OnUpdate(_, elapsed)
	t = t + elapsed
	-- When 1 second has elapsed, this is because it takes ~0.5 secs from the event detection for IsMounted() to return true.
	if t >= 1 then
		-- Unregister the OnUpdate script
		self.Frame:SetScript("OnUpdate", nil)
		-- Is the player mounted?
		local Mounted = self:HasMount()
		if IsMounted() or Mounted then -- More efficient way to make it also detect flight form here?
			self:DebugMsg(L["PlayerIsMounted"])
			-- Loop through all the "hawkstrider" names to see if the player is mounted on one or check if allmounts (override) is true
			if Mounted or self.Global["ALLMOUNTS"] then
				self:DebugMsg(L["PlayerOnHawkstrider"])
				if self.Mounted == false then -- Check so that the player is not already mounted
					self:SoundCheck() -- Enable sound if disabled and the option is enabled
					self:DebugMsg(L["PlayingMusic"])
					self.Mounted = true
					local songID = math.random(1, #self.Global["MUSIC"]) -- "#Chocobo.Global["MUSIC"]" = number of fields in Chocobo.Global["MUSIC"]
					self:DebugMsg((L["PlayingSong"]):format(songID, self.Global["MUSIC"][songID]))
					PlayMusic(self.Global["MUSIC"][songID])
				else -- If the player has already mounted
					self:DebugMsg(L["AlreadyMounted"])
				end
			else -- Player is not on a hawkstrider
				self:DebugMsg(L["NoHawkstrider"])
			end
		else -- When the player has dismounted
			if self.Mounted then
				self:SoundCheck() -- Disable sound if enabled and the option is enabled
				self:DebugMsg(L["NotMounted"])
				self.Mounted = false
				StopMusic() -- Note that StopMusic() will also stop any other custom music playing (such as from EpicMusicPlayer)
			end
		end
		self.Running = false
	end
end

function Chocobo:HasBuff(idColl)
	local buffs = {}
	for i=1,40 do -- Loop through all 40 possible buff indexes
		local name,_,_,_,_,_,_,_,_,_,id = UnitAura("player", i) -- Get buff on index i
		-- Insert it into the buffs table, break if buff is nil (that means no other buffs exist on the player)
		if name and id then buffs[name] = id else break end
	end
	for name,id in pairs(buffs) do -- Loop through all buffs found
		for _,v in pairs(idColl) do -- Loop through all supplied IDs
			if type(v) == "number" then -- Check if the value is a number
				if id == v then -- Check if ID equals current buff ID and return true if it does
					self:DebugMsg((L["CurrentMount"]):format(name)) -- Print what mount the player is mounted on
					return true
				end
			elseif type(v) == "string" then -- Check if the value is a string
				if name:lower() == v:lower() then -- Check if name equals current buff name and return true if it does
					self:DebugMsg((L["CurrentMount"]):format(name)) -- Print what mount the player is mounted on
					return true
				end
			end
		end
	end
	return false -- Else return false (Player does not have the buff)
end

function Chocobo:HasMount()
	local mountColl = {}
	for _,v in pairs(self.IDs.Hawkstriders) do
		table.insert(mountColl, v)
	end
	if self.Global["RAVENLORD"] then
		for _,v in pairs(self.IDs.RavenLord) do
			table.insert(mountColl, v)
		end
	end
	if self.Global["ALLMOUNTS"] then -- Add druid flight forms
		for _,v in pairs(self.IDs.DruidForms) do
			table.insert(mountColl, v)
		end
	end
	if #self.Global["MOUNTS"] > 0 then
		for _,v in pairs(self.Global["MOUNTS"]) do
			table.insert(mountColl, v) -- Can be both a string and a number value
		end
	end
	return self:HasBuff(mountColl)
end

function Chocobo:ToggleSoundControl()
	self.Global["SOUNDCONTROL"] = not self.Global["SOUNDCONTROL"]
	if self.Global["SOUNDCONTROL"] then
		self:Msg(L["SoundControlEnabled"])
		self:SoundCheck()
	else
		self:Msg(L["SoundControlDisabled"])
		self:RestoreSound()
	end
end

function Chocobo:RestoreSound()
	SetCVar("Sound_EnableAllSound", 1)
	SetCVar("Sound_EnableSFX", 1)
	SetCVar("Sound_EnableMusic", 1)
	SetCVar("Sound_EnableAmbience", 1)
end

function Chocobo:SoundCheck()
	if not self.Global["SOUNDCONTROL"] then return end
	if (self.Mounted and self.Running) or (not self.Mounted and not self.Running) then -- We want to disable sounds again
		SetCVar("Sound_EnableMusic", 0)
		SetCVar("Sound_EnableAllSound", 0)
	else
		SetCVar("Sound_EnableAllSound", 1)
		SetCVar("Sound_EnableSFX", 0)
		SetCVar("Sound_EnableAmbience", 0)
		SetCVar("Sound_EnableMusic", 1)
		if tonumber(GetCVar("Sound_MusicVolume")) <= 0 then
			SetCVar("Sound_MusicVolume", 1.0)
		end
	end
end

function Chocobo:AddMusic(songName) -- Add a song the the list
	songName = self:Trim(songName)
	if songName == "" or songName == nil then
		self:ErrorMsg(L["NoFile"])
		return
	end
	songName = self.MusicDir .. songName
	for _,v in pairs(self.Global["MUSIC"]) do -- Loop through all the songs currently in the list and...
		if v == songName then -- ... make sure it isn't there already
			self:ErrorMsg(L["AlreadyExists"])
			return
		end
	end
	table.insert(self.Global["MUSIC"], songName) -- Insert the song into list
	self:Msg((L["AddedSong"]):format(songName))
end

function Chocobo:RemoveMusic(songName) -- Remove a song from the list
	songName = self:Trim(songName)
	if songName == "" or songName == nil then
		self:ErrorMsg(L["NoFile"])
		return
	end
	songName = self.MusicDir .. songName
	for i,v in ipairs(self.Global["MUSIC"]) do -- Loop through all the songs in the list until...
		if v == songName then -- ... the desired one is found and then...
			table.remove(self.Global["MUSIC"], i) -- ... remove it from the list.
			self:Msg((L["RemovedSong"]):format(songName))
			return
		end
	end
	self:ErrorMsg(L["SongNotFound"])
end

function Chocobo:PrintMusic() -- Print all the songs currently in list to chat
	for i,v in ipairs(self.Global["MUSIC"]) do
		self:Msg(("\124cff00CCFF%i: %s\124r"):format(i, v))
	end
end

function Chocobo:ResetMusic() -- Resets the values in Chocobo.Global["MUSIC"] to default
	self:Msg(L["ResetMusic"])
	self.Global["MUSIC"] = nil -- "Erase" the data from Chocobo.Global["MUSIC"]
	self.Global["MUSIC"] = {} -- Make it a new table
	for _,v in pairs(self.Songs) do -- Add all the default songs again
		self:AddMusic(v)
	end
end

function Chocobo:AddMount(mount)
	mount = self:Trim(mount)
	mount = tonumber(mount) or mount
	if mount == "" or mount == nil then
		self:ErrorMsg(L["NoMount"])
		return
	end
	local compare = tostring(mount):lower()
	for _,v in pairs(self.Global["MOUNTS"]) do
		if tostring(v):lower() == compare then
			self:ErrorMsg(L["MountAlreadyExists"])
			return
		end
	end
	table.insert(self.Global["MOUNTS"], mount)
	self:Msg((L["AddedMount"]):format(mount))
end

function Chocobo:RemoveMount(mount)
	if mount == "" or mount == nil then
		self:ErrorMsg(L["NoMount"])
		return
	end
	mount = mount:lower()
	for i,v in ipairs(self.Global["MOUNTS"]) do
		if v:lower() == mount then 
			table.remove(self.Global["MOUNTS"], i)
			self:Msg((L["RemovedMount"]):format(mount))
			return
		end
	end
	self:ErrorMsg(L["MountNotFound"])
end

function Chocobo:PrintMounts()
	for i,v in ipairs(self.Global["MOUNTS"]) do
		self:Msg(("\124cff00CCFF%i: %s\124r"):format(i, v))
	end
end

function Chocobo:ResetMounts()
	self:Msg(L["ResetMounts"])
	self.Global["MOUNTS"] = nil
	self.Global["MOUNTS"] = {}
end

function Chocobo:FilterMount(filter)
	if filter == true then
		self:Msg(L["HawkstriderOnly"])
		self.Global["ALLMOUNTS"] = false
	else
		self:Msg(L["AllMounts"])
		self.Global["ALLMOUNTS"] = true
	end
end

function Chocobo:Debug(set)
	if set == "enable" or set == "on" then
		self:Msg(L["DebuggingEnabled"])
		self.Global["DEBUG"] = true
	elseif set == "disable" or set == "off" then
		self:Msg(L["DebuggingDisabled"])
		self.Global["DEBUG"] = false
	else
		if self.Global["DEBUG"] then
			self:Msg(L["DebugIsEnabled"])
		else
			self:Msg(L["DebugIsDisabled"])
		end
	end
end

function Chocobo:RavenLordToggle()
	self.Global["RAVENLORD"] = not self.Global["RAVENLORD"]
	if self.Global["RAVENLORD"] then
		self:Msg(L["RavenLordTrue"])
	else
		self:Msg(L["RavenLordFalse"])
	end
end

function Chocobo:Toggle() -- Toggle the AddOn on and off
	if self.Global["ENABLED"] then -- If the addon is enabled
		self.Global["ENABLED"] = false -- Disable it
		StopMusic()
		self:Msg(L["AddOnDisabled"]) -- Print status
		self:DebugMsg("Music stopped")
	else -- If the addon is disabled
		self.Global["ENABLED"] = true -- Enable it
		self:Msg(L["AddOnEnabled"]) -- Print status
	end
end

function Chocobo:GetGlobal(var)
	return self.Global[var]
end

function Chocobo:Trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function Chocobo:Msg(msg) -- Send a normal message
	DEFAULT_CHAT_FRAME:AddMessage(L["MsgPrefix"] .. msg)
end

function Chocobo:ErrorMsg(msg) -- Send an error message, these are prefixed with the word "ERROR" in red
	DEFAULT_CHAT_FRAME:AddMessage(L["ErrorPrefix"] .. msg)
end

function Chocobo:DebugMsg(msg) -- Send a debug message, these are only sent when debugging is enabled and are prefixed by the word "Debug" in yellow
	if self.Global["DEBUG"] == true then
		DEFAULT_CHAT_FRAME:AddMessage(L["DebugPrefix"] .. msg)
	end
end

function Chocobo:GetVersion()
	return self.Version
end

SLASH_CHOCOBO1 = "/chocobo"
function SlashCmdList.CHOCOBO(msg, editBox)
	local command, arg = msg:match("^(%S*)%s*(.-)$")
	command = command:lower()
	if command == "options" then
		ChocoboOptionsFrame:Show()
	elseif command == "allmounts" then
		Chocobo:FilterMount(false)
	elseif command == "hawkstrider" then
		Chocobo:FilterMount(true)
	elseif command == "toggle" then
		Chocobo:Toggle()
	elseif command == "soundcontrol" or command == "sc" or command == "sndctrl" then
		Chocobo:ToggleSoundControl()
	elseif command == "add" then
		if arg ~= "" then
			Chocobo:AddMusic(arg)
		else
			Chocobo:Msg(L["AddSyntax"])
		end
	elseif command == "remove" or command == "del" then
		if arg ~= "" then
			Chocobo:RemoveMusic(arg)
		else
			Chocobo:Msg(L["RemoveSyntax"])
		end
	elseif command == "list" then
		Chocobo:PrintMusic()
	elseif command == "reset" then
		Chocobo:ResetMusic()
	elseif command == "addmount" then
		if arg ~= "" then
			Chocobo:AddMount(arg)
		else
			Chocobo:Msg(L["AddMountSyntax"])
		end
	elseif command == "removemount" or command == "delmount" then
		if arg ~= "" then
			Chocobo:RemoveMount(arg)
		else
			Chocobo:Msg(L["RemoveMountSyntax"])
		end
	elseif command == "listmounts" then
		Chocobo:PrintMounts()
	elseif command == "resetmounts" then
		Chocobo:ResetMounts()
	elseif command == "debug" then
		Chocobo:Debug(arg:lower())
	else
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
	end
end

-- Create the frame, no need for an XML file!
Chocobo.Frame = CreateFrame("Frame", "ChocoboFrame")
Chocobo.Frame:SetScript("OnEvent", function (frame, event, ...) Chocobo:OnEvent(frame, event, ...) end)
for k,_ in pairs(Chocobo.Events) do
	Chocobo.Frame:RegisterEvent(k)
end
