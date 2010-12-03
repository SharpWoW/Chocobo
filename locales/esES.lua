if (GetLocale() == "esES") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, ChocoboLocale_Default)
end