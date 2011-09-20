--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--
--# Broker_Chocobo                                                      #--
--# All credits go to Lothaer on Curse for the creation of this plugin. #--
--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--

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
