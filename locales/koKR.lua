if (GetLocale() == "koKR") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="koKR", format="lua_additive_table")@
	
	setmetatable(L, ChocoboLocale_Default)
end