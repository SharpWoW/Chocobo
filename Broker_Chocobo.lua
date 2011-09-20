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

--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--
--# Broker_Chocobo                                                        #--
--# Thanks to Lothaer on Curse for the idea and initial version of this.  #--
--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--

local appname = "Chocobo"
version = GetAddOnMetadata(appname, "Version")

assert(_G["ChocoboLocale"], "Locales not loaded")

local L = _G["ChocoboLocale"]

data = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Broker_Chocobo", {
	type = "launcher",
	label = appname,
	icon = "Interface\\AddOns\\Chocobo\\icon.tga",
	text = L["Broker_Text"]
})

function data.OnTooltipShow(tip)
	bmhTip = CreateFrame("GameTooltip", "Broker_Chocobo_Tip") 
	tip:AddLine((L["Broker_Version"]):format(version))
	tip:AddLine(L["Broker_Click"])
	tip:AddLine(L["Broker_RightClick"])
end

function data.OnClick(self, button)
	if not IsAddOnLoaded(appname) then
		LoadAddOn(appname)
	end
	if button == "RightButton" then
		if ChocoboSoundControlFrame:IsVisible() then
			ChocoboSoundControlFrame:Hide()
		else
			ChocoboSoundControlFrame:Show()
		end
	else
		if ChocoboOptionsFrame:IsVisible() then
			ChocoboOptionsFrame:Hide()
		else
			ChocoboOptionsFrame:Show()
		end
	end
end
