--[[
    Copyright (c) 2010-2020 by Adam Hellberg

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

function ChocoboLib:Split(s)
    local r = {}
    for token in string.gmatch(s, "[^%s]+") do
        table.insert(r, token)
    end
    return r
end

-- Table functions
function ChocoboLib:InTable(tbl, val)
    for _,v in pairs(tbl) do
        if v == val then return true end
    end
    return false
end

function ChocoboLib:Count(tbl)
    local c = 0
    for _, _ in pairs(tbl) do
        c = c + 1
    end
    return c
end

--[[ChocoboLib Specific Functions]]--
-- Buff/Aura functions

local function GetBuffs()
    local buffs = {}
    for i=1,40 do -- Loop through all 40 possible buff indexes
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i, "PLAYER CANCELABLE")
        -- Insert it into the buffs table, break if buff is nil (that means no other buffs exist on the player)
        if aura and aura.name and aura.spellId then
            buffs[aura.name] = aura.spellId
        else
            break
        end
    end
    return buffs
end

-- ChocoboLib:HasBuff
--- Argument #1: [table] containing numeric buff IDs or names to check
--- Overload #1.1: [number] ID of buff to check
--- Overload #1.2: [string] name of buff to check
--- RETURNS: false if the buff wasn't found, true, id of buff and name of buff if buff was found
function ChocoboLib:HasBuff(idColl) -- idColl is either a number or a table with IDs or buff names
    -- TODO: Implement ability to pass IDs as varargs (1, 2, 3, 4, 5, ...)
    if type(idColl) == "number" then
        return self:HasBuff({idColl})
    elseif type(idColl) == "string" then
        return self:HasBuff({idColl})
    elseif type(idColl) ~= "table" then
        error("Argument #1 must be of type 'table', 'number' or 'string'.") -- Localize error?
        return false -- Just in case the error() did not cause it to exit, for whatever reason.
    end

    local buffs = GetBuffs()

    for _, value in pairs(idColl) do
        local vType = type(value)
        for name, id in pairs(buffs) do
            if (vType == "number" and id == value) or (vType == "string" and name:lower() == value:lower()) then
                return true, name or "<No Name>", id
            end
        end
    end

    return false -- Else return false (Player does not have the buff)
end
