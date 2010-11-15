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
	Version	= 2.3,
	Loaded	= false,
	Mounted	= false,
	MusicDir = "Interface\\AddOns\\Chocobo\\music\\",
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
		46628  --Swift White Hawkstrider
	}
}

local t = 0

function Chocobo_OnEvent(self, event, ...)
	Chocobo_DebugMsg("OnEvent Fired")
	if (event == "ADDON_LOADED") then
		--Currently, this seems a bit bugged when having multiple addons. The "loaded" message will disappear sometimes.
		local addonName = select(1, ...)
		if (addonName == "Chocobo") then
			Chocobo_Msg("Chocobo version " .. Chocobo.Version .. " has been loaded successfully! Use /chocobo for options")
			Chocobo_Msg("Enjoy your chocobo!")
			Chocobo.Loaded = true
		end
		if (CHOCOBO_DEBUG == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg("Debug variable not set, setting debug variable to FALSE")
			CHOCOBO_DEBUG = false
		end
		if (CHOCOBO_ALLMOUNTS == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg("AllMounts variable not set, setting AllMounts variable to FALSE")
			CHOCOBO_ALLMOUNTS = false
		end
		if (CHOCOBO_MUSIC == nil) then --If the song list is empty
			--Populate the table with default songs
			Chocobo_Msg("Music list is empty, adding default values")
			CHOCOBO_MUSIC = {}
			for _,v in pairs(Chocobo.Songs) do --Add all of the default songs
				Chocobo_AddMusic(v)
			end
		end
		if (CHOCOBO_ENABLED == nil) then
			--Should be fired on first launch, set the saved variable to default value
			Chocobo_Msg("Enabled variable not set, setting Enabled variable to TRUE")
			CHOCOBO_ENABLED = true
		end
	elseif (event == "UNIT_AURA" and select(1, ...) == "player") then
		local unitName = select(1, ...)
		Chocobo_DebugMsg("UNIT_AURA Event Detected (" .. unitName .. ")")
		if (Chocobo.Loaded == false) then
			--This should NOT happen
			Chocobo_ErrorMsg("Something is wrong, addon doesn't seem to have loaded correctly")
		end
		t = 0
		ChocoboFrame:SetScript("OnUpdate", Chocobo_OnUpdate)
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
			Chocobo_DebugMsg("Player is mounted")
			--Loop through all the "hawkstrider" names to see if the player is mounted on one or check if allmounts (override) is true
			if (Chocobo_HasHawkstrider() or CHOCOBO_ALLMOUNTS) then
				Chocobo_DebugMsg("Player is on a hawkstrider or CHOCOBO_ALLMOUNTS is set to true")
				if (CHOCOBO_ENABLED) then --Check if AddOn is enabled
					if (Chocobo.Mounted == false) then --Check so that the player is not already mounted
						Chocobo_DebugMsg("Playing music")
						Chocobo.Mounted = true
						--Note that in 4.0.1 PlayMusic will NOT stop the game music currently playing. There is no fix for this (Stupid Blizzard)
						local songID = math.random(1, #CHOCOBO_MUSIC) --"#CHOCOBO_MUSIC" = number of fields in CHOCOBO_MUSIC
						Chocobo_DebugMsg(string.format("Playing song id |cff00CCFF%d|r (|cff00CCFF%s|r)", songID, CHOCOBO_MUSIC[songID]))
						PlayMusic(CHOCOBO_MUSIC[songID])
					else --If the player has already mounted
						Chocobo_DebugMsg("Player was already mounted, song already playing")
					end
				else
					Chocobo_DebugMsg("AddOn currently disabled, not playing music")
				end
			else
				--Playeris not on a hawkstrider
				Chocobo_DebugMsg("Player is not on a hawkstrider")
			end
		else
			--When the player has dismounted
			if (Chocobo.Mounted) then
				Chocobo_DebugMsg("Player not mounted, stopping music")
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
				Chocobo_DebugMsg("Found that \"" .. name .. "\" is your current mount")
				return true
			end
		end
	end
	return false --Else return false
end

function Chocobo_PrintMusic() --Print all the songs currently in list to chat
	for k,v in pairs(CHOCOBO_MUSIC) do
		Chocobo_Msg(string.format("\124cff00CCFF%i: %s\124r", k, v))
	end
end

function Chocobo_AddMusic(songName) --Add a song the the list
	songName = Chocobo.MusicDir .. songName
	for _,v in pairs(CHOCOBO_MUSIC) do --Loop through all the songs currently in the list and...
		if (v == songName) then --... make sure it isn't there already
			Chocobo_ErrorMsg("Song already exists in list")
			return
		end
	end
	table.insert(CHOCOBO_MUSIC, songName) --Insert the song into list
	Chocobo_Msg("Added |cff00CCFF" .. songName .. "|r to the music list!")
end

function Chocobo_RemoveMusic(songName) --Remove a song from the list
	songName = Chocobo.MusicDir .. songName
	for k,v in pairs(CHOCOBO_MUSIC) do --Loop through all the songs in the list until...
		if (v == songName) then --... the desired one is found and then...
			table.remove(CHOCOBO_MUSIC, k) --... remove it from the list.
			Chocobo_Msg("Removed |cff00CCFF" .. songName .. "|r from the music list!")
			return
		end
	end
	Chocobo_ErrorMsg("Unable to find the specified song in list")
end

function Chocobo_ResetMusic() --Resets the values in CHOCOBO_MUSIC to default
	Chocobo_Msg("Resetting music list to DEFAULT")
	CHOCOBO_MUSIC = nil --"Erase" the data from CHOCOBO_MUSIC
	CHOCOBO_MUSIC = {} --Make it a new table
	for _,v in pairs(Chocobo.Songs) do --Add all the default songs again
		Chocobo_AddMusic(v)
	end
end

function Chocobo_FilterMount(filter)
	if (filter == true) then
		Chocobo_Msg("Now playing chocobo on hawkstriders only!")
		CHOCOBO_ALLMOUNTS = false
	else
		Chocobo_Msg("Now playing chocobo on all mounts!")
		CHOCOBO_ALLMOUNTS = true
	end
end

function Chocobo_Debug(set)
	if (set == "enable" or set == "on") then
		Chocobo_Msg("Debugging enabled!")
		CHOCOBO_DEBUG = true
	elseif (set == "disable" or set == "off") then
		Chocobo_Msg("Debugging disabled!")
		CHOCOBO_DEBUG = false
	else
		if (CHOCOBO_DEBUG) then
			Chocobo_Msg("Debugging is enabled")
		else
			Chocobo_Msg("Debugging is disabled")
		end
	end
end

function Chocobo_Toggle() --Toggle the AddOn on and off
	if (CHOCOBO_ENABLED) then --If the addon is enabled
		CHOCOBO_ENABLED = false --Disable it
		StopMusic()
		Chocobo_Msg("AddOn |cffFF0000DISABLED|r") --Print status
		Chocobo_DebugMsg("Music stopped")
	else --If the addon is disabled
		CHOCOBO_ENABLED = true --Enable it
		Chocobo_Msg("AddOn |cff00FF00ENABLED|r") --Print status
	end
end

function Chocobo_Msg(msg) --Send a normal message
	DEFAULT_CHAT_FRAME:AddMessage("\124cff00FF00[Chocobo AddOn]\124r " .. msg)
end

function Chocobo_ErrorMsg(msg) --Send an error message, these are prefixed with the word "ERROR" in red
	DEFAULT_CHAT_FRAME:AddMessage("\124cff00FF00[Chocobo AddOn]\124r \124cffFF0000ERROR:\124r " .. msg)
end

function Chocobo_DebugMsg(msg) --Send a debug message, these are only sent when debugging is enabled and are prefixed by the word "Debug" in yellow
	if (CHOCOBO_DEBUG == true) then
		DEFAULT_CHAT_FRAME:AddMessage("\124cff00FF00[Chocobo AddOn]\124r \124cffFFFF00DEBUG:\124r " .. msg)
	end
end

SLASH_CHOCOBO1 = "/chocobo"
function SlashCmdList.CHOCOBO(msg, editBox)
	msg = string.lower(msg)
	local command, arg = msg:match("^(%S*)%s*(.-)$")
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
			Chocobo_Msg("Syntax: add songName")
		end
	elseif (command == "remove") then
		if (arg ~= "") then
			Chocobo_RemoveMusic(arg)
		else
			Chocobo_Msg("Syntax: remove songName")
		end
	elseif (command == "list") then
		Chocobo_PrintMusic()
	elseif (command == "reset") then
		Chocobo_ResetMusic()
	elseif (command == "debug") then
		Chocobo_Debug(arg)
	else
		--This list is growing rather large, perhaps there is a better way to print it?
		Chocobo_Msg("Commands:")
		Chocobo_Msg("allmounts: play chocobo song on any mount")
		Chocobo_Msg("hawkstrider: only play chocobo song on hawkstriders")
		Chocobo_Msg("toggle: Toggle the AddOn on and off")
		Chocobo_Msg("add songName: Adds a music file with name \"songName\" (including file extension)")
		Chocobo_Msg("remove songName: Removes a music file with name \"songName\" (including file extension)")
		Chocobo_Msg("(Note that the remove command will not remove the file from the system, only from the song list ingame)")
		Chocobo_Msg("list: List all the songs in the song list")
		Chocobo_Msg("reset: Reset to song list to default values (THIS WILL WIPE ANY CUSTOM SONGS YOU HAVE SET)")
		Chocobo_Msg("debug: check debug status, type enable or disable after to enable or disable debugging")
	end
end

--Create the frame, no need for an XML file!
local ChocoboFrame = CreateFrame("Frame", "ChocoboFrame")
ChocoboFrame:SetScript("OnEvent", Chocobo_OnEvent)
ChocoboFrame:RegisterEvent("ADDON_LOADED")
ChocoboFrame:RegisterEvent("UNIT_AURA")
