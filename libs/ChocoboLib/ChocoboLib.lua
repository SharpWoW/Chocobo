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

	------
	
	Chocobo Lib (Chocobo Library)
	
	Collection of functions useful for buff/mount related actions.
	As well as some general functions useful for anything.
--]]

ChocoboLib = {}

--[[General Functions]]--
-- String functions
function ChocoboLib:Trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

--[[ChocoboLib Specific Functions]]--
-- Buff/Aura functions

-- ChocoboLib:HasBuff
--- Argument #1: [table] containing numeric buff IDs to check
--- Overload #1.1: [number] ID of buff to check
--- Overload #1.2: [string] name of buff to check
--- RETURNS: false if the buff wasn't found, true, id of buff and name of buff if buff was found
function ChocoboLib:HasBuff(idColl) -- idColl is either a number or a table with IDs
	-- TODO: Implement ability to pass IDs as varargs (1, 2, 3, 4, 5, ...)
	if type(idColl) == "number" then
		return self:HasBuff({idColl})
	elseif type(idColl) == "string" then
		return self:HasBuff({idColl})
	elseif type(idColl) ~= "table" then
		error("Argument #1 must be of type 'table', 'number' or 'string'.") -- Localize error?
		return false -- Just in case the error() did not cause it to exit, for whatever reason.
	end
	local buffs = {}
	for i=1,40 do -- Loop through all 40 possible buff indexes
		local name,_,_,_,_,_,_,_,_,_,id = UnitAura("player", i) -- Get buff on index i
		-- Insert it into the buffs table, break if buff is nil (that means no other buffs exist on the player)
		if name and id then buffs[name] = id else break end
	end
	for name,id in pairs(buffs) do -- Loop through all buffs found
		for _,v in pairs(idColl) do -- Loop through all supplied IDs
			if type(v) == "number" then -- Check if the value is a number
				if id == v then -- Check if ID equals current buff ID and return true if it does
					return true, (name or "<No Name>"), id
				end
			elseif type(v) == "string" then -- Check if the value is a string
				if name:lower() == v:lower() then -- Check if name equals current buff name and return true if it does
					return true, (name or "<No Name>"), id
				end
			end
		end
	end
	return false -- Else return false (Player does not have the buff)
end
