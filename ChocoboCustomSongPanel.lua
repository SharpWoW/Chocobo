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

Chocobo.CustomSongPanel = {}

local CSP = Chocobo.CustomSongPanel

function CSP:OnLoad(panel)
    panel.name = "Custom Songs"
    panel.parent = "Chocobo"
    panel.refresh = function() Chocobo.CustomSongPanel:Update() end
    InterfaceOptions_AddCategory(panel)
    ChocoboCustomSongPanel_DescriptionLabel:SetText(L["CustomSongPanel_Description"])
    ChocoboCustomSongPanel_CustomPanel_CustomDesc:SetText(L["CustomSongPanel_PanelDesc"])
    ChocoboCustomSongPanel_CustomPanel_AddButton:SetText(L["Options_Add"])
    ChocoboCustomSongPanel_CustomPanel_RemoveButton:SetText(L["Options_Remove"])
    ChocoboCustomSongPanel_CustomPanel_ListButton:SetText(L["Options_List"])
    self:Update()
end

function CSP:Update()
    ChocoboCustomSongPanel_CustomPanel_SongEditBox:SetText(L["CustomSongPanel_SongEditDefault"])
    ChocoboCustomSongPanel_CustomPanel_MountEditBox:SetText(L["CustomSongPanel_MountEditDefault"])
end
