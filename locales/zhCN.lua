if (GetLocale() == "zhCN") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="zhCN", format="lua_additive_table")@
	
	setmetatable(L, ChocoboLocale_Default)
end