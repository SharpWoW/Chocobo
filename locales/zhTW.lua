if (GetLocale() == "zhTW") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="zhTW", format="lua_additive_table")@
	
	setmetatable(L, ChocoboLocale_Default)
end