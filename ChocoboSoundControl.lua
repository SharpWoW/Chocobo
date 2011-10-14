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
	Version = 1,
	Settings = {}
}

local SC = C.SoundControl

local L = _G["ChocoboLocale"]

function SC:Init()
	if type(C.Global["SOUNDCONTROL"]) ~= "table" then
		C:Msg(L["SoundControlNotSet"])
		self:SetupVars()
	end
	
	self.Settings = C.Global["SOUNDCONTROL"]
	
	if (self.Settings["VERSION"] or 0) < self.Version then
		C:ErrorMsg(L["SCVarsOutOfDate"])
		self:SetupVars(true) -- Reset vars, preserving any user-made settings
	end
	
	self:Check()
end

function SC:SetupVars(reset)
	local e,d,se,sm,sn,sv,smv,me,mm,mn,mv,mmv,ae,am,an,av,amv=false,true,true,false,false,1.0,false,true,true,false,1.0,true,true,false,false,1.0,false
	if reset then
		e = self.Settings["ENABLED"] or false
		d = self.Settings["DEFAULT"] or true
		local sfx = "SFX"
		local vol = "VOLUME"
		if type(self.Settings["VERSION"]) == "nil" then
			sfx = "SOUND"
			vol = "DEFAULT_VOLUME"
		end
		se = self.Settings[sfx]["ENABLED"] or true
		sm = self.Settings[sfx]["MOUNTED"] or false
		sn = self.Settings[sfx]["NOTMOUNTED"] or false
		sv = self.Settings[sfx][vol] or 1.0
		smv = self.Settings[sfx]["MOD_VOLUME"] or false
		me = self.Settings["MUSIC"]["ENABLED"] or true
		mm = self.Settings["MUSIC"]["MOUNTED"] or true
		mn = self.Settings["MUSIC"]["NOTMOUNTED"] or false
		mv = self.Settings["MUSIC"][vol] or 1.0
		mmv = self.Settings["MUSIC"]["MOD_VOLUME"] or true
		ae = self.Settings["AMBIENCE"]["ENABLED"] or true
		am = self.Settings["AMBIENCE"]["MOUNTED"] or false
		an = self.Settings["AMBIENCE"]["NOTMOUNTED"] or false
		av = self.Settings["AMBIENCE"][vol] or 1.0
		amv = self.Settings["AMBIENCE"]["MOD_VOLUME"] or false
	end
	C.Global["SOUNDCONTROL"] = {
		["VERSION"] = self.Version,
		["ENABLED"] = e, -- Enable sound control at all?
		["DEFAULT"] = d, -- Use the old style sound control?
		["SFX"] = {
			["ENABLED"] = se, -- Should AddOn control SFX playback?
			["MOUNTED"] = sm, -- SFX when mounted?
			["NOTMOUNTED"] = sn, -- SFX when not mounted?
			["VOLUME"] = sv, -- Volume to modify to if volume <= 0
			["MOD_VOLUME"] = smv -- Whether or not to modify volume
		},
		["MUSIC"] = {
			["ENABLED"] = me, -- Should AddOn control music playback?
			["MOUNTED"] = mm, -- Music when mounted?
			["NOTMOUNTED"] = mn, -- Music when not mounted?
			["VOLUME"] = mv, -- Volume to modify to if volume <= 0
			["MOD_VOLUME"] = mmv -- Whether or not to modify volume
		},
		["AMBIENCE"] = {
			["ENABLED"] = ae, -- Should AddOn control ambience playback?
			["MOUNTED"] = am, -- Ambience when mounted?
			["NOTMOUNTED"] = an, -- Ambience when not mounted?
			["VOLUME"] = av, -- Volume to modify to if volume <= 0
			["MOD_VOLUME"] = amv -- Whether or not to modify volume
		}
	}
	self.Settings = C.Global["SOUNDCONTROL"]
	if reset then C:Msg(L["SoundControlReset"]) end
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

function SC:ToggleMusicVolume(silent)
	self.Settings["MUSIC"]["MOD_VOLUME"] = not self.Settings["MUSIC"]["MOD_VOLUME"]
	self:VolumeCheck()
	if silent then return end
	if self.Settings["MUSIC"]["MOD_VOLUME"] then
		C:Msg(L["SCMusicVolumeEnabled"])
	else
		C:Msg(L["SCMusicVolumeDisabled"])
	end
end

function SC:ToggleSFX(silent)
	self.Settings["SFX"]["ENABLED"] = not self.Settings["SFX"]["ENABLED"]
	self:Check()
	if silent then return end
	if self.Settings["SFX"]["ENABLED"] then
		C:Msg(L["SCSFXEnabled"])
	else
		C:Msg(L["SCSFXDisabled"])
	end
end

function SC:ToggleSFXMount(silent)
	self.Settings["SFX"]["MOUNTED"] = not self.Settings["SFX"]["MOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["SFX"]["MOUNTED"] then
		C:Msg(L["SCSFXMountEnabled"])
	else
		C:Msg(L["SCSFXMountDisabled"])
	end
end

function SC:ToggleSFXNoMount(silent)
	self.Settings["SFX"]["NOTMOUNTED"] = not self.Settings["SFX"]["NOTMOUNTED"]
	self:Check()
	if silent then return end
	if self.Settings["SFX"]["NOTMOUNTED"] then
		C:Msg(L["SCSFXNoMountEnabled"])
	else
		C:Msg(L["SCSFXNoMountDisabled"])
	end
end

function SC:ToggleSFXVolume(silent)
	self.Settings["SFX"]["MOD_VOLUME"] = not self.Settings["SFX"]["MOD_VOLUME"]
	self:VolumeCheck()
	if silent then return end
	if self.Settings["SFX"]["MOD_VOLUME"] then
		C:Msg(L["SCSFXVolumeEnabled"])
	else
		C:Msg(L["SCSFXVolumeDisabled"])
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

function SC:ToggleAmbienceVolume(silent)
	self.Settings["AMBIENCE"]["MOD_VOLUME"] = not self.Settings["AMBIENCE"]["MOD_VOLUME"]
	self:VolumeCheck()
	if silent then return end
	if self.Settings["AMBIENCE"]["MOD_VOLUME"] then
		C:Msg(L["SCAmbVolumeEnabled"])
	else
		C:Msg(L["SCAmbVolumeDisabled"])
	end
end

function SC:ValidateVolume(volume)
	if volume < 0 or volume > 100 then
		C:ErrorMsg(L["SCVolumeOutOfRange"])
		return false
	end
	return true
end

function SC:SetMusicVolume(volume, silent)
	if self.Settings["DEFAULT"] then
		if not silent then C:ErrorMsg(L["SCVolumeNotAllowed"]) end
		return
	end
	if self:ValidateVolume(volume) then
		local vol = volume / 100
		self.Settings["MUSIC"]["VOLUME"] = vol
		self:VolumeCheck()
		if not silent then C:Msg((L["SCNewMusicVolume"]):format(volume)) end
	end
end

function SC:SetSFXVolume(volume, silent)
	if self.Settings["DEFAULT"] then
		if not silent then C:ErrorMsg(L["SCVolumeNotAllowed"]) end
		return
	end
	if self:ValidateVolume(volume) then
		local vol = volume / 100
		self.Settings["SFX"]["VOLUME"] = vol
		self:VolumeCheck()
		if not silent then C:Msg((L["SCNewSFXVolume"]):format(volume)) end
	end
end

function SC:SetAmbienceVolume(volume, silent)
	if self.Settings["DEFAULT"] then
		if not silent then C:ErrorMsg(L["SCVolumeNotAllowed"]) end
		return
	end
	if self:ValidateVolume(volume) then
		local vol = volume / 100
		self.Settings["AMBIENCE"]["VOLUME"] = vol
		self:VolumeCheck()
		if not silent then C:Msg((L["SCNewAmbVolume"]):format(volume)) end
	end
end

function SC:PrintMusicVolume()
	C:Msg((L["SCMusicVolume"]):format(self.Settings["MUSIC"]["VOLUME"] * 100))
end

function SC:PrintSFXVolume()
	C:Msg((L["SCSFXVolume"]):format(self.Settings["SFX"]["VOLUME"] * 100))
end

function SC:PrintAmbienceVolume()
	C:Msg((L["SCAmbienceVolume"]):format(self.Settings["AMBIENCE"]["VOLUME"] * 100))
end

function SC:Restore()
	SetCVar("Sound_EnableAllSound", 1)
	SetCVar("Sound_EnableSFX", 1)
	SetCVar("Sound_EnableMusic", 1)
	SetCVar("Sound_EnableAmbience", 1)
end

function SC:VolumeCheck()
	if not self.Settings["ENABLED"] then return end
	if self.Settings["DEFAULT"] then return end
	if self.Settings["MUSIC"]["MOD_VOLUME"] then
		SetCVar("Sound_MusicVolume", self.Settings["MUSIC"]["VOLUME"])
	end
	if self.Settings["SFX"]["MOD_VOLUME"] then
		SetCVar("Sound_SFXVolume", self.Settings["SFX"]["VOLUME"])
	end
	if self.Settings["AMBIENCE"]["MOD_VOLUME"] then
		SetCVar("Sound_AmbienceVolume", self.Settings["AMBIENCE"]["VOLUME"])
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
			if self.Settings["SFX"]["ENABLED"] then
				SetCVar("Sound_EnableSFX", BoolToNum(self.Settings["SFX"]["NOTMOUNTED"]))
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
			if self.Settings["MUSIC"]["ENABLED"] then
				SetCVar("Sound_EnableMusic", BoolToNum(self.Settings["MUSIC"]["MOUNTED"]))
			end
			if self.Settings["SFX"]["ENABLED"] then
				SetCVar("Sound_EnableSFX", BoolToNum(self.Settings["SFX"]["MOUNTED"]))
			end
			if self.Settings["AMBIENCE"]["ENABLED"] then
				SetCVar("Sound_EnableAmbience", BoolToNum(self.Settings["AMBIENCE"]["MOUNTED"]))
			end
		end
	end
	if not self.Settings["DEFAULT"] then
		self:VolumeCheck()
	end
end
