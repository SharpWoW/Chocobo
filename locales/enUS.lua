if (type(_G["ChocoboLocale"]) ~= "table") then
	_G["ChocoboLocale"] = {}
end

function ChocoboLocale_Default(L, key)
	return key
end

local L = _G["ChocoboLocale"]

L["AddOnLoaded"]		= "Chocobo version %s has been loaded successfully! Use /chocobo for options"
L["Enjoy"]				= "Enjoy your chocobo!"

L["DebugNotSet"]		= "Debug variable not set, setting debug variable to FALSE"
L["AllMountsNotSet"]	= "AllMounts variable not set, setting AllMounts variable to FALSE"
L["NoMusic"]			= "Music list is empty, adding default values"
L["EnabledNotSet"]		= "Enabled variable not set, setting Enabled variable to TRUE"

L["Event_UNIT_AURA"]	= "UNIT_AURA Event Detected (%s)"

L["NotLoaded"]			= "Something is wrong, addon doesn't seem to have loaded correctly"

L["PlayerIsMounted"]	= "Player is mounted"
L["PlayerOnHawkstrider"] = "Player is on a hawkstrider or CHOCOBO_ALLMOUNTS is set to true"
L["PlayingMusic"]		= "Playing Music"
L["PlayingSong"]		= "Playing song id |cff00CCFF%d|r (|cff00CCFF%s|r)"
L["AlreadyMounted"]		= "Player was already mounted, song already playing"
L["DisabledNotPlaying"] = "AddOn currently disabled, not playing music"
L["NoHawkstrider"]		= "Player is not on a hawkstrider"
L["NotMounted"]			= "Player not mounted, stopping music"
L["CurrentMount"]		= "Found that %q is your current mount"

L["NoFile"]				= "No file specified"
L["AlreadyExists"]		= "Song already exists in list"
L["AddedSong"]			= "Added |cff00CCFF%s|r to the music list!"
L["RemovedSong"]		= "Removed |cff00CCFF%s|r from the music list!"
L["SongNotFound"]		= "Unable to find the specified song in list"

L["ResetMusic"]			= "Resetting music list to DEFAULT"

L["HawkstriderOnly"]	= "Now playing chocobo on hawkstriders only!"
L["AllMounts"]			= "Now playing chocobo on all mounts!"

L["DebuggingEnabled"]	= "Debugging enabled!"
L["DebuggingDisabled"]	= "Debugging disabled!"
L["DebugIsEnabled"]		= "Debugging is enabled"
L["DebugIsDisabled"]	= "Debugging is disabled"
L["AddOnDisabled"]		= "AddOn |cffFF0000DISABLED|r"
L["AddOnEnabled"]		= "AddOn |cff00FF00ENABLED|r"

L["MsgPrefix"]			= "\124cff00FF00[Chocobo AddOn]\124r "
L["ErrorPrefix"]		= "\124cff00FF00[Chocobo AddOn]\124r \124cffFF0000ERROR:\124r "
L["DebugPrefix"]		= "\124cff00FF00[Chocobo AddOn]\124r \124cffFFFF00DEBUG:\124r "
L["AddSyntax"]			= "Syntax: add songName"
L["RemoveSyntax"]		= "Syntax: remove songName"
L["HelpMessage"]		= [=[Commands:
options: Show the GUI
allmounts: play chocobo song on any mount
hawkstrider: only play chocobo song on hawkstriders
toggle: Toggle the AddOn on and off
add songName: Adds a music file with name "songName" (including file extension)
remove songName: Removes a music file with name "songName" (including file extension)
(Note that the remove command will not remove the file from the system, only from the song list ingame)
list: List all the songs in the song list
reset: Reset to song list to default values (THIS WILL WIPE ANY CUSTOM SONGS YOU HAVE SET)
debug: check debug status, type enable or disable after to enable or disable debugging]=]

--[[Chocobo Options]]--
--The frame
L["Options_Title"] = "Chocobo Options"
L["Options_SongPanelDesc"] = "Add/Remove, reset and list songs"
L["Options_Add"] = "Add"
L["Options_Remove"] = "Remove"
L["Options_Reset"] = "Reset"
L["Options_List"] = "List"
L["Options_HawkstriderButton"] = "Play music on|nhawkstrider only"
L["Options_AllMountsButton"] = "Play music|non all mounts"
L["Options_EnableDebugging"] = "Enable debugging"
L["Options_DisableDebugging"] = "Disable debugging"
L["Options_ToggleButton"] = "Toggle AddOn on and off"
--The code
L["Options_Enabled"] = "enabled"
L["Options_Disabled"] = "disabled"
L["Options_AllMounts"] = "Playing music on all mounts."
L["Options_Hawkstrider"] = "Playing music on hawkstriders only."
L["Options_AddOnState"] = "AddOn is %s."
L["Options_DebugState"] = "Debugging is %s."
L["Options_Description"] = "Configure the AddOn!|nv%s"

setmetatable(L, {__index=ChocoboLocale_Default})
