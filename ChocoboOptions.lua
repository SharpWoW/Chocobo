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

local L = _G["ChocoboLocale"]

Chocobo.Options = {}

function Chocobo.Options:OnLoad()
	ChocoboOptionsFrame_TitleString:SetText(L["Options_Title"])
	ChocoboOptionsFrame_SongsPanel_SongDesc:SetText(L["Options_SongPanelDesc"])
	ChocoboOptionsFrame_SongsPanel_AddSong:SetText(L["Options_Add"])
	ChocoboOptionsFrame_SongsPanel_RemoveSong:SetText(L["Options_Remove"])
	ChocoboOptionsFrame_SongsPanel_ResetSongs:SetText(L["Options_Reset"])
	ChocoboOptionsFrame_SongsPanel_ListSongs:SetText(L["Options_List"])
	ChocoboOptionsFrame_MountPanel_MountDesc:SetText(L["Options_MountPanelDesc"])
	ChocoboOptionsFrame_MountPanel_AddMount:SetText(L["Options_Add"])
	ChocoboOptionsFrame_MountPanel_RemoveMount:SetText(L["Options_Remove"])
	ChocoboOptionsFrame_MountPanel_ResetMounts:SetText(L["Options_Reset"])
	ChocoboOptionsFrame_MountPanel_ListMounts:SetText(L["Options_List"])
	ChocoboOptionsFrame_OpenSoundControl:SetText(L["Options_OpenSoundControlButton"])
	ChocoboOptionsFrame_RavenLordToggleText:SetText(L["Options_RavenLordToggle"])
	self:Update()
end

function Chocobo.Options:Update()
	local AddOnState, MountState, DebugState = ""
	local RavenLordState = Chocobo:GetGlobal("RAVENLORD")
	local asColor = "FFFF00"
	local dColor = "FFFF00"
	if Chocobo:GetGlobal("ENABLED") then
		AddOnState = L["Options_Enabled"]
		asColor = "00FF00"
	else
		AddOnState = L["Options_Disabled"]
		asColor = "FF0000"
	end
	if Chocobo:GetGlobal("ALLMOUNTS") then MountState = L["Options_AllMounts"] else MountState = L["Options_Hawkstrider"] end
	if Chocobo:GetGlobal("DEBUG") then
		DebugState = L["Options_Enabled"]
		dColor = "00FF00"
	else
		DebugState = L["Options_Disabled"]
		dColor = "FF0000"
	end
	ChocoboOptionsFrame_ToggleButton:SetText((L["Options_AddOnState"]):format(asColor, AddOnState))
	ChocoboOptionsFrame_ToggleMount:SetText(MountState)
	ChocoboOptionsFrame_ToggleDebug:SetText((L["Options_DebugState"]):format(dColor, DebugState))
	ChocoboOptionsFrame_DescriptionLabel:SetText((L["Options_Description"]):format(Chocobo:GetVersion()))
	ChocoboOptionsFrame_RavenLordToggle:SetChecked(RavenLordState)
end
