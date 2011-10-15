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

if (type(_G["ChocoboLocale"]) ~= "table") then
	_G["ChocoboLocale"] = {}
end

function ChocoboLocale_Default(L, key)
	return key
end

local L = _G["ChocoboLocale"]

L["AddOnLoaded"]			= "Chocobo %s has been loaded successfully! Use /chocobo for options"
L["Enjoy"]					= "Enjoy your chocobo!"

L["DebugNotSet"]			= "Debug variable not set, setting debug variable to FALSE"
L["AllMountsNotSet"]		= "AllMounts variable not set, setting AllMounts variable to FALSE"
L["RavenLordNotSet"]		= "RavenLord variable not set, setting RavenLord variable to FALSE"
L["HorseNotSet"]			= "Horse variable not set, setting Horse variable to FALSE"
L["SoundControlNotSet"]		= "Sound Control variables not set, setting default values..."
L["SoundControlReset"]		= "Sound Control variables has been reset"
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

L["MusicListEmpty"]			= "The music list is empty"
L["SongUpdated"]			= "Updated song with ID |cff00CCFF%d|r to path |cff00CCFF%q|r"
L["SongsUpdated"]			= "|cff00CCFF%d|r songs were updated!"
L["SongsUpToDate"]			= "All songs up to date"
L["NoFile"]					= "No file specified"
L["AlreadyExists"]			= "Song already exists in list"
L["AddedSong"]				= "Added |cff00CCFF%s|r to the music list!"
L["RemovedSong"]			= "Removed |cff00CCFF%s|r from the music list!"
L["SongNotFound"]			= "Unable to find the specified song in list"
L["ResetMusic"]				= "Resetting music list to DEFAULT"

L["MountListEmpty"]			= "The mount list is empty"
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
L["HorseTrue"]				= "Amazing Horse mode enabled!"
L["HorseFalse"]				= "Amazing Horse mode disabled"

L["SCVarsOutOfDate"]		= "Sound Control variables out of date, setting default values while trying to preserve user-made modifications..."
L["SCEnabled"]				= "Sound Control enabled!"
L["SCDisabled"]				= "Sound Control disabled!"
L["SCDefaultEnabled"]		= "Sound Control default mode enabled!"
L["SCDefaultDisabled"]		= "Sound Control default mode disabled!"
L["SCVolumeOutOfRange"]		= "Volume can only be a value between 0 and 100, inclusive"
L["SCVolumeNotAllowed"]		= "Volume cannot be changed while default mode is enabled"
L["SCMusicEnabled"]			= "Sound Control is now controlling music playback"
L["SCMusicDisabled"]		= "Sound Control is no longer controlling music playback"
L["SCMusicMountEnabled"]	= "Music will now play when mounted"
L["SCMusicMountDisabled"]	= "Music will no longer play when mounted"
L["SCMusicNoMountEnabled"]	= "Music will now play when not mounted"
L["SCMusicNoMountDisabled"]	= "Music will no longer play when not mounted"
L["SCMusicVolumeEnabled"]	= "Music volume control enabled"
L["SCMusicVolumeDisabled"]	= "Music volume control disabled"
L["SCNewMusicVolume"]		= "New music volume set to |cff00CCFF%d|r"
L["SCSFXEnabled"]			= "Sound Control is now controlling SFX playback"
L["SCSFXDisabled"]			= "Sound Control is no longer controlling SFX playback"
L["SCSFXMountEnabled"]		= "SFX will now play when mounted"
L["SCSFXMountDisabled"]		= "SFX will no longer play when mounted"
L["SCSFXNoMountEnabled"]	= "SFX will now play when not mounted"
L["SCSFXNoMountDisabled"]	= "SFX will no longer play when not mounted"
L["SCSFXVolumeEnabled"]		= "SFX volume control enabled"
L["SCSFXVolumeDisabled"]	= "SFX volume control disabled"
L["SCNewSFXVolume"]			= "New SFX volume set to |cff00CCFF%d|r"
L["SCAmbEnabled"]			= "Sound Control is now controlling ambience playback"
L["SCAmbDisabled"]			= "Sound control is no longer controlling ambience playback"
L["SCAmbMountEnabled"]		= "Ambience will now play when mounted"
L["SCAmbMountDisabled"]		= "Ambience will no longer play when mounted"
L["SCAmbNoMountEnabled"]	= "Ambience will now play when not mounted"
L["SCAmbNoMountDisabled"]	= "Ambience will no longer play when not mounted"
L["SCAmbVolumeEnabled"]		= "Ambience volume control enabled"
L["SCAmbVolumeDisabled"]	= "Ambience volume control disabled"
L["SCNewAmbVolume"]			= "New ambience volume set to |cff00CCFF%d|r"

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
L["SCSyntax1"]				= "Syntax: soundcontrol |cff00CCFFgui|r|||cff00CCFFtoggle|r|||cff00CCFFdefault|r"
L["SCSyntax2"]				= "Syntax: soundcontrol |cff00CCFFmusic|r|||cff00CCFFsfx|r|||cff00CCFFambience|r |cff00CCFFtoggle|r|||cff00CCFFmount|r|||cff00CCFFnomount|r|||cff00CCFFvolume|r"
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
L["HelpMessage16"]			= "soundcontrol: Various settings for sound control. Type /chocobo soundcontrol for usage."
L["InvalidCommand"]			= "%q is not a valid command, please consult the AddOn documentation for a list of available commands"

--[[Chocobo Options]]--
--The frame
L["Options_SongPanelDesc"]			= "Add/Remove, reset and list songs"
L["Options_MountPanelDesc"]			= "Add/Remove, reset and list mounts"
L["Options_Add"]					= "Add"
L["Options_Remove"]					= "Remove"
L["Options_Reset"]					= "Reset"
L["Options_List"]					= "List"
L["Options_OpenSoundControlButton"]	= "Open sound control panel"
L["Options_RavenLordToggle"]		= "Play music when mounting Raven Lord (Anzu)"
L["Options_HorseToggle"]			= "Enable |cffFF66FFAmazing Horse Mode|r"
L["Options_HorseHelp"]				= "|cffFFFFFFPlay a special kind of song when mounting any kind of |cffFF66FFhorse|cffFFFFFF...|r"
--The code
L["Options_Enabled"]		= "enabled"
L["Options_Disabled"]		= "disabled"
L["Options_AllMounts"]		= "Music on \124cffFFFFFFall mounts\124r"
L["Options_Hawkstrider"]	= "Music on \124cffFFFFFFhawkstriders only\124r"
L["Options_RavenLordTrue"]	= "Playing music on Raven Lord (Anzu)"
L["Options_RavenLordFalse"]	= "Not playing music on Raven Lord (Anzu)"
L["Options_AddOnState"]		= "AddOn is \124cff%s%s\124r"
L["Options_DebugState"]		= "Debugging is \124cff%s%s\124r"
L["Options_Description"]	= "Configuration page for Chocobo|n%s"

--[[Sound Control Strings]]--
--The frame
L["SoundControl_Music"]				= "Music"
L["SoundControl_SFX"]				= "SFX"
L["SoundControl_Ambience"]			= "Ambience"
L["SoundControl_Caption"]			= "Use the various settings here to control how sound control should behave."
L["SoundControl_Description"]		= "When in sound control mode, the AddOn will automatically enable and disable all game sounds when you mount and dismount."
L["SoundControl_Toggle"]			= "Enable sound control"
L["SoundControl_ToggleDefault"]		= "Enable default mode"
L["SoundControl_DefaultHelp"]		= "When in default mode, the AddOn will function as it previously did. Enabling music playback while on mount and disabling all other sounds."
L["SoundControl_DefaultNote"]		= "|cffFF0000Please note that when default mode is enabled, all settings below will be ignored.|r"
L["SoundControl_MusicDesc"]			= "Settings for music playback"
L["SoundControl_MusicEnable"]		= "Enable music control"
L["SoundControl_MusicMount"]		= "Music enabled when mounted"
L["SoundControl_MusicNoMount"]		= "Music enabled when not mounted"
L["SoundControl_MusicVolume"]		= "Enable music volume control"
L["SoundControl_MusicSetVolume"]	= "Set music volume to:"
L["SoundControl_SFXDesc"]			= "Settings for SFX playback"
L["SoundControl_SFXEnable"]			= "Enable SFX control"
L["SoundControl_SFXMount"]			= "SFX enabled when mounted"
L["SoundControl_SFXNoMount"]		= "SFX enabled when not mounted"
L["SoundControl_SFXVolume"]			= "Enable SFX volume control"
L["SoundControl_SFXSetVolume"]		= "Set SFX volume to:"
L["SoundControl_AmbienceDesc"]		= "Settings for ambience playback"
L["SoundControl_AmbienceEnable"]	= "Enable ambience control"
L["SoundControl_AmbienceMount"]		= "Ambience enabled when mounted"
L["SoundControl_AmbienceNoMount"]	= "Ambience enabled when not mounted"
L["SoundControl_AmbienceVolume"]	= "Enable ambience volume control"
L["SoundControl_AmbienceSetVolume"]	= "Set ambience volume to:"

--[[Broker Plugin Strings]]--
L["Broker_Text"]		= "Open Chocobo options"
L["Broker_Version"]		= "|cffFFFFFFBroker Chocobo %s|r"
L["Broker_LeftClick"]	= "Left Click - Open Chocobo Options"
L["Broker_MiddleClick"]	= "Middle Click - Toggle Sound Control"
L["Broker_RightClick"]	= "Right Click - Open Chocobo Sound Control"

setmetatable(L, {__index=ChocoboLocale_Default})
