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

function ChocoboSoundControl_OnLoad(panel)
	PanelTemplates_SetNumTabs(ChocoboSoundControl_PanelContainer, 3)
	PanelTemplates_SetTab(ChocoboSoundControl_PanelContainer, 1)
	ChocoboSoundControl_PanelContainerPage1:Show()
	ChocoboSoundControl_PanelContainerPage2:Hide()
	ChocoboSoundControl_PanelContainerPage3:Hide()
	panel.name = "Sound Control"
	panel.parent = "Chocobo"
	panel.refresh = ChocoboSoundControl_UpdateInfo
	InterfaceOptions_AddCategory(panel)
	ChocoboSoundControl_CaptionLabel:SetText(L["SoundControl_Caption"])
	ChocoboSoundControl_DescriptionLabel:SetText(L["SoundControl_Description"])
	ChocoboSoundControl_ToggleText:SetText(L["SoundControl_Toggle"])
	ChocoboSoundControl_ToggleDefaultText:SetText(L["SoundControl_ToggleDefault"])
	ChocoboSoundControl_DefaultHelpLabel:SetText(L["SoundControl_DefaultHelp"])
	ChocoboSoundControl_DefaultNoteLabel:SetText(L["SoundControl_DefaultNote"])
	ChocoboSoundControl_PanelContainerTab1:SetText(L["SoundControl_Music"])
	ChocoboSoundControl_PanelContainerTab2:SetText(L["SoundControl_SFX"])
	ChocoboSoundControl_PanelContainerTab3:SetText(L["SoundControl_Ambience"])
	ChocoboSoundControl_PanelContainerPage1_PanelDesc:SetText(L["SoundControl_MusicDesc"])
	ChocoboSoundControl_PanelContainerPage1_EnableText:SetText(L["SoundControl_MusicEnable"])
	ChocoboSoundControl_PanelContainerPage1_EnableMountText:SetText(L["SoundControl_MusicMount"])
	ChocoboSoundControl_PanelContainerPage1_EnableNoMountText:SetText(L["SoundControl_MusicNoMount"])
	ChocoboSoundControl_PanelContainerPage2_PanelDesc:SetText(L["SoundControl_SoundDesc"])
	ChocoboSoundControl_PanelContainerPage2_EnableText:SetText(L["SoundControl_SoundEnable"])
	ChocoboSoundControl_PanelContainerPage2_EnableMountText:SetText(L["SoundControl_SoundMount"])
	ChocoboSoundControl_PanelContainerPage2_EnableNoMountText:SetText(L["SoundControl_SoundNoMount"])
	ChocoboSoundControl_PanelContainerPage3_PanelDesc:SetText(L["SoundControl_AmbienceDesc"])
	ChocoboSoundControl_PanelContainerPage3_EnableText:SetText(L["SoundControl_AmbienceEnable"])
	ChocoboSoundControl_PanelContainerPage3_EnableMountText:SetText(L["SoundControl_AmbienceMount"])
	ChocoboSoundControl_PanelContainerPage3_EnableNoMountText:SetText(L["SoundControl_AmbienceNoMount"])
end

function ChocoboSoundControl_UpdateInfo()
	ChocoboSoundControl_Toggle:SetChecked(Chocobo.SoundControl.Settings["ENABLED"])
	ChocoboSoundControl_ToggleDefault:SetChecked(Chocobo.SoundControl.Settings["DEFAULT"])
	ChocoboSoundControl_PanelContainerPage1_Enable:SetChecked(Chocobo.SoundControl.Settings["MUSIC"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage1_EnableMount:SetChecked(Chocobo.SoundControl.Settings["MUSIC"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage1_EnableNoMount:SetChecked(Chocobo.SoundControl.Settings["MUSIC"]["NOTMOUNTED"])
	ChocoboSoundControl_PanelContainerPage2_Enable:SetChecked(Chocobo.SoundControl.Settings["SOUND"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage2_EnableMount:SetChecked(Chocobo.SoundControl.Settings["SOUND"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage2_EnableNoMount:SetChecked(Chocobo.SoundControl.Settings["SOUND"]["NOTMOUNTED"])
	ChocoboSoundControl_PanelContainerPage3_Enable:SetChecked(Chocobo.SoundControl.Settings["AMBIENCE"]["ENABLED"])
	ChocoboSoundControl_PanelContainerPage3_EnableMount:SetChecked(Chocobo.SoundControl.Settings["AMBIENCE"]["MOUNTED"])
	ChocoboSoundControl_PanelContainerPage3_EnableNoMount:SetChecked(Chocobo.SoundControl.Settings["AMBIENCE"]["NOTMOUNTED"])
end
