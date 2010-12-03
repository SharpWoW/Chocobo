if (GetLocale() == "ruRU") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, ChocoboLocale_Default)
end