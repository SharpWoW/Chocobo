if (GetLocale() == "ruRU") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="ruRU", format="lua_additive_table")@
	
	setmetatable(L, ChocoboLocale_Default)
end