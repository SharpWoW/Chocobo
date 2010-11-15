--[[
The GUI for Chocobo AddOn
--]]

function ChocoboOptions_UpdateInfo()
	local AddOnState, MountState, DebugState = ""
	if (CHOCOBO_ENABLED) then AddOnState = "enabled" else AddOnState = "disabled" end
	if (CHOCOBO_ALLMOUNTS) then MountState = "Playing music on all mounts." else MountState = "Playing music on hawkstriders only." end
	if (CHOCOBO_DEBUG) then DebugState = "enabled" else DebugState = "disabled" end
	ChocoboOptionsFrame_StatusLabel:SetText(string.format("AddOn is %s.", AddOnState))
	ChocoboOptionsFrame_MountLabel:SetText(MountState)
	ChocoboOptionsFrame_DebugLabel:SetText(string.format("Debugging is %s.", DebugState))
	ChocoboOptionsFrame_DescriptionLabel:SetText("Configure the AddOn!|nv" .. Chocobo_GetVersion())
end

function ChocoboOptions_AddSong()
	local songName = ChocoboOptionsFrame_SongsPanel_SongEditBox:GetText()
	Chocobo_AddMusic(songName)
end

function ChocoboOptions_RemoveSong()
	local songName = ChocoboOptionsFrame_SongsPanel_SongEditBox:GetText()
	Chocobo_RemoveMusic(songName)
end
