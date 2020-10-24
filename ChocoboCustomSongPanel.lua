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

local frame = CreateFrame("Frame")
frame:Hide()

frame.description = CreateFrame("Frame", nil, frame)
frame.description:SetSize(600, 25)
frame.description:SetPoint("TOP", 0, -10)
frame.description.label = frame.description:CreateFontString(nil, "OVERLAY", nil)
frame.description.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.description.label:SetText("%CUSTOMSONG_DESCRIPTION%")
frame.description.label:SetPoint("TOPLEFT")
frame.description.label:SetPoint("BOTTOMRIGHT")
frame.description.label:SetTextColor(1, 0.8196079, 0)

frame.customPanel = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
frame.customPanel:SetSize(370, 120)
frame.customPanel:SetPoint("TOP", 0, -50)
frame.customPanel:SetBackdrop(_G.BACKDROP_TOOLTIP_16_16_5555)
frame.customPanel:SetBackdropColor(0.2, 0.2, 0.2, 0.9)
frame.customPanel:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
frame.customPanel.custom = CreateFrame("Frame", nil, frame.customPanel)
frame.customPanel.custom:SetSize(360, 18)
frame.customPanel.custom:SetPoint("TOPLEFT", 5, -8)
frame.customPanel.custom.desc = frame.customPanel.custom:CreateFontString(nil, "OVERLAY", nil)
frame.customPanel.custom.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.customPanel.custom.desc:SetPoint("TOPLEFT")
frame.customPanel.custom.desc:SetPoint("BOTTOMRIGHT")
frame.customPanel.custom.desc:SetTextColor(1, 0.8196079, 0)
frame.customPanel.custom.songEditBox = CreateFrame("EditBox", nil, frame.customPanel.custom, "InputBoxTemplate")
frame.customPanel.custom.songEditBox:SetMaxLetters(100)
frame.customPanel.custom.songEditBox:EnableMouse(true)
frame.customPanel.custom.songEditBox:SetSize(150, 22)
frame.customPanel.custom.songEditBox:SetPoint("TOPLEFT", 110, -32)
frame.customPanel.custom.mountEditBox = CreateFrame("EditBox", nil, frame.customPanel.custom, "InputBoxTemplate")
frame.customPanel.custom.mountEditBox:SetMaxLetters(100)
frame.customPanel.custom.mountEditBox:EnableMouse(true)
frame.customPanel.custom.mountEditBox:SetSize(150, 22)
frame.customPanel.custom.mountEditBox:SetPoint("TOPLEFT", 110, -56)
frame.customPanel.custom.addButton = CreateFrame("Button", nil, frame.customPanel.custom, "OptionsButtonTemplate")
frame.customPanel.custom.addButton:SetSize(80, 22)
frame.customPanel.custom.addButton:SetPoint("TOPLEFT", 64, -81)
frame.customPanel.custom.addButton:SetScript("OnClick", function()
    local music = frame.customPanel.custom.songEditBox:GetText()
    local mount = frame.customPanel.custom.mountEditBox:GetText()
    Chocobo:AddCustomMusic(music, mount)
end)
frame.customPanel.custom.removeButton = CreateFrame("Button", nil, frame.customPanel.custom, "OptionsButtonTemplate")
frame.customPanel.custom.removeButton:SetSize(80, 22)
frame.customPanel.custom.removeButton:SetPoint("TOPLEFT", 145, -81)
frame.customPanel.custom.removeButton:SetScript("OnClick", function()
    local mount = frame.customPanel.custom.mountEditBox:GetText()
    Chocobo:RemoveCustomMusic(mount)
end)
frame.customPanel.custom.listButton = CreateFrame("Button", nil, frame.customPanel.custom, "OptionsButtonTemplate")
frame.customPanel.custom.listButton:SetSize(80, 22)
frame.customPanel.custom.listButton:SetPoint("TOPLEFT", 227, -81)
frame.customPanel.custom.listButton:SetScript("OnClick", function()
    Chocobo:PrintMusic()
end)

function CSP:OnLoad(panel)
    panel.name = "Custom Songs"
    panel.parent = "Chocobo"
    panel.refresh = function() CSP:Update() end
    InterfaceOptions_AddCategory(panel)
    frame.description.label:SetText(L["CustomSongPanel_Description"])
    frame.customPanel.custom.desc:SetText(L["CustomSongPanel_PanelDesc"])
    frame.customPanel.custom.addButton:SetText(L["Options_Add"])
    frame.customPanel.custom.removeButton:SetText(L["Options_Remove"])
    frame.customPanel.custom.listButton:SetText(L["Options_List"])
    self:Update()
end

function CSP:Update()
    frame.customPanel.custom.songEditBox:SetText(L["CustomSongPanel_SongEditDefault"])
    frame.customPanel.custom.mountEditBox:SetText(L["CustomSongPanel_MountEditDefault"])
end

frame:SetScript("OnLoad", function(self) CSP:OnLoad(self) end)
frame:SetScript("OnShow", function() CSP:Update() end)
