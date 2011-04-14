function ChocoboInterfacePanel_OnLoad(panel)
	panel.name = "Chocobo"
	InterfaceOptions_AddCategory(panel)
end

function ChocoboInterfacePanel_OpenOptions()
	if ChocoboOptionsFrame:IsVisible() then
		ChocoboOptionsFrame:Hide()
	else
		ChocoboOptionsFrame:Show()
		InterfaceOptionsFrame:Hide()
		-- TODO: Find alternative way to close Game Menu
		--  since ToggleGameMenu is protected and could bug.
		ToggleGameMenu()
	end
end
