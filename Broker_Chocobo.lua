--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--
--# Broker_Chocobo                                                      #--
--# All credits go to Lothaer on Curse for the creation of this plugin. #--
--#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#--

local appname = "Chocobo"
version = GetAddOnMetadata(appname, "Version")

data = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Broker_Chocobo", {
	type = "launcher",
	label = appname,
	icon = "Interface\\AddOns\\Chocobo\\icon.tga",
	text = "Open Chocobo options"
})

function data.OnTooltipShow(tip)
	bmhTip = CreateFrame("GameTooltip", "Broker_Chocobo_Tip") 
	tip:AddLine("Broker Chocobo v" .. version)
	tip:AddLine("Click - Open Chocobo Options")
end

function data.OnClick(self, button)
	if not IsAddOnLoaded(appname) then
		LoadAddOn(appname)
	end
	if ChocoboOptionsFrame:IsVisible() then
		ChocoboOptionsFrame:Hide()
	else
		ChocoboOptionsFrame:Show()
	end
end
