--[[
	Chocobo AddOn
	Made by F16Gaming
	Dedicated to Shishu on Azuremyst-EU
	
	Feel free to modify the code but leave credits!
	
	Information:
		This AddOn plays the chocobo song when mounting on a hawkstrider mount.
		Type /chocobo for options
		Some useful commands:
		/chocobo allmounts   -- Will play chocobo song regardless of mount
		/chocobo hawkstrider -- Only play when on a hawkstrider
	
	CHOCOBO!!!
--]]

_G["Chocobo"] = {
	Version	= GetAddOnMetadata("Chocobo", "Version"),
	Loaded	= false,
	Mounted	= false,
	MusicDir = "Interface\\AddOns\\Chocobo\\music\\",
	Global	= {},
	Songs	= { --Default songs loaded on first run
		--Please note that you can't add custom songs here, this is only used when restoring default settings or on initial startup
		"chocobo.mp3",
		"chocobo_ffiv.mp3",
		"chocobo_ffxii.mp3",
		"chocobo_ffxiii.mp3"
	},
	IDs	= {
		Hawkstriders = {
			35022, --Black Hawkstrider
			35020, --Blue Hawkstrider
			35018, --Purple Hawkstrider
			34795, --Red Hawkstrider
			63642, --Silvermoon Hawkstrider
			66091, --Sunreaver Hawkstrider
			35025, --Swift Green Hawkstrider
			33660, --Swift Pink Hawkstrider
			35027, --Swift Purple Hawkstrider
			65639, --Swift Red Hawkstrider
			35028, --Swift Warstrider (Thanks Khormin for pointing it out)
			46628  --Swift White Hawkstrider
		},
		RavenLord = {41252},  --Raven Lord (If enabled in options)
		DruidForms = {33943, 40120} --When AllMounts is enabled
	}
}

--@debug@
if Chocobo.Version == "@".."project-version".."@" then Chocobo.Version = "Development" end
--@end-debug@

local t = 0

local L = _G["ChocoboLocale"]

function Chocobo:OnEvent(frame, event, ...)
	self:DebugMsg("OnEvent Fired")
	if event == "ADDON_LOADED" then
		--Currently, this seems a bit bugged when having multiple addons. The "loaded" message will disappear sometimes.
		local addonName = select(1, ...)
		if addonName == "Chocobo" then
			self:Msg((L["AddOnLoaded"]):format(self.Version))
			self:Msg(L["Enjoy"])
			self.Loaded = true
		end
		if type(_G["CHOCOBO"]) ~= "table" then _G["CHOCOBO"] = {} end
		self.Global = _G["CHOCOBO"]
		if self.Global["DEBUG"] == nil then
			--Should be fired on first launch, set the saved variable to default value
			self:Msg(L["DebugNotSet"])
			self.Global["DEBUG"] = false
		end
		if self.Global["ALLMOUNTS"] == nil then
			--Should be fired on first launch, set the saved variable to default value
			self:Msg(L["AllMountsNotSet"])
			self.Global["ALLMOUNTS"] = false
		end
		if self.Global["RAVENLORD"] == nil then
			self:Msg(L["RavenLordNotSet"])
			self.Global["RAVENLORD"] = false
		end
		if self.Global["MUSIC"] == nil then --If the song list is empty
			--Populate the table with default songs
			self:Msg(L["NoMusic"])
			self.Global["MUSIC"] = {}
			for _,v in pairs(self.Songs) do --Add all of the default songs
				self:AddMusic(v)
			end
		end
		if self.Global["ENABLED"] == nil then
			--Should be fired on first launch, set the saved variable to default value
			self:Msg(L["EnabledNotSet"])
			self.Global["ENABLED"] = true
		end
	elseif event == "UNIT_AURA" and select(1, ...) == "player" then
		local unitName = select(1, ...)
		self:DebugMsg((L["Event_UNIT_AURA"]):format(unitName))
		if self.Loaded == false then
			--This should NOT happen
			self:ErrorMsg(L["NotLoaded"])
		end
		t = 0
		ChocoboFrame:SetScript("OnUpdate", function (_, elapsed) Chocobo:OnUpdate(_, elapsed) end)
	elseif event == "PLAYER_LOGOUT" then
		--Save local copy of globals
		_G["CHOCOBO"] = self.Global
	end
end

function Chocobo:OnUpdate(_, elapsed)
	t = t + elapsed
	--When 1 second has elapsed, this is because it takes ~0.5 secs from the event detection for IsMounted() to return true.
	if t >= 1 then
		--Unregister the OnUpdate script
		ChocoboFrame:SetScript("OnUpdate", nil)
		--Is the player mounted?
		local Mounted = self:HasMount()
		if IsMounted() or Mounted then --More efficient way to make it also detect flight form here?
			self:DebugMsg(L["PlayerIsMounted"])
			--Loop through all the "hawkstrider" names to see if the player is mounted on one or check if allmounts (override) is true
			if Mounted or self.Global["ALLMOUNTS"] then
				self:DebugMsg(L["PlayerOnHawkstrider"])
				if self.Global["ENABLED"] then --Check if AddOn is enabled
					if self.Mounted == false then --Check so that the player is not already mounted
						self:DebugMsg(L["PlayingMusic"])
						self.Mounted = true
						local songID = math.random(1, #self.Global["MUSIC"]) --"#Chocobo.Global["MUSIC"]" = number of fields in Chocobo.Global["MUSIC"]
						self:DebugMsg((L["PlayingSong"]):format(songID, self.Global["MUSIC"][songID]))
						PlayMusic(self.Global["MUSIC"][songID])
					else --If the player has already mounted
						self:DebugMsg(L["AlreadyMounted"])
					end
				else
					self:DebugMsg(L["DisabledNotPlaying"])
				end
			else --Player is not on a hawkstrider
				self:DebugMsg(L["NoHawkstrider"])
			end
		else --When the player has dismounted
			if self.Mounted then
				self:DebugMsg(L["NotMounted"])
				self.Mounted = false
				StopMusic() --Note that StopMusic() will also stop any other custom music playing (such as from EpicMusicPlayer)
			end
		end
	end
end

function Chocobo:HasBuff(idtable)
	for _,ids in pairs(idtable) do
		for i=1,40 do --Loop through all 40 possible active buffs
			local name,_,_,_,_,_,_,_,_,_,id = UnitAura("player", i) --Get the name and spellID of the buff
			if name == nil or id == nil then return false end
			for _,v in pairs(ids) do --Compare the ID to the ones in the supplied table to see if they match
				if id == v then --If they do, report that the player has the buff and return true
					self:DebugMsg((L["CurrentMount"]):format(name))
					return true
				end
			end
		end
	end
	return false --Else return false
end

function Chocobo:HasMount()
	local idcoll = {self.IDs.Hawkstriders}
	if self.Global["RAVENLORD"] then
		table.insert(idcoll, self.IDs.RavenLord)
	end
	if self.Global["ALLMOUNTS"] then -- Add druid flight forms
		table.insert(idcoll, self.IDs.DruidForms)
	end
	return Chocobo:HasBuff(idcoll)
end

function Chocobo:PrintMusic() --Print all the songs currently in list to chat
	for k,v in pairs(self.Global["MUSIC"]) do
		self:Msg(("\124cff00CCFF%i: %s\124r"):format(k, v))
	end
end

function Chocobo:AddMusic(songName) --Add a song the the list
	songName = self:Trim(songName)
	if songName == "" or songName == nil then
		self:ErrorMsg(L["NoFile"])
		return
	end
	songName = self.MusicDir .. songName
	for _,v in pairs(self.Global["MUSIC"]) do --Loop through all the songs currently in the list and...
		if v == songName then --... make sure it isn't there already
			self:ErrorMsg(L["AlreadyExists"])
			return
		end
	end
	table.insert(self.Global["MUSIC"], songName) --Insert the song into list
	self:Msg((L["AddedSong"]):format(songName))
end

function Chocobo:RemoveMusic(songName) --Remove a song from the list
	songName = self:Trim(songName)
	if songName == "" or songName == nil then
		self:ErrorMsg(L["NoFile"])
		return
	end
	songName = self.MusicDir .. songName
	for k,v in pairs(self.Global["MUSIC"]) do --Loop through all the songs in the list until...
		if v == songName then --... the desired one is found and then...
			table.remove(self.Global["MUSIC"], k) --... remove it from the list.
			self:Msg((L["RemovedSong"]):format(songName))
			return
		end
	end
	self:ErrorMsg(L["SongNotFound"])
end

function Chocobo:ResetMusic() --Resets the values in Chocobo.Global["MUSIC"] to default
	self:Msg(L["ResetMusic"])
	self.Global["MUSIC"] = nil --"Erase" the data from Chocobo.Global["MUSIC"]
	self.Global["MUSIC"] = {} --Make it a new table
	for _,v in pairs(self.Songs) do --Add all the default songs again
		self:AddMusic(v)
	end
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

function Chocobo:Toggle() --Toggle the AddOn on and off
	if self.Global["ENABLED"] then --If the addon is enabled
		self.Global["ENABLED"] = false --Disable it
		StopMusic()
		self:Msg(L["AddOnDisabled"]) --Print status
		self:DebugMsg("Music stopped")
	else --If the addon is disabled
		self.Global["ENABLED"] = true --Enable it
		self:Msg(L["AddOnEnabled"]) --Print status
	end
end

function Chocobo:GetGlobal(var)
	return self.Global[var]
end

function Chocobo:Trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end


function Chocobo:Msg(msg) --Send a normal message
	DEFAULT_CHAT_FRAME:AddMessage(L["MsgPrefix"] .. msg)
end

function Chocobo:ErrorMsg(msg) --Send an error message, these are prefixed with the word "ERROR" in red
	DEFAULT_CHAT_FRAME:AddMessage(L["ErrorPrefix"] .. msg)
end

function Chocobo:DebugMsg(msg) --Send a debug message, these are only sent when debugging is enabled and are prefixed by the word "Debug" in yellow
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
	elseif command == "add" then
		if arg ~= "" then
			Chocobo:AddMusic(arg)
		else
			Chocobo:Msg(L["AddSyntax"])
		end
	elseif command == "remove" then
		if arg ~= "" then
			Chocobo:RemoveMusic(arg)
		else
			Chocobo:Msg(L["RemoveSyntax"])
		end
	elseif command == "list" then
		Chocobo:PrintMusic()
	elseif command == "reset" then
		Chocobo:ResetMusic()
	elseif command == "debug" then
		Chocobo:Debug(arg:lower())
	else
		Chocobo:Msg(L["HelpMessage"])
	end
end

--Create the frame, no need for an XML file!
local ChocoboFrame = CreateFrame("Frame", "ChocoboFrame")
ChocoboFrame:SetScript("OnEvent", function (frame, event, ...) Chocobo:OnEvent(frame, event, ...) end)
ChocoboFrame:RegisterEvent("ADDON_LOADED")
ChocoboFrame:RegisterEvent("UNIT_AURA")
