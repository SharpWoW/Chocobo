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

function Chocobo.Options:OnLoad(panel)
	panel.name = "Chocobo"
	panel.refresh = function() Chocobo.Options:Update() end
	InterfaceOptions_AddCategory(panel)
	ChocoboOptions_SongsPanel_SongDesc:SetText(L["Options_SongPanelDesc"])
	ChocoboOptions_SongsPanel_AddSong:SetText(L["Options_Add"])
	ChocoboOptions_SongsPanel_RemoveSong:SetText(L["Options_Remove"])
	ChocoboOptions_SongsPanel_ResetSongs:SetText(L["Options_Reset"])
	ChocoboOptions_SongsPanel_ListSongs:SetText(L["Options_List"])
	ChocoboOptions_MountPanel_MountDesc:SetText(L["Options_MountPanelDesc"])
	ChocoboOptions_MountPanel_AddMount:SetText(L["Options_Add"])
	ChocoboOptions_MountPanel_RemoveMount:SetText(L["Options_Remove"])
	ChocoboOptions_MountPanel_ResetMounts:SetText(L["Options_Reset"])
	ChocoboOptions_MountPanel_ListMounts:SetText(L["Options_List"])
	ChocoboOptions_RavenLordToggleText:SetText(L["Options_RavenLordToggle"])
end

function Chocobo.Options:Update()
	local AddOnState, MountState, DebugState = ""
	local asColor = "FFFF00"
	local dColor = "FFFF00"
	if Chocobo.Global["ENABLED"] then
		AddOnState = L["Options_Enabled"]
		asColor = "00FF00"
	else
		AddOnState = L["Options_Disabled"]
		asColor = "FF0000"
	end
	if Chocobo.Global["ALLMOUNTS"] then MountState = L["Options_AllMounts"] else MountState = L["Options_Hawkstrider"] end
	if Chocobo.Global["DEBUG"] then
		DebugState = L["Options_Enabled"]
		dColor = "00FF00"
	else
		DebugState = L["Options_Disabled"]
		dColor = "FF0000"
	end
	ChocoboOptions_ToggleButton:SetText((L["Options_AddOnState"]):format(asColor, AddOnState))
	ChocoboOptions_ToggleMount:SetText(MountState)
	ChocoboOptions_ToggleDebug:SetText((L["Options_DebugState"]):format(dColor, DebugState))
	ChocoboOptions_DescriptionLabel:SetText((L["Options_Description"]):format(Chocobo:GetVersion()))
	ChocoboOptions_RavenLordToggle:SetChecked(Chocobo.Global["RAVENLORD"])
end

function Chocobo.Options:HorseHelp(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:SetText(L["Options_HorseHelp"])
	GameTooltip:Show()
end
