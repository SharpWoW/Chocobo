if (GetLocale() == "zhCN") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, ChocoboLocale_Default)
end