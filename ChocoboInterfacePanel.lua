--[[
    Copyright (c) 2010-2011 by Adam Hellberg
    
    This file is part of Chocobo.
    
    Chocobo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    Chocobo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with Chocobo. If not, see <http://www.gnu.org/licenses/>.
--]]

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
		-- We can't do GameMenuFrame:Hide(), for some reason that
		--  will make it impossible to reopen the game menu with
		--  the ESCAPE key.
		if GameMenuFrame:IsShown() then ToggleGameMenu() end
	end
end
