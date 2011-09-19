--[[
The GUI for Chocobo AddOn
--]]

local L = _G["ChocoboLocale"]

function ChocoboOptions_OnLoad()
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
	ChocoboOptionsFrame_OnlyHawk:SetText(L["Options_HawkstriderButton"])
	ChocoboOptionsFrame_AllMounts:SetText(L["Options_AllMountsButton"])
	ChocoboOptionsFrame_DebugOn:SetText(L["Options_EnableDebugging"])
	ChocoboOptionsFrame_DebugOff:SetText(L["Options_DisableDebugging"])
	ChocoboOptionsFrame_ToggleButton:SetText(L["Options_ToggleButton"])
	ChocoboOptionsFrame_OpenSoundControl:SetText(L["Options_OpenSoundControlButton"])
	ChocoboOptionsFrame_RavenLordToggleText:SetText(L["Options_RavenLordToggle"])
	ChocoboOptions_UpdateInfo()
end

function ChocoboOptions_UpdateInfo()
	local AddOnState, MountState, DebugState = ""
	local RavenLordState = Chocobo:GetGlobal("RAVENLORD")
	if Chocobo:GetGlobal("ENABLED") then AddOnState = L["Options_Enabled"] else AddOnState = L["Options_Disabled"] end
	if Chocobo:GetGlobal("ALLMOUNTS") then MountState = L["Options_AllMounts"] else MountState = L["Options_Hawkstrider"] end
	if Chocobo:GetGlobal("DEBUG") then DebugState = L["Options_Enabled"] else DebugState = L["Options_Disabled"] end
	ChocoboOptionsFrame_StatusLabel:SetText((L["Options_AddOnState"]):format(AddOnState))
	ChocoboOptionsFrame_MountLabel:SetText(MountState)
	ChocoboOptionsFrame_DebugLabel:SetText((L["Options_DebugState"]):format(DebugState))
	ChocoboOptionsFrame_DescriptionLabel:SetText((L["Options_Description"]):format(Chocobo:GetVersion()))
	ChocoboOptionsFrame_RavenLordToggle:SetChecked(RavenLordState)
end

function ChocoboOptions_AddSong()
	local songName = ChocoboOptionsFrame_SongsPanel_SongEditBox:GetText()
	Chocobo:AddMusic(songName)
end

function ChocoboOptions_RemoveSong()
	local songName = ChocoboOptionsFrame_SongsPanel_SongEditBox:GetText()
	Chocobo:RemoveMusic(songName)
end

function ChocoboOptions_AddMount()
	local mount = ChocoboOptionsFrame_MountPanel_MountEditBox:GetText()
	Chocobo:AddMount(mount)
end

function ChocoboOptions_RemoveMount()
	local mount = ChocoboOptionsFrame_MountPanel_MountEditBox:GetText()
	Chocobo:RemoveMount(mount)
end
