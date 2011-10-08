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

assert(_G["ChocoboLocale"], "Locales not loaded")

local L = _G["ChocoboLocale"]

data = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Broker_Chocobo", {
	type = "launcher",
	label = Chocobo.Name .. " |cff00FF00(v" .. Chocobo.Version .. ")|r",
	icon = "Interface\\AddOns\\Chocobo\\icon.tga",
	text = L["Broker_Text"]
})

function data.OnTooltipShow(tip)
	tip:AddLine((L["Broker_Version"]):format(Chocobo.Version))
	tip:AddLine(L["Broker_LeftClick"])
	tip:AddLine(L["Broker_MiddleClick"])
	tip:AddLine(L["Broker_RightClick"])
end

function data.OnClick(self, button)
	if button == "LeftButton" then
		InterfaceOptionsFrame_OpenToCategory(ChocoboOptions)
	elseif button == "MiddleButton" then
		Chocobo.SoundControl:Toggle()
	elseif button == "RightButton" then
		InterfaceOptionsFrame_OpenToCategory(ChocoboSoundControl)
	end
end
