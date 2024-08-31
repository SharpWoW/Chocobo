--[[
    Copyright (c) 2010-2020 by Adam Hellberg

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

Chocobo.SoundControl.Options = {}

local sliderTemplate = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and "UISliderTemplate" or "UISliderTemplateWithLabels"

local function checkbox(name, parent, label, handler)
    local f = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate")
    f:SetSize(40, 40)
    f.label = _G[f:GetName() .. "Text"]
    f.label:SetText(label)
    f:SetScript("OnClick", function(s)
        if (s:GetChecked()) then
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
        else
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
        end
        handler()
    end)

    return f
end

local function slider(name, parent)
    local f = CreateFrame("Slider", name, parent, sliderTemplate)
    f:SetSize(144, 17)
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        f.label = f:CreateFontString(name .. "Text_workaround", "OVERLAY")
        f.label:SetFont([[Fonts\FRIZQT__.TTF]], 10, "OUTLINE")
        f.label:SetPoint("BOTTOM", f, "TOP")

        f.low = f:CreateFontString(name .. "Low_workaround", "OVERLAY")
        f.low:SetFont([[Fonts\FRIZQT__.TTF]], 10, "OUTLINE")
        f.low:SetPoint("TOPLEFT", f, "BOTTOMLEFT", -4, 3)

        f.high = f:CreateFontString(name .. "High_workaround", "OVERLAY")
        f.high:SetFont([[Fonts\FRIZQT__.TTF]], 10, "OUTLINE")
        f.high:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 4, 3)
    else
        f.label = _G[f:GetName() .. "Text"]
        f.high = _G[f:GetName() .. "High"]
        f.low = _G[f:GetName() .. "Low"]
    end
    f.current = f:CreateFontString(name .. "Current", "OVERLAY")
    f.current:SetFont([[Fonts\FRIZQT__.TTF]], 10, "OUTLINE")
    f.current:SetPoint("TOP", 0, -16)

    return f
end

local CSCO = Chocobo.SoundControl.Options

local frame = CreateFrame("Frame")
CSCO.Frame = frame
frame:Hide()
frame.name = "Sound Control"
frame.parent = "Chocobo"
frame.refresh = function() CSCO:Update() end

frame.logo = frame:CreateTexture(nil, "ARTWORK")
frame.logo:SetTexture([[Interface\AddOns\Chocobo\images\chocobo_small.tga]])
frame.logo:SetBlendMode("BLEND")
frame.logo:SetSize(128, 128)
frame.logo:SetPoint("BOTTOMRIGHT", -220, 5)
frame.caption = CreateFrame("Frame", nil, frame)
frame.caption:SetSize(600, 25)
frame.caption:SetPoint("TOP", 0, -5)
frame.caption.label = frame.caption:CreateFontString(nil, "OVERLAY")
frame.caption.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.caption.label:SetPoint("TOPLEFT")
frame.caption.label:SetPoint("BOTTOMRIGHT")
frame.caption.label:SetTextColor(1, 0.8196079, 0)
frame.caption.label:SetText(L["SoundControl_Caption"])
frame.description = CreateFrame("Frame", nil, frame)
frame.description:SetSize(600, 25)
frame.description:SetPoint("TOP", 0, -30)
frame.description.label = frame.description:CreateFontString(nil, "OVERLAY")
frame.description.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.description.label:SetPoint("TOPLEFT")
frame.description.label:SetPoint("BOTTOMRIGHT")
frame.description.label:SetTextColor(1, 1, 1)
frame.description.label:SetText(L["SoundControl_Description"])

frame.toggle = checkbox("ChocoboSoundControlOptionsToggle", frame, L["SoundControl_Toggle"], function()
    Chocobo.SoundControl:Toggle(true)
    CSCO:Update()
end)
frame.toggle:SetPoint("TOPLEFT", 10, -85)
frame.toggle.label:SetTextColor(1, 1, 1)

frame.toggleDefault = checkbox(
    "ChocoboSoundControlOptionsToggleDefault", frame, L["SoundControl_ToggleDefault"],
    function()
        Chocobo.SoundControl:ToggleDefault(true)
        CSCO:Update()
    end)
frame.toggleDefault:SetPoint("TOPLEFT", 10, -125)

frame.defaultHelp = CreateFrame("Frame", nil, frame)
frame.defaultHelp:SetSize(400, 50)
frame.defaultHelp:SetPoint("TOPRIGHT", -10, -90)
frame.defaultHelp.label = frame.defaultHelp:CreateFontString(nil, "OVERLAY")
frame.defaultHelp.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.defaultHelp.label:SetPoint("TOPLEFT")
frame.defaultHelp.label:SetPoint("BOTTOMRIGHT")
frame.defaultHelp.label:SetTextColor(1, 1, 1)
frame.defaultHelp.label:SetText(L["SoundControl_DefaultHelp"])

frame.defaultNote = CreateFrame("Frame", nil, frame)
frame.defaultNote:SetSize(400, 40)
frame.defaultNote:SetPoint("TOPRIGHT", -10, -130)
frame.defaultNote.label = frame.defaultNote:CreateFontString(nil, "OVERLAY")
frame.defaultNote.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.defaultNote.label:SetPoint("TOPLEFT")
frame.defaultNote.label:SetPoint("BOTTOMRIGHT")
frame.defaultNote.label:SetText(L["SoundControl_DefaultNote"])

local panelTabButtonTemplate = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and "PanelTabButtonTemplate"
    or "CharacterFrameTabButtonTemplate"

local bd = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    edgeSize = 16,
    tileSize = 32,
    insets = {
        left = 2.5,
        right = 2.5,
        top = 2.5,
        bottom = 2.5
    }
}
frame.panelContainer = CreateFrame(
    "Frame",
    "ChocoboSoundControlOptionsPanelContainer",
    frame,
    BackdropTemplateMixin and "BackdropTemplate")
frame.panelContainer:SetSize(500, 240)
frame.panelContainer:SetPoint("TOP", 0, -200)
frame.panelContainer:SetBackdrop(bd)
frame.panelContainer.tab1 = CreateFrame(
    "Button",
    "ChocoboSoundControlOptionsPanelContainerTab1",
    frame.panelContainer,
    panelTabButtonTemplate)
frame.panelContainer.tab1:SetPoint("LEFT", frame.panelContainer, "BOTTOMLEFT", 5, -12)
frame.panelContainer.tab1:SetText(L["SoundControl_Music"])
frame.panelContainer.tab1:SetScript("OnClick", function()
    PanelTemplates_SetTab(frame.panelContainer, 1)
    frame.panelContainer.page1:Show()
    frame.panelContainer.page2:Hide()
    frame.panelContainer.page3:Hide()
end)
frame.panelContainer.tab2 = CreateFrame(
    "Button",
    "ChocoboSoundControlOptionsPanelContainerTab2",
    frame.panelContainer,
    panelTabButtonTemplate)
frame.panelContainer.tab2:SetPoint("LEFT", frame.panelContainer.tab1, "RIGHT", -10, 0)
frame.panelContainer.tab2:SetText(L["SoundControl_SFX"])
frame.panelContainer.tab2:SetScript("OnClick", function()
    PanelTemplates_SetTab(frame.panelContainer, 2)
    frame.panelContainer.page1:Hide()
    frame.panelContainer.page2:Show()
    frame.panelContainer.page3:Hide()
end)
frame.panelContainer.tab3 = CreateFrame(
    "Button",
    "ChocoboSoundControlOptionsPanelContainerTab3",
    frame.panelContainer,
    panelTabButtonTemplate)
frame.panelContainer.tab3:SetPoint("LEFT", frame.panelContainer.tab2, "RIGHT", -10, 0)
frame.panelContainer.tab3:SetText(L["SoundControl_Ambience"])
frame.panelContainer.tab3:SetScript("OnClick", function()
    PanelTemplates_SetTab(frame.panelContainer, 3)
    frame.panelContainer.page1:Hide()
    frame.panelContainer.page2:Hide()
    frame.panelContainer.page3:Show()
end)

frame.panelContainer.page1 = CreateFrame("Frame", "ChocoboSoundControlOptionsPanelContainerPage1", frame.panelContainer)
frame.panelContainer.page1:SetPoint("TOPLEFT")
frame.panelContainer.page1:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page1:Show()
frame.panelContainer.page1.panel = CreateFrame("Frame", nil, frame.panelContainer.page1)
frame.panelContainer.page1.panel:SetSize(360, 20)
frame.panelContainer.page1.panel:SetPoint("TOP", 0, -10)
frame.panelContainer.page1.panel.desc = frame.panelContainer.page1.panel:CreateFontString(nil, "OVERLAY")
frame.panelContainer.page1.panel.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.panelContainer.page1.panel.desc:SetPoint("TOPLEFT")
frame.panelContainer.page1.panel.desc:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page1.panel.desc:SetText(L["SoundControl_MusicDesc"])
frame.panelContainer.page1.enable = checkbox(
    "ChocoboSoundControlOptionsPage1Enable", frame.panelContainer.page1, L["SoundControl_MusicEnable"],
    function()
        Chocobo.SoundControl:ToggleMusic(true)
        CSCO:Update()
    end)
frame.panelContainer.page1.enable:SetPoint("TOPLEFT", 10, -25)
frame.panelContainer.page1.enableMount = checkbox(
    "ChocoboSoundControlOptionsPage1EnableMount",
    frame.panelContainer.page1,
    L["SoundControl_MusicMount"],
    function()
        Chocobo.SoundControl:ToggleMusicMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page1.enableMount:SetPoint("TOPLEFT", 10, -65)
frame.panelContainer.page1.enableNoMount = checkbox(
    "ChocoboSoundControlOptionsPage1EnableNoMount",
    frame.panelContainer.page1,
    L["SoundControl_MusicNoMount"],
    function()
        Chocobo.SoundControl:ToggleMusicNoMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page1.enableNoMount:SetPoint("TOPLEFT", 10, -105)
frame.panelContainer.page1.enableVolume = checkbox(
    "ChocoboSoundControlOptionsPage1EnableVolume",
    frame.panelContainer.page1,
    L["SoundControl_MusicVolume"],
    function()
        Chocobo.SoundControl:ToggleMusicVolume(true)
        CSCO:Update()
    end)
frame.panelContainer.page1.enableVolume:SetPoint("TOPLEFT", 10, -145)
frame.panelContainer.page1.volumeSlider = slider(
    "ChocoboSoundControlOptionsPage1VolumeSlider",
    frame.panelContainer.page1)
frame.panelContainer.page1.volumeSlider:SetSize(450, 16)
frame.panelContainer.page1.volumeSlider:SetPoint("TOP", 0, -195)
frame.panelContainer.page1.volumeSlider:SetMinMaxValues(0, 100)
frame.panelContainer.page1.volumeSlider:SetValueStep(1)
frame.panelContainer.page1.volumeSlider.label:SetText(L["SoundControl_MusicSetVolume"])
frame.panelContainer.page1.volumeSlider.high:SetText("100")
frame.panelContainer.page1.volumeSlider.low:SetText("0")
frame.panelContainer.page1.volumeSlider:SetScript("OnValueChanged", function(self)
    Chocobo.SoundControl:SetMusicVolume(self:GetValue(), true)
    CSCO:Update()
end)
frame.panelContainer.page1.volumeSlider:SetScript("OnMouseWheel", function(self, delta)
    CSCO:VolumeScroll(self, delta, 1)
end)

frame.panelContainer.page2 = CreateFrame("Frame", "ChocoboSoundControlOptionsPanelContainerPage2", frame.panelContainer)
frame.panelContainer.page2:SetPoint("TOPLEFT")
frame.panelContainer.page2:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page2:Hide()
frame.panelContainer.page2.panel = CreateFrame("Frame", nil, frame.panelContainer.page2)
frame.panelContainer.page2.panel:SetSize(360, 20)
frame.panelContainer.page2.panel:SetPoint("TOP", 0, -10)
frame.panelContainer.page2.panel.desc = frame.panelContainer.page2.panel:CreateFontString(nil, "OVERLAY")
frame.panelContainer.page2.panel.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.panelContainer.page2.panel.desc:SetPoint("TOPLEFT")
frame.panelContainer.page2.panel.desc:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page2.panel.desc:SetText(L["SoundControl_SFXDesc"])
frame.panelContainer.page2.enable = checkbox(
    "ChocoboSoundControlOptionsPage2Enable", frame.panelContainer.page2, L["SoundControl_SFXEnable"],
    function()
        Chocobo.SoundControl:ToggleSFX(true)
        CSCO:Update()
    end)
frame.panelContainer.page2.enable:SetPoint("TOPLEFT", 10, -25)
frame.panelContainer.page2.enableMount = checkbox(
    "ChocoboSoundControlOptionsPage2EnableMount",
    frame.panelContainer.page2,
    L["SoundControl_SFXMount"],
    function()
        Chocobo.SoundControl:ToggleSFXMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page2.enableMount:SetPoint("TOPLEFT", 10, -65)
frame.panelContainer.page2.enableNoMount = checkbox(
    "ChocoboSoundControlOptionsPage2EnableNoMount",
    frame.panelContainer.page2,
    L["SoundControl_SFXNoMount"],
    function()
        Chocobo.SoundControl:ToggleSFXNoMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page2.enableNoMount:SetPoint("TOPLEFT", 10, -105)
frame.panelContainer.page2.enableVolume = checkbox(
    "ChocoboSoundControlOptionsPage2EnableVolume",
    frame.panelContainer.page2,
    L["SoundControl_SFXVolume"],
    function()
        Chocobo.SoundControl:ToggleSFXVolume(true)
        CSCO:Update()
    end)
frame.panelContainer.page2.enableVolume:SetPoint("TOPLEFT", 10, -145)
frame.panelContainer.page2.volumeSlider = slider(
    "ChocoboSoundControlOptionsPage2VolumeSlider",
    frame.panelContainer.page2)
frame.panelContainer.page2.volumeSlider:SetSize(450, 16)
frame.panelContainer.page2.volumeSlider:SetPoint("TOP", 0, -195)
frame.panelContainer.page2.volumeSlider:SetMinMaxValues(0, 100)
frame.panelContainer.page2.volumeSlider:SetValueStep(1)
frame.panelContainer.page2.volumeSlider.label:SetText(L["SoundControl_SFXSetVolume"])
frame.panelContainer.page2.volumeSlider.high:SetText("100")
frame.panelContainer.page2.volumeSlider.low:SetText("0")
frame.panelContainer.page2.volumeSlider:SetScript("OnValueChanged", function(self)
    Chocobo.SoundControl:SetSFXVolume(self:GetValue(), true)
    CSCO:Update()
end)
frame.panelContainer.page2.volumeSlider:SetScript("OnMouseWheel", function(self, delta)
    CSCO:VolumeScroll(self, delta, 1)
end)

frame.panelContainer.page3 = CreateFrame("Frame", "ChocoboSoundControlOptionsPanelContainerPage3", frame.panelContainer)
frame.panelContainer.page3:SetPoint("TOPLEFT")
frame.panelContainer.page3:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page3:Hide()
frame.panelContainer.page3.panel = CreateFrame("Frame", nil, frame.panelContainer.page3)
frame.panelContainer.page3.panel:SetSize(360, 20)
frame.panelContainer.page3.panel:SetPoint("TOP", 0, -10)
frame.panelContainer.page3.panel.desc = frame.panelContainer.page3.panel:CreateFontString(nil, "OVERLAY")
frame.panelContainer.page3.panel.desc:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.panelContainer.page3.panel.desc:SetPoint("TOPLEFT")
frame.panelContainer.page3.panel.desc:SetPoint("BOTTOMRIGHT")
frame.panelContainer.page3.panel.desc:SetText(L["SoundControl_AmbienceDesc"])
frame.panelContainer.page3.enable = checkbox(
    "ChocoboSoundControlOptionsPage3Enable", frame.panelContainer.page3, L["SoundControl_AmbienceEnable"],
    function()
        Chocobo.SoundControl:ToggleAmbience(true)
        CSCO:Update()
    end)
frame.panelContainer.page3.enable:SetPoint("TOPLEFT", 10, -25)
frame.panelContainer.page3.enableMount = checkbox(
    "ChocoboSoundControlOptionsPage3EnableMount",
    frame.panelContainer.page3,
    L["SoundControl_AmbienceMount"],
    function()
        Chocobo.SoundControl:ToggleAmbienceMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page3.enableMount:SetPoint("TOPLEFT", 10, -65)
frame.panelContainer.page3.enableNoMount = checkbox(
    "ChocoboSoundControlOptionsPage3EnableNoMount",
    frame.panelContainer.page3,
    L["SoundControl_AmbienceNoMount"],
    function()
        Chocobo.SoundControl:ToggleAmbienceNoMount(true)
        CSCO:Update()
    end)
frame.panelContainer.page3.enableNoMount:SetPoint("TOPLEFT", 10, -105)
frame.panelContainer.page3.enableVolume = checkbox(
    "ChocoboSoundControlOptionsPage3EnableVolume",
    frame.panelContainer.page3,
    L["SoundControl_AmbienceVolume"],
    function()
        Chocobo.SoundControl:ToggleAmbienceVolume(true)
        CSCO:Update()
    end)
frame.panelContainer.page3.enableVolume:SetPoint("TOPLEFT", 10, -145)
frame.panelContainer.page3.volumeSlider = slider(
    "ChocoboSoundControlOptionsPage3VolumeSlider",
    frame.panelContainer.page3)
frame.panelContainer.page3.volumeSlider:SetSize(450, 16)
frame.panelContainer.page3.volumeSlider:SetPoint("TOP", 0, -195)
frame.panelContainer.page3.volumeSlider:SetMinMaxValues(0, 100)
frame.panelContainer.page3.volumeSlider:SetValueStep(1)
frame.panelContainer.page3.volumeSlider.label:SetText(L["SoundControl_AmbienceSetVolume"])
frame.panelContainer.page3.volumeSlider.high:SetText("100")
frame.panelContainer.page3.volumeSlider.low:SetText("0")
frame.panelContainer.page3.volumeSlider:SetScript("OnValueChanged", function(self)
    Chocobo.SoundControl:SetAmbienceVolume(self:GetValue(), true)
    CSCO:Update()
end)
frame.panelContainer.page3.volumeSlider:SetScript("OnMouseWheel", function(self, delta)
    CSCO:VolumeScroll(self, delta, 1)
end)

function CSCO:Open()
    Settings.OpenToCategory(Chocobo.Name)
end

function CSCO:Update()
    local settings = Chocobo.SoundControl.Settings
    frame.toggle:SetChecked(settings["ENABLED"])
    frame.toggleDefault:SetChecked(settings["DEFAULT"])
    frame.panelContainer.page1.enable:SetChecked(settings["MUSIC"]["ENABLED"])
    frame.panelContainer.page1.enableMount:SetChecked(settings["MUSIC"]["MOUNTED"])
    frame.panelContainer.page1.enableNoMount:SetChecked(settings["MUSIC"]["NOTMOUNTED"])
    frame.panelContainer.page1.enableVolume:SetChecked(settings["MUSIC"]["MOD_VOLUME"])
    frame.panelContainer.page1.volumeSlider:SetValue(settings["MUSIC"]["VOLUME"] * 100)
    frame.panelContainer.page1.volumeSlider.current:SetText(tostring(settings["MUSIC"]["VOLUME"] * 100))
    frame.panelContainer.page2.enable:SetChecked(settings["SFX"]["ENABLED"])
    frame.panelContainer.page2.enableMount:SetChecked(settings["SFX"]["MOUNTED"])
    frame.panelContainer.page2.enableNoMount:SetChecked(settings["SFX"]["NOTMOUNTED"])
    frame.panelContainer.page2.enableVolume:SetChecked(settings["SFX"]["MOD_VOLUME"])
    frame.panelContainer.page2.volumeSlider:SetValue(settings["SFX"]["VOLUME"] * 100)
    frame.panelContainer.page2.volumeSlider.current:SetText(tostring(settings["SFX"]["VOLUME"] * 100))
    frame.panelContainer.page3.enable:SetChecked(settings["AMBIENCE"]["ENABLED"])
    frame.panelContainer.page3.enableMount:SetChecked(settings["AMBIENCE"]["MOUNTED"])
    frame.panelContainer.page3.enableNoMount:SetChecked(settings["AMBIENCE"]["NOTMOUNTED"])
    frame.panelContainer.page3.enableVolume:SetChecked(settings["AMBIENCE"]["MOD_VOLUME"])
    frame.panelContainer.page3.volumeSlider:SetValue(settings["AMBIENCE"]["VOLUME"] * 100)
    frame.panelContainer.page3.volumeSlider.current:SetText(tostring(settings["AMBIENCE"]["VOLUME"] * 100))

    local enabled = settings["ENABLED"]
    local default = settings["DEFAULT"]

    if settings["MUSIC"]["MOD_VOLUME"] and enabled and not default then
        frame.panelContainer.page1.volumeSlider:Enable()
        frame.panelContainer.page1.volumeSlider.label:SetTextColor(1, 1, 1)
        frame.panelContainer.page1.volumeSlider.high:SetTextColor(1, 1, 1)
        frame.panelContainer.page1.volumeSlider.low:SetTextColor(1, 1, 1)
        frame.panelContainer.page1.volumeSlider.current:SetTextColor(1, 1, 1)
    else
        frame.panelContainer.page1.volumeSlider:Disable()
        frame.panelContainer.page1.volumeSlider.label:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page1.volumeSlider.high:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page1.volumeSlider.low:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page1.volumeSlider.current:SetTextColor(0.5, 0.5, 0.5)
    end

    if settings["SFX"]["MOD_VOLUME"] and enabled and not default then
        frame.panelContainer.page2.volumeSlider:Enable()
        frame.panelContainer.page2.volumeSlider.label:SetTextColor(1, 1, 1)
        frame.panelContainer.page2.volumeSlider.high:SetTextColor(1, 1, 1)
        frame.panelContainer.page2.volumeSlider.low:SetTextColor(1, 1, 1)
        frame.panelContainer.page2.volumeSlider.current:SetTextColor(1, 1, 1)
    else
        frame.panelContainer.page2.volumeSlider:Disable()
        frame.panelContainer.page2.volumeSlider.label:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page2.volumeSlider.high:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page2.volumeSlider.low:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page2.volumeSlider.current:SetTextColor(0.5, 0.5, 0.5)
    end

    if settings["AMBIENCE"]["MOD_VOLUME"] and enabled and not default then
        frame.panelContainer.page3.volumeSlider:Enable()
        frame.panelContainer.page3.volumeSlider.label:SetTextColor(1, 1, 1)
        frame.panelContainer.page3.volumeSlider.high:SetTextColor(1, 1, 1)
        frame.panelContainer.page3.volumeSlider.low:SetTextColor(1, 1, 1)
        frame.panelContainer.page3.volumeSlider.current:SetTextColor(1, 1, 1)
    else
        frame.panelContainer.page3.volumeSlider:Disable()
        frame.panelContainer.page3.volumeSlider.label:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page3.volumeSlider.high:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page3.volumeSlider.low:SetTextColor(0.5, 0.5, 0.5)
        frame.panelContainer.page3.volumeSlider.current:SetTextColor(0.5, 0.5, 0.5)
    end

    if not enabled or default then
        self:CheckboxesEnabled(false)
    else
        self:CheckboxesEnabled(true)
    end

    if enabled then
        frame.toggleDefault:Enable()
        frame.toggleDefault.label:SetTextColor(1, 1, 1)
    else
        frame.toggleDefault:Disable()
        frame.toggleDefault.label:SetTextColor(0.5, 0.5, 0.5)
    end
end

function CSCO:CheckboxesEnabled(enabled)
    local function setEnabled(f, e)
        if e then
            f:Enable()
        else
            f:Disable()
        end
    end
    local dr, dg, db = 0.5, 0.5, 0.5
    local r, g, b = 0.5, 0.5, 0.5
    if enabled then
        dr, dg, db = 1, 0.82, 0
        r, g, b = 1, 1, 1
    end
    if enabled then
        setEnabled(frame.panelContainer.tab1, true)
        setEnabled(frame.panelContainer.tab2, true)
        setEnabled(frame.panelContainer.tab3, true)
    end
    self:SetToCurrentTab()
    frame.panelContainer.page1.panel.desc:SetTextColor(dr, dg, db)
    frame.panelContainer.page2.panel.desc:SetTextColor(dr, dg, db)
    frame.panelContainer.page3.panel.desc:SetTextColor(dr, dg, db)
    setEnabled(frame.panelContainer.page1.enable, enabled)
    setEnabled(frame.panelContainer.page1.enableMount, enabled)
    setEnabled(frame.panelContainer.page1.enableNoMount, enabled)
    setEnabled(frame.panelContainer.page1.enableVolume, enabled)
    setEnabled(frame.panelContainer.page2.enable, enabled)
    setEnabled(frame.panelContainer.page2.enableMount, enabled)
    setEnabled(frame.panelContainer.page2.enableNoMount, enabled)
    setEnabled(frame.panelContainer.page2.enableVolume, enabled)
    setEnabled(frame.panelContainer.page3.enable, enabled)
    setEnabled(frame.panelContainer.page3.enableMount, enabled)
    setEnabled(frame.panelContainer.page3.enableNoMount, enabled)
    setEnabled(frame.panelContainer.page3.enableVolume, enabled)
    if not enabled then
        setEnabled(frame.panelContainer.tab1, false)
        setEnabled(frame.panelContainer.tab2, false)
        setEnabled(frame.panelContainer.tab3, false)
    end
    frame.panelContainer.page1.enable.label:SetTextColor(r, g, b)
    frame.panelContainer.page1.enableMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page1.enableNoMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page1.enableVolume.label:SetTextColor(r, g, b)
    frame.panelContainer.page2.enable.label:SetTextColor(r, g, b)
    frame.panelContainer.page2.enableMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page2.enableNoMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page2.enableVolume.label:SetTextColor(r, g, b)
    frame.panelContainer.page3.enable.label:SetTextColor(r, g, b)
    frame.panelContainer.page3.enableMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page3.enableNoMount.label:SetTextColor(r, g, b)
    frame.panelContainer.page3.enableVolume.label:SetTextColor(r, g, b)
end

function CSCO:SetToCurrentTab()
    PanelTemplates_SetTab(frame.panelContainer, PanelTemplates_GetSelectedTab(frame.panelContainer))
end

function CSCO:VolumeScroll(s, delta, num)
    local new = s:GetValue() + delta
    if new < 0 or new > 100 then return end
    if num == 1 then
        Chocobo.SoundControl:SetMusicVolume(new, true)
    elseif num == 2 then
        Chocobo.SoundControl:SetSFXVolume(new, true)
    elseif num == 3 then
        Chocobo.SoundControl:SetAmbienceVolume(new, true)
    end
    self:Update()
end

frame:SetScript("OnShow", function() CSCO:Update() end)

frame.OnCommit = function() end
frame.OnDefault = function() end
frame.OnRefresh = function() CSCO:Update() end

PanelTemplates_SetNumTabs(frame.panelContainer, 3)
PanelTemplates_SetTab(frame.panelContainer, 1)

local category = Settings.GetCategory(Chocobo.Name)
local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, frame, "Sound Control")
Settings.RegisterAddOnCategory(subcategory)
