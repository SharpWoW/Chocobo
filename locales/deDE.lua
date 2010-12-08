if (GetLocale() == "deDE") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, {__index=ChocoboLocale_Default})
end