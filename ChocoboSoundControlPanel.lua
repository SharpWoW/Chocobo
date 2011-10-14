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

Chocobo.SoundControl.Options = {}

function Chocobo.SoundControl.Options:OnLoad(panel)
	PanelTemplates_SetNumTabs(ChocoboSoundControl_PanelContainer, 3)
	PanelTemplates_SetTab(ChocoboSoundControl_PanelContainer, 1)
	ChocoboSoundControl_PanelContainerPage1:Show()
	ChocoboSoundControl_PanelContainerPage2:Hide()
	ChocoboSoundControl_PanelContainerPage3:Hide()
	panel.name = "Sound Control"
	panel.parent = "Chocobo"
	panel.refresh = function() Chocobo.SoundControl.Options:Update() end
	InterfaceOptions_AddCategory(panel)
	ChocoboSoundControl_CaptionLabel:SetText(L["SoundControl_Caption"])
	ChocoboSoundControl_DescriptionLabel:SetText(L["SoundControl_Description"])
	ChocoboSoundControl_DescriptionLabel:SetTextColor(1, 1, 1)
	ChocoboSoundControl_ToggleText:SetText(L["SoundControl_Toggle"])
	ChocoboSoundControl_ToggleText:SetTextColor(1, 1, 1)
	ChocoboSoundControl_ToggleDefaultText:SetText(L["SoundControl_ToggleDefault"])
	ChocoboSoundControl_DefaultHelpLabel:SetText(L["SoundControl_DefaultHelp"])
	ChocoboSoundControl_DefaultHelpLabel:SetTextColor(1, 1, 1)
	ChocoboSoundControl_DefaultNoteLabel:SetText(L["SoundControl_DefaultNote"])
	ChocoboSoundControl_PanelContainerTab1:SetText(L["SoundControl_Music"])
	ChocoboSoundControl_PanelContainerTab2:SetText(L["SoundControl_SFX"])
	ChocoboSoundControl_PanelContainerTab3:SetText(L["SoundControl_Ambience"])
	ChocoboSoundControl_PanelContainerPage1_PanelDesc:SetText(L["SoundControl_MusicDesc"])
	ChocoboSoundControl_PanelContainerPage1_EnableText:SetText(L["SoundControl_MusicEnable"])
	ChocoboSoundControl_PanelContainerPage1_EnableMountText:SetText(L["SoundControl_MusicMount"])
	ChocoboSoundControl_PanelContainerPage1_EnableNoMountText:SetText(L["SoundControl_MusicNoMount"])
	ChocoboSoundControl_PanelContainerPage1_EnableVolumeText:SetText(L["SoundControl_MusicVolume"])
	ChocoboSoundControl_PanelContainerPage1_VolumeSliderText:SetText(L["SoundControl_MusicSetVolume"])
	ChocoboSoundControl_PanelContainerPage1_VolumeSliderHigh:SetText("100")
	ChocoboSoundControl_PanelContainerPage1_VolumeSliderLow:SetText("0")
	ChocoboSoundControl_PanelContainerPage1_VolumeSlider:SetMinMaxValues(0, 100)
	ChocoboSoundControl_PanelContainerPage1_VolumeSlider:SetValueStep(1)
	ChocoboSoundControl_PanelContainerPage2_PanelDesc:SetText(L["SoundControl_SFXDesc"])
	ChocoboSoundControl_PanelContainerPage2_EnableText:SetText(L["SoundControl_SFXEnable"])
	ChocoboSoundControl_PanelContainerPage2_EnableMountText:SetText(L["SoundControl_SFXMount"])
	ChocoboSoundControl_PanelContainerPage2_EnableNoMountText:SetText(L["SoundControl_SFXNoMount"])
	ChocoboSoundControl_PanelContainerPage2_EnableVolumeText:SetText(L["SoundControl_SFXVolume"])
	ChocoboSoundControl_PanelContainerPage2_VolumeSliderText:SetText(L["SoundControl_SFXSetVolume"])
	ChocoboSoundControl_PanelContainerPage2_VolumeSliderHigh:SetText("100")
	ChocoboSoundControl_PanelContainerPage2_VolumeSliderLow:SetText("0")
	ChocoboSoundControl_PanelContainerPage2_VolumeSlider:SetMinMaxValues(0, 100)
	ChocoboSoundControl_PanelContainerPage2_VolumeSlider:SetValueStep(1)
	ChocoboSoundControl_PanelContainerPage3_PanelDesc:SetText(L["SoundControl_AmbienceDesc"])
	ChocoboSoundControl_PanelContainerPage3_EnableText:SetText(L["SoundControl_AmbienceEnable"])
	ChocoboSoundControl_PanelContainerPage3_EnableMountText:SetText(L["SoundControl_AmbienceMount"])
	ChocoboSoundControl_PanelContainerPage3_EnableNoMountText:SetText(L["SoundControl_AmbienceNoMount"])
	ChocoboSoundControl_PanelContainerPage3_EnableVolumeText:SetText(L["SoundControl_AmbienceVolume"])
	ChocoboSoundControl_PanelContainerPage3_VolumeSliderText:SetText(L["SoundControl_AmbienceSetVolume"])
	ChocoboSoundControl_PanelContainerPage3_VolumeSliderHigh:SetText("100")
	ChocoboSoundControl_PanelContainerPage3_VolumeSliderLow:SetText("0")
	ChocoboSoundControl_PanelContainerPage3_VolumeSlider:SetMinMaxValues(0, 100)
	ChocoboSoundControl_PanelContainerPage3_VolumeSlider:SetValueStep(1)
end

function Chocobo.SoundControl.Options:Update()
	local settings = Chocobo.SoundControl.Settings
	ChocoboSoundControl_Toggle:SetChecked(settings["ENABLED"])
	ChocoboSoundControl_ToggleDefault:SetChecked(settings["DEFAULT"])
	ChocoboSoundControl_PanelContainerPage1_Enable:SetChecked(settings["MUSIC"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage1_EnableMount:SetChecked(settings["MUSIC"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage1_EnableNoMount:SetChecked(settings["MUSIC"]["NOTMOUNTED"])
	ChocoboSoundControl_PanelContainerPage1_EnableVolume:SetChecked(settings["MUSIC"]["MOD_VOLUME"])
	ChocoboSoundControl_PanelContainerPage1_VolumeSlider:SetValue(settings["MUSIC"]["VOLUME"] * 100)
	ChocoboSoundControl_PanelContainerPage1_VolumeSlider_Current:SetText(tostring(settings["MUSIC"]["VOLUME"] * 100))
	ChocoboSoundControl_PanelContainerPage2_Enable:SetChecked(settings["SFX"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage2_EnableMount:SetChecked(settings["SFX"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage2_EnableNoMount:SetChecked(settings["SFX"]["NOTMOUNTED"])
	ChocoboSoundControl_PanelContainerPage2_EnableVolume:SetChecked(settings["SFX"]["MOD_VOLUME"])
	ChocoboSoundControl_PanelContainerPage2_VolumeSlider:SetValue(settings["SFX"]["VOLUME"] * 100)
	ChocoboSoundControl_PanelContainerPage2_VolumeSlider_Current:SetText(tostring(settings["SFX"]["VOLUME"] * 100))
	ChocoboSoundControl_PanelContainerPage3_Enable:SetChecked(settings["AMBIENCE"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage3_EnableMount:SetChecked(settings["AMBIENCE"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage3_EnableNoMount:SetChecked(settings["AMBIENCE"]["NOTMOUNTED"])
	ChocoboSoundControl_PanelContainerPage3_EnableVolume:SetChecked(settings["AMBIENCE"]["MOD_VOLUME"])
	ChocoboSoundControl_PanelContainerPage3_VolumeSlider:SetValue(settings["AMBIENCE"]["VOLUME"] * 100)
	ChocoboSoundControl_PanelContainerPage3_VolumeSlider_Current:SetText(tostring(settings["AMBIENCE"]["VOLUME"] * 100))
	
	local enabled = settings["ENABLED"]
	local default = settings["DEFAULT"]
	
	if settings["MUSIC"]["MOD_VOLUME"] and enabled and not default then
		ChocoboSoundControl_PanelContainerPage1_VolumeSlider:Enable()
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderText:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderHigh:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderLow:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage1_VolumeSlider_Current:SetTextColor(1, 1, 1)
	else
		ChocoboSoundControl_PanelContainerPage1_VolumeSlider:Disable()
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderText:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderHigh:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage1_VolumeSliderLow:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage1_VolumeSlider_Current:SetTextColor(0.5, 0.5, 0.5)
	end
	
	if settings["SFX"]["MOD_VOLUME"] and enabled and not default then
		ChocoboSoundControl_PanelContainerPage2_VolumeSlider:Enable()
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderText:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderHigh:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderLow:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage2_VolumeSlider_Current:SetTextColor(1, 1, 1)
	else
		ChocoboSoundControl_PanelContainerPage2_VolumeSlider:Disable()
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderText:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderHigh:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage2_VolumeSliderLow:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage2_VolumeSlider_Current:SetTextColor(0.5, 0.5, 0.5)
	end
	
	if settings["AMBIENCE"]["MOD_VOLUME"] and enabled and not default then
		ChocoboSoundControl_PanelContainerPage3_VolumeSlider:Enable()
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderText:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderHigh:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderLow:SetTextColor(1, 1, 1)
		ChocoboSoundControl_PanelContainerPage3_VolumeSlider_Current:SetTextColor(1, 1, 1)
	else
		ChocoboSoundControl_PanelContainerPage3_VolumeSlider:Disable()
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderText:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderHigh:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage3_VolumeSliderLow:SetTextColor(0.5, 0.5, 0.5)
		ChocoboSoundControl_PanelContainerPage3_VolumeSlider_Current:SetTextColor(0.5, 0.5, 0.5)
	end
	
	if not enabled or default then
		self:CheckboxesEnabled(false)
	else
		self:CheckboxesEnabled(true)
	end
	
	if enabled then
		ChocoboSoundControl_ToggleDefault:Enable()
		ChocoboSoundControl_ToggleDefaultText:SetTextColor(1, 1, 1)
	else
		ChocoboSoundControl_ToggleDefault:Disable()
		ChocoboSoundControl_ToggleDefaultText:SetTextColor(0.5, 0.5, 0.5)
	end
end

function Chocobo.SoundControl.Options:CheckboxesEnabled(enabled)
	local function setEnabled(frame, enabled)
		if enabled then
			frame:Enable()
		else
			frame:Disable()
		end
	end
	local dr, dg, db = 0.5, 0.5, 0.5
	local r, g, b = 0.5, 0.5, 0.5
	if enabled then
		dr, dg, db = 1, 0.82, 0
		r, g, b = 1, 1, 1
	end
	if enabled then
		setEnabled(ChocoboSoundControl_PanelContainerTab1, true)
		setEnabled(ChocoboSoundControl_PanelContainerTab2, true)
		setEnabled(ChocoboSoundControl_PanelContainerTab3, true)
	end
	self:SetToCurrentTab()
	ChocoboSoundControl_PanelContainerPage1_PanelDesc:SetTextColor(dr, dg, db)
	ChocoboSoundControl_PanelContainerPage2_PanelDesc:SetTextColor(dr, dg, db)
	ChocoboSoundControl_PanelContainerPage3_PanelDesc:SetTextColor(dr, dg, db)
	setEnabled(ChocoboSoundControl_PanelContainerPage1_Enable, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage1_EnableMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage1_EnableNoMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage1_EnableVolume, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage2_Enable, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage2_EnableMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage2_EnableNoMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage2_EnableVolume, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage3_Enable, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage3_EnableMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage3_EnableNoMount, enabled)
	setEnabled(ChocoboSoundControl_PanelContainerPage3_EnableVolume, enabled)
	if not enabled then
		setEnabled(ChocoboSoundControl_PanelContainerTab1, false)
		setEnabled(ChocoboSoundControl_PanelContainerTab2, false)
		setEnabled(ChocoboSoundControl_PanelContainerTab3, false)
	end
	ChocoboSoundControl_PanelContainerPage1_EnableText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage1_EnableMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage1_EnableNoMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage1_EnableVolumeText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage2_EnableText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage2_EnableMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage2_EnableNoMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage2_EnableVolumeText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage3_EnableText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage3_EnableMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage3_EnableNoMountText:SetTextColor(r, g, b)
	ChocoboSoundControl_PanelContainerPage3_EnableVolumeText:SetTextColor(r, g, b)
end

function Chocobo.SoundControl.Options:SetToCurrentTab()
	PanelTemplates_SetTab(ChocoboSoundControl_PanelContainer, PanelTemplates_GetSelectedTab(ChocoboSoundControl_PanelContainer))
end

function Chocobo.SoundControl.Options:VolumeScroll(slider, delta, num)
	local new = slider:GetValue() + delta
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
