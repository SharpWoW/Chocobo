--[[
GUI for chocobo sound check options
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
