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

local CO = Chocobo.Options

local frame = CreateFrame("Frame")
frame:Hide()

frame.logo = frame:CreateTexture(nil, "ARTWORK")
frame.logo:SetBlendMode("BLEND")
frame.logo:SetTexture([[Interface\AddOns\Chocobo\images\chocobo.tga]])
frame.logo:SetSize(256, 512)
frame.logo:SetPoint("BOTTOMRIGHT", 0, -75)

frame.description = CreateFrame("Frame", nil, frame)
frame.description:SetSize(370, 30)
frame.description:SetPoint("TOP", 0, -10)
frame.description.label = frame.description:CreateFontString(nil, "OVERLAY")
frame.description.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.description.label:SetPoint("TOPLEFT")
frame.description.label:SetPoint("BOTTOMRIGHT")
frame.description.label:SetTextColor(1, 0.8196079, 0)

frame.songsPanel = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
frame.songsPanel:SetSize(370, 95)
frame.songsPanel:SetPoint("TOP", 0, -50)
frame.songsPanel:SetBackdrop(_G.BACKDROP_TOOLTIP_16_16_5555)
frame.songsPanel:SetBackdropColor(0.2, 0.2, 0.2, 0.9)
frame.songsPanel:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
frame.songsPanel.song = CreateFrame("Frame", nil, frame.songsPanel)
frame.songsPanel.song:SetSize(360, 18)
frame.songsPanel.song:SetPoint("TOPLEFT", 5, -8)
frame.songsPanel.song.desc = frame.songsPanel.song:CreateFontString(nil, "OVERLAY")
frame.songsPanel.song.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.songsPanel.song.desc:SetPoint("TOPLEFT")
frame.songsPanel.song.desc:SetPoint("BOTTOMRIGHT")
frame.songsPanel.song.desc:SetTextColor(1, 0.8196079, 0)
frame.songsPanel.songEditBox = CreateFrame("EditBox", nil, frame.songsPanel, "InputBoxTemplate")
frame.songsPanel.songEditBox:EnableMouse(true)
frame.songsPanel.songEditBox:SetSize(150, 22)
frame.songsPanel.songEditBox:SetPoint("TOPLEFT", 110, -32)
frame.songsPanel.addSong = CreateFrame("Button", nil, frame.songsPanel, "OptionsButtonTemplate")
frame.songsPanel.addSong:SetSize(80, 22)
frame.songsPanel.addSong:SetPoint("TOPLEFT", 24, -60)
frame.songsPanel.addSong:SetScript("OnClick", function()
    local music = frame.songsPanel.songEditBox:GetText()
    Chocobo:AddMusic(music)
end)
frame.songsPanel.removeSong = CreateFrame("Button", nil, frame.songsPanel, "OptionsButtonTemplate")
frame.songsPanel.removeSong:SetSize(80, 22)
frame.songsPanel.removeSong:SetPoint("TOPLEFT", 105, -60)
frame.songsPanel.removeSong:SetScript("OnClick", function()
    local music = frame.songsPanel.songEditBox:GetText()
    Chocobo:RemoveMusic(music)
end)
frame.songsPanel.resetSongs = CreateFrame("Button", nil, frame.songsPanel, "OptionsButtonTemplate")
frame.songsPanel.resetSongs:SetSize(80, 22)
frame.songsPanel.resetSongs:SetPoint("TOPLEFT", 187, -60)
frame.songsPanel.resetSongs:SetScript("OnClick", function()
    Chocobo:ResetMusic()
end)
frame.songsPanel.listSongs = CreateFrame("Button", nil, frame.songsPanel, "OptionsButtonTemplate")
frame.songsPanel.listSongs:SetSize(80, 22)
frame.songsPanel.listSongs:SetPoint("TOPLEFT", 267, -60)
frame.songsPanel.listSongs:SetScript("OnClick", function()
    Chocobo:PrintMusic()
end)

frame.mountPanel = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
frame.mountPanel:SetSize(370, 95)
frame.mountPanel:SetPoint("TOP", 0, -145)
frame.mountPanel:SetBackdrop(_G.BACKDROP_TOOLTIP_16_16_5555)
frame.mountPanel:SetBackdropColor(0.2, 0.2, 0.2, 0.9)
frame.mountPanel:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
frame.mountPanel.mount = CreateFrame("Frame", nil, frame.mountPanel)
frame.mountPanel.mount:SetSize(360, 18)
frame.mountPanel.mount:SetPoint("TOPLEFT", 5, -8)
frame.mountPanel.mount.desc = frame.mountPanel.mount:CreateFontString(nil, "OVERLAY")
frame.mountPanel.mount.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.mountPanel.mount.desc:SetPoint("TOPLEFT")
frame.mountPanel.mount.desc:SetPoint("BOTTOMRIGHT")
frame.mountPanel.mount.desc:SetTextColor(1, 0.8196079, 0)
frame.mountPanel.mountEditBox = CreateFrame("EditBox", nil, frame.mountPanel, "InputBoxTemplate")
frame.mountPanel.mountEditBox:EnableMouse(true)
frame.mountPanel.mountEditBox:SetSize(150, 22)
frame.mountPanel.mountEditBox:SetPoint("TOPLEFT", 110, -32)
frame.mountPanel.addMount = CreateFrame("Button", nil, frame.mountPanel, "OptionsButtonTemplate")
frame.mountPanel.addMount:SetSize(80, 22)
frame.mountPanel.addMount:SetPoint("TOPLEFT", 24, -60)
frame.mountPanel.addMount:SetScript("OnClick", function()
    local mount = frame.mountPanel.mountEditBox:GetText()
    Chocobo:AddMount(mount)
end)
frame.mountPanel.removeMount = CreateFrame("Button", nil, frame.mountPanel, "OptionsButtonTemplate")
frame.mountPanel.removeMount:SetSize(80, 22)
frame.mountPanel.removeMount:SetPoint("TOPLEFT", 105, -60)
frame.mountPanel.removeMount:SetScript("OnClick", function()
    local mount = frame.mountPanel.mountEditBox:GetText()
    Chocobo:RemoveMount(mount)
end)
frame.mountPanel.resetMounts = CreateFrame("Button", nil, frame.mountPanel, "OptionsButtonTemplate")
frame.mountPanel.resetMounts:SetSize(80, 22)
frame.mountPanel.resetMounts:SetPoint("TOPLEFT", 187, -60)
frame.mountPanel.resetMounts:SetScript("OnClick", function()
    Chocobo:ResetMounts()
end)
frame.mountPanel.listMounts = CreateFrame("Button", nil, frame.mountPanel, "OptionsButtonTemplate")
frame.mountPanel.listMounts:SetSize(80, 22)
frame.mountPanel.listMounts:SetPoint("TOPLEFT", 267, -60)
frame.mountPanel.listMounts:SetScript("OnClick", function()
    Chocobo:PrintMounts()
end)

frame.toggleMount = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleMount:SetSize(240, 38)
frame.toggleMount:SetPoint("TOP", 0, -250)
frame.toggleMount:SetScript("OnClick", function()
    Chocobo:FilterMount(nil, true)
    CO:Update()
end)
frame.toggleDebug = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleDebug:SetSize(240, 38)
frame.toggleDebug:SetPoint("TOP", 0, -293)
frame.toggleDebug:SetScript("OnClick", function()
    Chocobo:ToggleDebug(true)
    CO:Update()
end)
frame.toggleButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleButton:SetSize(240, 38)
frame.toggleButton:SetPoint("TOP", 0, -336)
frame.toggleButton:SetScript("OnClick", function()
    Chocobo:Toggle(true)
    CO:Update()
end)

frame.preventDupeToggle = CreateFrame("CheckButton", "ChocoboOptionsPreventDupeToggle", frame, "OptionsCheckButtonTemplate")
frame.preventDupeToggle:SetSize(40, 40)
frame.preventDupeToggle:SetPoint("BOTTOMLEFT", 20, 160)
frame.preventDupeToggle:SetScript("OnClick", function()
    Chocobo:PreventDupeToggle(true)
    CO:Update()
end)
frame.preventDupeToggle.label = _G[frame.preventDupeToggle:GetName() .. "Text"]
frame.plainstriderToggle = CreateFrame("CheckButton", "ChocoboOptionsPlainstriderToggle", frame, "OptionsCheckButtonTemplate")
frame.plainstriderToggle:SetSize(40, 40)
frame.plainstriderToggle:SetPoint("BOTTOMLEFT", frame.preventDupeToggle, 0, -40)
frame.plainstriderToggle:SetScript("OnClick", function()
    Chocobo:PlainstriderToggle(true)
    CO:Update()
end)
frame.plainstriderToggle.label = _G[frame.plainstriderToggle:GetName() .. "Text"]
frame.ravenLordToggle = CreateFrame("CheckButton", "ChocoboOptionsRavenLordToggle", frame, "OptionsCheckButtonTemplate")
frame.ravenLordToggle:SetSize(40, 40)
frame.ravenLordToggle:SetPoint("BOTTOMLEFT", frame.plainstriderToggle, 0, -40)
frame.ravenLordToggle:SetScript("OnClick", function()
    Chocobo:RavenLordToggle(true)
    CO:Update()
end)
frame.ravenLordToggle.label = _G[frame.ravenLordToggle:GetName() .. "Text"]
frame.flametalonToggle = CreateFrame("CheckButton", "ChocoboOptionsFlametalonToggle", frame, "OptionsCheckButtonTemplate")
frame.flametalonToggle:SetSize(40, 40)
frame.flametalonToggle:SetPoint("BOTTOMLEFT", frame.ravenLordToggle, 0, -40)
frame.flametalonToggle:SetScript("OnClick", function()
    Chocobo:FlametalonToggle(true)
    CO:Update()
end)
frame.flametalonToggle.label = _G[frame.flametalonToggle:GetName() .. "Text"]
frame.ridingCraneToggle = CreateFrame("CheckButton", "ChocoboOptionsRidingCraneToggle", frame, "OptionsCheckButtonTemplate")
frame.ridingCraneToggle:SetSize(40, 40)
frame.ridingCraneToggle:SetPoint("BOTTOMLEFT", frame.flametalonToggle, 0, -40)
frame.ridingCraneToggle:SetScript("OnClick", function()
    Chocobo:RidingCraneToggle(true)
    CO:Update()
end)
frame.ridingCraneToggle.label = _G[frame.ridingCraneToggle:GetName() .. "Text"]

function CO:Open()
    InterfaceOptions_OpenToCategory(frame)
end

function CO:OnLoad(panel)
    panel.name = "Chocobo"
    panel.refresh = function() CO:Update() end
    InterfaceOptions_AddCategory(panel)
    frame.songsPanel.song.desc:SetText(L["Options_SongPanelDesc"])
    frame.songsPanel.addSong:SetText(L["Options_Add"])
    frame.songsPanel.removeSong:SetText(L["Options_Remove"])
    frame.songsPanel.resetSongs:SetText(L["Options_Reset"])
    frame.songsPanel.listSongs:SetText(L["Options_List"])
    frame.mountPanel.mount.desc:SetText(L["Options_MountPanelDesc"])
    frame.mountPanel.addMount:SetText(L["Options_Add"])
    frame.mountPanel.removeMount:SetText(L["Options_Remove"])
    frame.mountPanel.resetMounts:SetText(L["Options_Reset"])
    frame.mountPanel.listMounts:SetText(L["Options_List"])
    frame.preventDupeToggle.label:SetText(L["Options_PreventDupeToggle"])
    frame.plainstriderToggle.label:SetText(L["Options_PlainstriderToggle"])
    frame.ridingCraneToggle.label:SetText(L["Options_RidingCraneToggle"])
    frame.ravenLordToggle.label:SetText(L["Options_RavenLordToggle"])
    frame.flametalonToggle.label:SetText(L["Options_FlametalonToggle"])
end

function CO:Update()
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
    frame.toggleButton:SetText((L["Options_AddOnState"]):format(asColor, AddOnState))
    frame.toggleMount:SetText(MountState)
    frame.toggleDebug:SetText((L["Options_DebugState"]):format(dColor, DebugState))
    frame.description.label:SetText((L["Options_Description"]):format(Chocobo:GetVersion()))
    frame.preventDupeToggle:SetChecked(Chocobo.Global["PREVENTDUPE"])
    frame.plainstriderToggle:SetChecked(Chocobo.Global["PLAINSTRIDER"])
    frame.ridingCraneToggle:SetChecked(Chocobo.Global["RIDINGCRANE"])
    frame.ravenLordToggle:SetChecked(Chocobo.Global["RAVENLORD"])
    frame.flametalonToggle:SetChecked(Chocobo.Global["FLAMETALON"])
end

frame:SetScript("OnLoad", function(self) CO:OnLoad(self) end)
frame:SetScript("OnShow", function() CO:Update() end)
