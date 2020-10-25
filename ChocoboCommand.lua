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
--]]

Chocobo.Command = {
    Slash = {
        "chocobo"
    },
    Commands = {}
}

local C = Chocobo
local CC = C.Command
local CLib = ChocoboLib
local L = _G["ChocoboLocale"]

local AddCustomPattern = "\"([%w%p%s]+)\" \"([%w%p%s]+)\""
local AddCustomStart = "^\""
local AddCustomEnd = "\"$"

-- Argument #1 (command) can be either string or a table.
function CC:Register(command, func)
    if type(command) == "string" then
        command = {command}
    end
    for _,v in pairs(command) do
        if not self:HasCommand(v) then
            if v ~= "__DEFAULT__" then v = v:lower() end
            self.Commands[v] = func
        end
    end
end

function CC:HasCommand(command)
    return self.Commands[command]
end

function CC:HandleCommand(command, args)
    if self:HasCommand(command) then
        self.Commands[command](args)
    elseif self:HasCommand("__DEFAULT__") then
        self.Commands["__DEFAULT__"](args)
    else
        C:ErrorMsg((L["InvalidCommand"]):format(command))
    end
end

CC:Register("__DEFAULT__", function(args)
    C:Msg(L["HelpMessage1"])
    C:Msg(L["HelpMessage2"])
    C:Msg(L["HelpMessage3"])
    C:Msg(L["HelpMessage4"])
    C:Msg(L["HelpMessage17"])
    C:Msg(L["HelpMessage18"])
    C:Msg(L["HelpMessage19"])
    C:Msg(L["HelpMessage5"])
    C:Msg(L["HelpMessage6"])
    C:Msg(L["HelpMessage7"])
    C:Msg(L["HelpMessage8"])
    C:Msg(L["HelpMessage9"])
    C:Msg(L["HelpMessage10"])
    C:Msg(L["HelpMessage12"])
    C:Msg(L["HelpMessage13"])
    C:Msg(L["HelpMessage14"])
    C:Msg(L["HelpMessage15"])
    C:Msg(L["HelpMessage16"])
    C:Msg(L["HelpMessage11"])
end)

CC:Register({"options", "o", "config", "gui"}, function(args)
    Chocobo.SoundControl.Options:Open()
    Chocobo.Options:Open()
end)

CC:Register({"allmounts", "am", "all"}, function(args) C:FilterMount(false) end)
CC:Register({"hawkstrider", "hs", "hawk"}, function(args) C:FilterMount(true) end)
CC:Register({"modetoggle", "mounttoggle", "mt"}, function(args) C:FilterMount() end)
CC:Register({"toggle", "t"}, function(args) C:Toggle() end)
CC:Register({"plainstridertoggle", "plainstrider", "plainstriders", "ps"}, function(args) C:PlainstriderToggle() end)
CC:Register({"ridingcranetoggle", "ridingcrane", "ridingcranes", "rc"}, function(args) C:RidingCraneToggle() end)
CC:Register({"ravenlordtoggle", "ravenlord", "rl"}, function(args) C:RavenLordToggle() end)
CC:Register({"flametalontoggle", "flametalon", "flame", "alysrazor", "alys"}, function(args) C:FlametalonToggle() end)
CC:Register({"preventdupetoggle", "pdtoggle", "pdt"}, function(args) C:PreventDupeToggle() end)

CC:Register({"soundcontrol", "sc", "sndctrl", "sound"}, function(args)
    local handled = false
    if #args > 0 then
        local vol = tonumber(args[3])
        if args[1] == "gui" or args[1] == "options" then
            Chocobo.SoundControl.Options:Open()
            handled = true
        elseif args[1] == "toggle" or args[1] == "t" then
            C.SoundControl:Toggle()
            handled = true
        elseif args[1] == "default" or args[1] == "d" then
            C.SoundControl:ToggleDefault()
            handled = true
        elseif args[1] == "music" or args[1] == "m" then
            if #args > 1 then
                if args[2] == "toggle" or args[2] == "t" then
                    C.SoundControl:ToggleMusic()
                    handled = true
                elseif args[2]:match("^mount") or args[2] == "m" then
                    C.SoundControl:ToggleMusicMount()
                    handled = true
                elseif args[2]:match("^not?mount") or args[2] == "nm" then
                    C.SoundControl:ToggleMusicNoMount()
                    handled = true
                elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
                    if type(vol) == "number" then
                        C.SoundControl:SetMusicVolume(vol)
                        handled = true
                    elseif args[3] == "toggle" or args[3] == "t" then
                        C.SoundControl:ToggleMusicVolume()
                        handled = true
                    else
                        C.SoundControl:PrintMusicVolume()
                        handled = true
                    end
                end
            end
        elseif args[1] == "sfx" or args[1] == "sound" or args[1] == "s" then
            if #args > 1 then
                if args[2] == "toggle" or args[2] == "t" then
                    C.SoundControl:ToggleSFX()
                    handled = true
                elseif args[2]:match("^mount") or args[2] == "m" then
                    C.SoundControl:ToggleSFXMount()
                    handled = true
                elseif args[2]:match("^not?mount") or args[2] == "nm" then
                    C.SoundControl:ToggleSFXNoMount()
                    handled = true
                elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
                    if type(vol) == "number" then
                        C.SoundControl:SetSFXVolume(vol)
                        handled = true
                    elseif args[3] == "toggle" or args[3] == "t" then
                        C.SoundControl:ToggleSFXVolume()
                        handled = true
                    else
                        C.SoundControl:PrintSFXVolume()
                        handled = true
                    end
                end
            end
        elseif args[1] == "ambience" or args[1] == "amb" or args[1] == "a" then
            if #args > 1 then
                if args[2] == "toggle" or args[2] == "t" then
                    C.SoundControl:ToggleAmbience()
                    handled = true
                elseif args[2]:match("^mount") or args[2] == "m" then
                    C.SoundControl:ToggleAmbienceMount()
                    handled = true
                elseif args[2]:match("^not?mount") or args[2] == "nm" then
                    C.SoundControl:ToggleAmbienceNoMount()
                    handled = true
                elseif args[2] == "volume" or args[2] == "vol" or args[2] == "v" then
                    if type(vol) == "number" then
                        C.SoundControl:SetAmbienceVolume(vol)
                        handled = true
                    elseif args[3] == "toggle" or args[3] == "t" then
                        C.SoundControl:ToggleAmbienceVolume()
                        handled = true
                    else
                        C.SoundControl:PrintAmbienceVolume()
                        handled = true
                    end
                end
            end
        end
    end
    if not handled then
        C:Msg(L["SCSyntax1"])
        C:Msg(L["SCSyntax2"])
    end
end)

CC:Register({"list", "l", "ls"}, function(args) C:PrintMusic() end)
CC:Register({"reset", "r"}, function(args) C:ResetMusic() end)
CC:Register({"listmounts", "lm"}, function(args) C:PrintMounts() end)
CC:Register({"resetmounts", "rm"}, function(args) C:ResetMounts() end)

CC:Register({"debug", "d"}, function(args)
    if not args[1] then
        C:Debug()
    else
        C:Debug(args[1]:lower())
    end
end)

CC:Register({"add", "a"}, function(args)
    if #args > 0 then
        local song = args[1]
        if #args > 1 then
            for i=2,#args do
                song = song .. " " .. args[i]
            end
        end
        C:AddMusic(song)
    else
        C:Msg(L["AddSyntax"])
    end
end)

CC:Register({"remove", "rem", "delete", "del"}, function(args)
    if #args > 0 then
        local song = args[1]
        if #args > 1 then
            for i=2,#args do
                song = song .. " " .. args[i]
            end
        end
        C:RemoveMusic(song)
    else
        C:Msg(L["RemoveSyntax"])
    end
end)

CC:Register({"addcustom", "addc", "ac"}, function(args)
    if #args < 2 then
        C:ErrorMsg(L["AddCustomSyntax"])
        return
    end
    local arg = args[1]
    for i=2,#args do
        arg = arg .. " " .. args[i]
    end
    local mount, song = arg:match(AddCustomPattern)
    if not mount or not song then
        C:ErrorMsg(L["AddCustomSyntax"])
        return
    end
    C:AddCustomMusic(song, mount)
end)

CC:Register({"removecustom", "removec", "remc", "rc"}, function(args)
    if #args < 1 then
        C:ErrorMsg(L["RemoveCustomSyntax"])
        return
    end
    local arg = args[1]
    if #args > 1 then
        for i=2,#args do
            arg = arg .. " " .. args[i]
        end
    end
    C:RemoveCustomMusic(arg)
end)

CC:Register({"addmount", "addm"}, function(args)
    if #args > 0 then
        local mount = args[1]
        if #args > 1 then
            for i=2,#args do
                mount = mount .. " " .. args[i]
            end
        end
        C:AddMount(mount)
    else
        C:Msg(L["AddMountSyntax"])
    end
end)

CC:Register({"removemount", "remm", "deletemount", "delmount", "delm"}, function(args)
    if #args > 0 then
        local mount = args[1]
        if #args > 1 then
            for i=2,#args do
                mount = mount .. " " .. args[i]
            end
        end
        C:RemoveMount(mount)
    else
        C:Msg(L["RemoveMountSyntax"])
    end
end)

for i,v in ipairs(CC.Slash) do
    _G["SLASH_" .. C.Name:upper() .. i] = "/" .. v
end

SlashCmdList[C.Name:upper()] = function(msg, editBox)
    msg = CLib:Trim(msg)
    local args = CLib:Split(msg)
    local cmd = args[1]
    local t = {}
    if #args > 1 then
        for i=2,#args do
            table.insert(t, args[i])
        end
    end
    CC:HandleCommand(cmd, t)
end
