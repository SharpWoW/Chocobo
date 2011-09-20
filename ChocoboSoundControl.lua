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

function ChocoboSoundControl_OnLoad()
	ChocoboSoundControlFrame_TitleString:SetText(L["SoundControl_Title"])
	ChocoboSoundControlFrame_CaptionLabel:SetText(L["SoundControl_Caption"])
	ChocoboSoundControlFrame_DescriptionLabel:SetText(L["SoundControl_Description"])
	ChocoboSoundControlFrame_ToggleButton:SetText(L["SoundControl_ToggleButton"])
	ChocoboSoundControlFrame_ReturnButton:SetText(L["SoundControl_ReturnButton"])
	ChocoboSoundControl_UpdateInfo()
end

function ChocoboSoundControl_UpdateInfo()
	local scState = ""
	if Chocobo:GetGlobal("SOUNDCONTROL") then scState = L["Options_Enabled"] else scState = L["Options_Disabled"] end
	ChocoboSoundControlFrame_StatusLabel:SetText((L["SoundControl_State"]):format(scState))
end

function ChocoboSoundControl_Return()
	ChocoboSoundControlFrame:Hide()
	ChocoboOptionsFrame:Show()
end
