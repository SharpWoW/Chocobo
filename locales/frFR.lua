if (GetLocale() == "frFR") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, ChocoboLocale_Default)
end