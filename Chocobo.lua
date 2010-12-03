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

local Chocobo = {
	Version	= 2.5,
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
	Names	= {
		"Black Hawkstrider",
		"Blue Hawkstrider",
		"Purple Hawkstrider",
		"Red Hawkstrider",
		"Silvermoon Hawkstrider",
		"Sunreaver Hawkstrider",
		"Swift Green Hawkstrider",
		"Swift Pink Hawkstrider",
		"Swift Purple Hawkstrider",
		"Swift Red Hawkstrider",
		"Swift Warstrider",
		"Swift White Hawkstrider"
	},
	IDs	= {
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
	}
}

local t = 0

local L = _G["ChocoboLocale"]

function Chocobo_OnEvent(self, event, ...)
	Chocobo_DebugMsg("OnEvent Fired")
	if (event == "ADDON_LOADED") then
		--Currently, this seems a bit bugged when having multiple addons. The "loaded" message will disappear sometimes.
		local addonName = select(1, ...)
		if (addonName == "Chocobo") then
			Chocobo_Msg((L["AddOnLoaded"]):format(Chocobo.Version))
			Chocobo_Msg(L["Enjoy"])
			Chocobo.Loaded = true
		end
		if (type(_G["CHOCOBO"]) ~= "table") then _G["CHOCOBO"] = {} end
		Chocobo.Global = _G["CHOCOBO"]
		if (Chocobo.Global["DEBUG"] == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg(L["DebugNotSet"])
			Chocobo.Global["DEBUG"] = false
		end
		if (Chocobo.Global["ALLMOUNTS"] == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg(L["AllMountsNotSet"])
			Chocobo.Global["ALLMOUNTS"] = false
		end
		if (Chocobo.Global["MUSIC"] == nil) then --If the song list is empty
			--Populate the table with default songs
			Chocobo_Msg(L["NoMusic"])
			Chocobo.Global["MUSIC"] = {}
			for _,v in pairs(Chocobo.Songs) do --Add all of the default songs
				Chocobo_AddMusic(v)
			end
		end
		if (Chocobo.Global["ENABLED"] == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg(L["EnabledNotSet"])
			Chocobo.Global["ENABLED"] = true
		end
	elseif (event == "UNIT_AURA" and select(1, ...) == "player") then
		local unitName = select(1, ...)
		Chocobo_DebugMsg((L["Event_UNIT_AURA"]):format(unitName))
		if (Chocobo.Loaded == false) then
			--This should NOT happen
			Chocobo_ErrorMsg(L["NotLoaded"])
		end
		t = 0
		ChocoboFrame:SetScript("OnUpdate", Chocobo_OnUpdate)
	elseif (event == "PLAYER_LOGOUT") then
		--Save local copy of globals
		_G["CHOCOBO"] = Chocobo.Global
	end
end

function Chocobo_OnUpdate(_, elapsed)
	t = t + elapsed
	--When 1 second has elapsed, this is because it takes ~0.5 secs from the event detection for IsMounted() to return true.
	if (t >= 1) then
		--Unregister the OnUpdate script
		ChocoboFrame:SetScript("OnUpdate", nil)
		--Is the player mounted?
		if (IsMounted()) then
			Chocobo_DebugMsg(L["PlayerIsMounted"])
			--Loop through all the "hawkstrider" names to see if the player is mounted on one or check if allmounts (override) is true
			if (Chocobo_HasHawkstrider() or Chocobo.Global["ALLMOUNTS"]) then
				Chocobo_DebugMsg(L["PlayerOnHawkstrider"])
				if (Chocobo.Global["ENABLED"]) then --Check if AddOn is enabled
					if (Chocobo.Mounted == false) then --Check so that the player is not already mounted
						Chocobo_DebugMsg(L["PlayingMusic"])
						Chocobo.Mounted = true
						--Note that in 4.0.1 PlayMusic will NOT stop the game music currently playing. There is no fix for this (Stupid Blizzard)
						local songID = math.random(1, #Chocobo.Global["MUSIC"]) --"#Chocobo.Global["MUSIC"]" = number of fields in Chocobo.Global["MUSIC"]
						Chocobo_DebugMsg((L["PlayingSong"]):format(songID, Chocobo.Global["MUSIC"][songID]))
						PlayMusic(Chocobo.Global["MUSIC"][songID])
					else --If the player has already mounted
						Chocobo_DebugMsg(L["AlreadyMounted"])
					end
				else
					Chocobo_DebugMsg(L["DisabledNotPlaying"])
				end
			else
				--Player is not on a hawkstrider
				Chocobo_DebugMsg(L["NoHawkStrider"])
			end
		else
			--When the player has dismounted
			if (Chocobo.Mounted) then
				Chocobo_DebugMsg(L["NotMounted"])
				Chocobo.Mounted = false
				--Note that StopMusic() will also stop any other custom music playing (such as from EpicMusicPlayer)
				StopMusic()
			end
		end
	end
end

function Chocobo_HasHawkstrider()
	for i=1,40 do --Loop through all 40 possible active buffs
		local name,_,_,_,_,_,_,_,_,_,id = UnitAura("player", i) --Get the name and spellID of the buff
		if (name == nil or id == nil) then return false end
		for _,v in pairs(Chocobo.IDs) do --Compare the ID to the ones in the table to see if they match
			if (id == v) then --If they do, report that the player has a hawkstrider and return true
				Chocobo_DebugMsg((L["CurrentMount"]):format(name))
				return true
			end
		end
	end
	return false --Else return false
end

function Chocobo_PrintMusic() --Print all the songs currently in list to chat
	for k,v in pairs(Chocobo.Global["MUSIC"]) do
		Chocobo_Msg(("\124cff00CCFF%i: %s\124r"):format(k, v))
	end
end

function Chocobo_AddMusic(songName) --Add a song the the list
	songName = Chocobo_Trim(songName)
	if (songName == "" or songName == nil) then
		Chocobo_ErrorMsg(L["NoFile"])
		return
	end
	songName = Chocobo.MusicDir .. songName
	for _,v in pairs(Chocobo.Global["MUSIC"]) do --Loop through all the songs currently in the list and...
		if (v == songName) then --... make sure it isn't there already
			Chocobo_ErrorMsg(L["AlreadyExists"])
			return
		end
	end
	table.insert(Chocobo.Global["MUSIC"], songName) --Insert the song into list
	Chocobo_Msg((L["AddedSong"]):format(songName))
end

function Chocobo_RemoveMusic(songName) --Remove a song from the list
	songName = Chocobo.MusicDir .. songName
	for k,v in pairs(Chocobo.Global["MUSIC"]) do --Loop through all the songs in the list until...
		if (v == songName) then --... the desired one is found and then...
			table.remove(Chocobo.Global["MUSIC"], k) --... remove it from the list.
			Chocobo_Msg((L["RemovedSong"]):format(songName))
			return
		end
	end
	Chocobo_ErrorMsg(L["SongNotFound"])
end

function Chocobo_ResetMusic() --Resets the values in Chocobo.Global["MUSIC"] to default
	Chocobo_Msg(L["ResetMusic"])
	Chocobo.Global["MUSIC"] = nil --"Erase" the data from Chocobo.Global["MUSIC"]
	Chocobo.Global["MUSIC"] = {} --Make it a new table
	for _,v in pairs(Chocobo.Songs) do --Add all the default songs again
		Chocobo_AddMusic(v)
	end
end

function Chocobo_FilterMount(filter)
	if (filter == true) then
		Chocobo_Msg(L["HawkstriderOnly"])
		Chocobo.Global["ALLMOUNTS"] = false
	else
		Chocobo_Msg(L["AllMounts"])
		Chocobo.Global["ALLMOUNTS"] = true
	end
end

function Chocobo_Debug(set)
	if (set == "enable" or set == "on") then
		Chocobo_Msg(L["DebuggingEnabled"])
		Chocobo.Global["DEBUG"] = true
	elseif (set == "disable" or set == "off") then
		Chocobo_Msg(L["DebuggingDisabled"])
		Chocobo.Global["DEBUG"] = false
	else
		if (CHOCOBO_DEBUG) then
			Chocobo_Msg(L["DebugIsEnabled"])
		else
			Chocobo_Msg(L["DebugIsDisabled"])
		end
	end
end

function Chocobo_Toggle() --Toggle the AddOn on and off
	if (Chocobo.Global["ENABLED"]) then --If the addon is enabled
		Chocobo.Global["ENABLED"] = false --Disable it
		StopMusic()
		Chocobo_Msg(L["AddOnDisabled"]) --Print status
		Chocobo_DebugMsg("Music stopped")
	else --If the addon is disabled
		Chocobo.Global["ENABLED"] = true --Enable it
		Chocobo_Msg(L["AddOnEnabled"]) --Print status
	end
end

function Chocobo_GetGlobal(var)
	return Chocobo.Global[var]
end

function Chocobo_Trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end


function Chocobo_Msg(msg) --Send a normal message
	DEFAULT_CHAT_FRAME:AddMessage(L["MsgPrefix"] .. msg)
end

function Chocobo_ErrorMsg(msg) --Send an error message, these are prefixed with the word "ERROR" in red
	DEFAULT_CHAT_FRAME:AddMessage(L["ErrorPrefix"] .. msg)
end

function Chocobo_DebugMsg(msg) --Send a debug message, these are only sent when debugging is enabled and are prefixed by the word "Debug" in yellow
	if (Chocobo.Global["DEBUG"] == true) then
		DEFAULT_CHAT_FRAME:AddMessage(L["DebugPrefix"] .. msg)
	end
end

function Chocobo_GetVersion()
	return Chocobo.Version
end

SLASH_CHOCOBO1 = "/chocobo"
function SlashCmdList.CHOCOBO(msg, editBox)
	local command, arg = msg:match("^(%S*)%s*(.-)$")
	command = command:lower()
	if (command == "options") then
		ChocoboOptionsFrame:Show()
	elseif (command == "allmounts") then
		Chocobo_FilterMount(false)
	elseif (command == "hawkstrider") then
		Chocobo_FilterMount(true)
	elseif (command == "toggle") then
		Chocobo_Toggle()
	elseif (command == "add") then
		if (arg ~= "") then
			Chocobo_AddMusic(arg)
		else
			Chocobo_Msg(L["AddSyntax"])
		end
	elseif (command == "remove") then
		if (arg ~= "") then
			Chocobo_RemoveMusic(arg)
		else
			Chocobo_Msg(L["RemoveSyntax"])
		end
	elseif (command == "list") then
		Chocobo_PrintMusic()
	elseif (command == "reset") then
		Chocobo_ResetMusic()
	elseif (command == "debug") then
		Chocobo_Debug(arg:lower())
	else
		Chocobo_Msg(L["HelpMessage"])
	end
end

--Create the frame, no need for an XML file!
local ChocoboFrame = CreateFrame("Frame", "ChocoboFrame")
ChocoboFrame:SetScript("OnEvent", Chocobo_OnEvent)
ChocoboFrame:RegisterEvent("ADDON_LOADED")
ChocoboFrame:RegisterEvent("UNIT_AURA")
