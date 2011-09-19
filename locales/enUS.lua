if (type(_G["ChocoboLocale"]) ~= "table") then
	_G["ChocoboLocale"] = {}
end

function ChocoboLocale_Default(L, key)
	return key
end

local L = _G["ChocoboLocale"]

L["AddOnLoaded"]			= "Chocobo version %s has been loaded successfully! Use /chocobo for options"
L["Enjoy"]					= "Enjoy your chocobo!"

L["DebugNotSet"]			= "Debug variable not set, setting debug variable to FALSE"
L["AllMountsNotSet"]		= "AllMounts variable not set, setting AllMounts variable to FALSE"
L["RavenLordNotSet"]		= "RavenLord variable not set, setting RavenLord variable to FALSE"
L["SoundControlNotSet"]		= "SoundControl variable not set, setting SoundControl variable to FALSE"
L["NoMusic"]				= "Music list is empty, adding default values"
L["NoMounts"]				= "User mount list is empty, setting to default value (empty)"
L["EnabledNotSet"]			= "Enabled variable not set, setting Enabled variable to TRUE"

L["Event_UNIT_AURA"]		= "UNIT_AURA Event Detected (%s)"

L["NotLoaded"]				= "Something is wrong, addon doesn't seem to have loaded correctly"

L["PlayerIsMounted"]		= "Player is mounted"
L["PlayerOnHawkstrider"]	= "Player is on a hawkstrider or CHOCOBO_ALLMOUNTS is set to true"
L["PlayingMusic"]			= "Playing Music"
L["PlayingSong"]			= "Playing song id |cff00CCFF%d|r (|cff00CCFF%s|r)"
L["AlreadyMounted"]			= "Player was already mounted, song already playing"
L["DisabledNotPlaying"] 	= "AddOn currently disabled, not playing music"
L["NoHawkstrider"]			= "Player is not on a hawkstrider"
L["NotMounted"]				= "Player not mounted, stopping music"
L["CurrentMount"]			= "Found that %q is your current mount"

L["NoFile"]					= "No file specified"
L["AlreadyExists"]			= "Song already exists in list"
L["AddedSong"]				= "Added |cff00CCFF%s|r to the music list!"
L["RemovedSong"]			= "Removed |cff00CCFF%s|r from the music list!"
L["SongNotFound"]			= "Unable to find the specified song in list"
L["ResetMusic"]				= "Resetting music list to DEFAULT"

L["NoMount"]				= "No mount specified"
L["MountAlreadyExists"]		= "Mount already exists in list"
L["AddedMount"]				= "Added |cff00CCFF%s|r to the mount list!"
L["RemovedMount"]			= "Removed |cff00CCFF%s|r from the mount list!"
L["MountNotFound"]			= "Unable to find the specified mount in list"
L["ResetMounts"]			= "Resetting user mount list to DEFAULT (empty)"

L["HawkstriderOnly"]		= "Now playing chocobo on hawkstriders only!"
L["AllMounts"]				= "Now playing chocobo on all mounts!"
L["RavenLordTrue"]			= "Now playing chocobo on Raven Lord (Anzu)"
L["RavenLordFalse"]			= "Not playing chocobo on Raven Lord (Anzu)"

L["SoundControlEnabled"]	= "Sound control enabled!"
L["SoundControlDisabled"]	= "Sound control disabled!"
L["DebuggingEnabled"]		= "Debugging enabled!"
L["DebuggingDisabled"]		= "Debugging disabled!"
L["DebugIsEnabled"]			= "Debugging is enabled"
L["DebugIsDisabled"]		= "Debugging is disabled"
L["AddOnDisabled"]			= "AddOn |cffFF0000DISABLED|r"
L["AddOnEnabled"]			= "AddOn |cff00FF00ENABLED|r"

L["MsgPrefix"]				= "\124cff00FF00[Chocobo]\124r "
L["ErrorPrefix"]			= "\124cff00FF00[Chocobo]\124r \124cffFF0000ERROR:\124r "
L["DebugPrefix"]			= "\124cff00FF00[Chocobo]\124r \124cffFFFF00DEBUG:\124r "
L["AddSyntax"]				= "Syntax: add <name of song>"
L["RemoveSyntax"]			= "Syntax: remove <name of song>"
L["AddMountSyntax"]			= "Syntax: addmount <name or ID of mount>"
L["RemoveMountSyntax"]		= "Syntax: removemount <name or ID of mount>"
L["HelpMessage1"]			= "Commands:"
L["HelpMessage2"]			= "options: Show the GUI"
L["HelpMessage3"]			= "allmounts: play chocobo song on any mount"
L["HelpMessage4"]			= "hawkstrider: only play chocobo song on hawkstriders"
L["HelpMessage5"]			= "toggle: Toggle the AddOn on and off"
L["HelpMessage6"]			= "add <name of song>: Adds a music file with the name specified (including file extension)"
L["HelpMessage7"]			= "remove <name of song>: Removes a music file with the name specified (including file extension)"
L["HelpMessage8"]			= "(Note that the remove command will not remove the file from the system, only from the song list ingame)"
L["HelpMessage9"]			= "list: List all the songs in the song list"
L["HelpMessage10"]			= "reset: Reset to song list to default values (THIS WILL WIPE ANY CUSTOM SONGS YOU HAVE SET)"
L["HelpMessage11"]			= "debug: check debug status, type enable or disable after to enable or disable debugging"
L["HelpMessage12"]			= "addmount <name or ID of mount>: Add a mount that music will play for when AddOn is in \"Hawkstrider Only\" mode"
L["HelpMessage13"]			= "removemount <name or ID of mount>: Remove a mount from the mount list (user-added mounts only)"
L["HelpMessage14"]			= "listmounts: List all user-added mounts"
L["HelpMessage15"]			= "resetmounts: Reset user-added mounts to default (empty)"
L["HelpMessage16"]			= "soundcontrol: Toggle the sound control on and off"

--[[Chocobo Options]]--
--The frame
L["Options_Title"]					= "Chocobo Options"
L["Options_SongPanelDesc"]			= "Add/Remove, reset and list songs"
L["Options_MountPanelDesc"]			= "Add/Remove, reset and list mounts"
L["Options_Add"]					= "Add"
L["Options_Remove"]					= "Remove"
L["Options_Reset"]					= "Reset"
L["Options_List"]					= "List"
L["Options_HawkstriderButton"]		= "Play music on|nhawkstrider only"
L["Options_AllMountsButton"]		= "Play music|non all mounts"
L["Options_EnableDebugging"]		= "Enable debugging"
L["Options_DisableDebugging"]		= "Disable debugging"
L["Options_ToggleButton"]			= "Toggle AddOn on and off"
L["Options_OpenSoundControlButton"]	= "Open sound control panel"
L["Options_RavenLordToggle"]		= "Play music when mounting Raven Lord (Anzu)"
--The code
L["Options_Enabled"]		= "enabled"
L["Options_Disabled"]		= "disabled"
L["Options_AllMounts"]		= "Playing music on all mounts."
L["Options_Hawkstrider"]	= "Playing music on hawkstriders only."
L["Options_RavenLordTrue"]	= "Playing music on Raven Lord (Anzu)"
L["Options_RavenLordFalse"]	= "Not playing music on Raven Lord (Anzu)"
L["Options_AddOnState"]		= "AddOn is %s."
L["Options_DebugState"]		= "Debugging is %s."
L["Options_Description"]	= "Configure the AddOn!|nv%s"

--[[Sound Control Strings]]--
--The frame
L["SoundControl_Title"]			= "Chocobo Sound Control"
L["SoundControl_Caption"]		= "Use the button below to toggle sound control mode."
L["SoundControl_Description"]	= "When in sound control mode, the AddOn will automatically enable and disable all game sounds when you mount and dismount."
L["SoundControl_ToggleButton"]	= "Toggle sound control on and off"
L["SoundControl_ReturnButton"]	= "Return to main options"
--The code
L["SoundControl_State"]	= "Sound control is %s!"

--[[Broker Plugin Strings]]--
L["Broker_Text"]	= "Open Chocobo options"
L["Broker_Version"]	= "Broker Chocobo v%s"
L["Broker_Click"]	= "Click - Open Chocobo Options"

setmetatable(L, {__index=ChocoboLocale_Default})
