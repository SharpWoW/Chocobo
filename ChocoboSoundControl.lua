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

local C = Chocobo

C.SoundControl = {
	Settings = {}
}

local SC = C.SoundControl

local L = _G["ChocoboLocale"]

function SC:Init()
	if type(C.Global["SOUNDCONTROL"]) ~= "table" then
		C:Msg(L["SoundControlNotSet"])
		C.Global["SOUNDCONTROL"] = {
			["ENABLED"] = false, -- Enable sound control at all?
			["DEFAULT"] = true, -- Use the old style sound control?
			["SOUND"] = {
				["ENABLED"] = true, -- Should AddOn control SFX playback?
				["MOUNTED"] = false, -- SFX when mounted?
				["NOTMOUNTED"] = false, -- SFX when not mounted?
				["DEFAULT_VOLUME"] = 1.0, -- Volume to modify to if volume <= 0
				["MOD_VOLUME"] = false -- Whether or not to modify volume
			},
			["MUSIC"] = {
				["ENABLED"] = true, -- Should AddOn control music playback?
				["MOUNTED"] = true, -- Music when mounted?
				["NOTMOUNTED"] = false, -- Music when not mounted?
				["DEFAULT_VOLUME"] = 1.0, -- Volume to modify to if volume <= 0
				["MOD_VOLUME"] = true -- Whether or not to modify volume
			},
			["AMBIENCE"] = {
				["ENABLED"] = true, -- Should AddOn control ambience playback?
				["MOUNTED"] = false, -- Ambience when mounted?
				["NOTMOUNTED"] = false, -- Ambience when not mounted?
				["DEFAULT_VOLUME"] = 1.0, -- Volume to modify to if volume <= 0
				["MOD_VOLUME"] = false -- Whether or not to modify volume
			}
		}
	end
	
	self.Settings = C.Global["SOUNDCONTROL"]
	
	self:Check()
end

local function BoolToNum(bool)
	if bool then return 1 else return 0 end
end

function SC:Toggle(silent)
	self.Settings["ENABLED"] = not self.Settings["ENABLED"]
	if self.Settings["ENABLED"] then
		if not silent then C:Msg(L["SCEnabled"]) end
		self:Check()
	else
		if not silent then C:Msg(L["SCDisabled"]) end
		self:Restore()
	end
end

function SC:ToggleDefault(silent)
	self.Settings["DEFAULT"] = not self.Settings["DEFAULT"]
	self:Check()
	if silent then return end
	if self.Settings["DEFAULT"] then
		C:Msg(L["SCDefaultEnabled"])
	else
		C:Msg(L["SCDefaultDisabled"])
	end
end

function SC:ToggleMusic(silent)
	self.Settings["MUSIC"]["ENABLED"] = not self.Settings["MUSIC"]["ENABLED"]
	self:Check()
	if silent then return end
	if self.Settings["MUSIC"]["ENABLED"] then
		C:Msg(L["SCMusicEnabled"])
	else
		C:Msg(L["SCMusicDisabled"])
	end
end

function SC:ToggleMusicMount(silent)
	self.Settings["MUSIC"]["MOUNTED"] = not self.Settings["MUSIC"]["MOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["MUSIC"]["MOUNTED"] then
		C:Msg(L["SCMusicMountEnabled"])
	else
		C:Msg(L["SCMusicMountDisabled"])
	end
end

function SC:ToggleMusicNoMount(silent)
	self.Settings["MUSIC"]["NOTMOUNTED"] = not self.Settings["MUSIC"]["NOTMOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["MUSIC"]["NOTMOUNTED"] then
		C:Msg(L["SCMusicNoMountEnabled"])
	else
		C:Msg(L["SCMusicNoMountDisabled"])
	end
end

function SC:ToggleSound(silent)
	self.Settings["SOUND"]["ENABLED"] = not self.Settings["SOUND"]["ENABLED"]
	self:Check()
	if silent then return end
	if self.Settings["SOUND"]["ENABLED"] then
		C:Msg(L["SCSFXEnabled"])
	else
		C:Msg(L["SCSFXDisabled"])
	end
end

function SC:ToggleSoundMount(silent)
	self.Settings["SOUND"]["MOUNTED"] = not self.Settings["SOUND"]["MOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["SOUND"]["MOUNTED"] then
		C:Msg(L["SCSFXMountEnabled"])
	else
		C:Msg(L["SCSFXMountDisabled"])
	end
end

function SC:ToggleSoundNoMount(silent)
	self.Settings["SOUND"]["NOTMOUNTED"] = not self.Settings["SOUND"]["NOTMOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["SOUND"]["NOTMOUNTED"] then
		C:Msg(L["SCSFXNoMountEnabled"])
	else
		C:Msg(L["SCSFXNoMountDisabled"])
	end
end

function SC:ToggleAmbience(silent)
	self.Settings["AMBIENCE"]["ENABLED"] = not self.Settings["AMBIENCE"]["ENABLED"]
	self:Check()
	if silent then return end
	if self.Settings["AMBIENCE"]["ENABLED"] then
		C:Msg(L["SCAmbEnabled"])
	else
		C:Msg(L["SCAmbDisabled"])
	end
end

function SC:ToggleAmbienceMount(silent)
	self.Settings["AMBIENCE"]["MOUNTED"] = not self.Settings["AMBIENCE"]["MOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["AMBIENCE"]["MOUNTED"] then
		C:Msg(L["SCAmbMountEnabled"])
	else
		C:Msg(L["SCAmbMountDisabled"])
	end
end

function SC:ToggleAmbienceNoMount(silent)
	self.Settings["AMBIENCE"]["NOTMOUNTED"] = not self.Settings["AMBIENCE"]["NOTMOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["AMBIENCE"]["NOTMOUNTED"] then
		C:Msg(L["SCAmbNoMountEnabled"])
	else
		C:Msg(L["SCAmbNoMountDisabled"])
	end
end

function SC:Restore()
	SetCVar("Sound_EnableAllSound", 1)
	SetCVar("Sound_EnableSFX", 1)
	SetCVar("Sound_EnableMusic", 1)
	SetCVar("Sound_EnableAmbience", 1)
end

function SC:VolumeCheck()
	if tonumber(GetCVar("Sound_MusicVolume")) <= 0 and self.Settings["MUSIC"]["MOD_VOLUME"] then
		SetCVar("Sound_MusicVolume", self.Settings["MUSIC"]["DEFAULT_VOLUME"])
	end
	if tonumber(GetCVar("Sound_SFXVolume")) <= 0 and self.Settings["SOUND"]["MOD_VOLUME"] then
		SetCVar("Sound_SFXVolume", self.Settings["SOUND"]["DEFAULT_VOLUME"])
	end
	if tonumber(GetCVar("Sound_AmbienceVolume")) <= 0 and self.Settings["AMBIENCE"]["MOD_VOLUME"] then
		SetCVar("Sound_AmbienceVolume", self.Settings["AMBIENCE"]["DEFAULT_VOLUME"])
	end
end

function SC:Check()
	if not self.Settings["ENABLED"] then return end
	if tonumber(GetCVar("Sound_EnableAllSound")) == 0 then
		SetCVar("Sound_EnableAllSound", 1)
	end
	if (C.Mounted and C.Running) or (not C.Mounted and not C.Running) then -- Player is currently dismounting or dismounted
		if self.Settings["DEFAULT"] then
			SetCVar("Sound_EnableMusic", 0)
			SetCVar("Sound_EnableSFX", 0)
			SetCVar("Sound_EnableAmbience", 0)
		else
			if self.Settings["MUSIC"]["ENABLED"] then
				SetCVar("Sound_EnableMusic", BoolToNum(self.Settings["MUSIC"]["NOTMOUNTED"]))
			end
			if self.Settings["SOUND"]["ENABLED"] then
				SetCVar("Sound_EnableSFX", BoolToNum(self.Settings["SOUND"]["NOTMOUNTED"]))
			end
			if self.Settings["AMBIENCE"]["ENABLED"] then
				SetCVar("Sound_EnableAmbience", BoolToNum(self.Settings["AMBIENCE"]["NOTMOUNTED"]))
			end
		end
	else -- Player is mounting or mounted
		if self.Settings["DEFAULT"] then
			SetCVar("Sound_EnableSFX", 0)
			SetCVar("Sound_EnableAmbience", 0)
			SetCVar("Sound_EnableMusic", 1)
			if tonumber(GetCVar("Sound_MusicVolume")) <= 0 then
				SetCVar("Sound_MusicVolume", 1.0)
			end
		else
			print("Enablding via CUSTOM SoundControl settings")
			if self.Settings["SOUND"]["ENABLED"] then
				SetCVar("Sound_EnableSFX", BoolToNum(self.Settings["SOUND"]["MOUNTED"]))
			end
			if self.Settings["AMBIENCE"]["ENABLED"] then
				SetCVar("Sound_EnableAmbience", BoolToNum(self.Settings["AMBIENCE"]["MOUNTED"]))
			end
			if self.Settings["MUSIC"]["ENABLED"] then
				SetCVar("Sound_EnableMusic", BoolToNum(self.Settings["MUSIC"]["MOUNTED"]))
			end
		end
	end
	if not self.Settings["DEFAULT"] then
		self:VolumeCheck()
	end
end
