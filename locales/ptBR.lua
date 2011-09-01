if (GetLocale() == "ptBR") then
	local L = _G["ChocoboLocale"]
	
	--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="english")@
	
	setmetatable(L, {__index=ChocoboLocale_Default})
end