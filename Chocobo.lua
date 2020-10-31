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

    Chocobo AddOn
    Dedicated to Shishu (Flurdy) on Azuremyst-EU
--]]

Chocobo = {
    Name = "Chocobo",
    Version = GetAddOnMetadata("Chocobo", "Version"),
    Loaded = false,
    Mounted = false,
    Running = false, -- True if the OnUpdate handler is running.
    MusicDir = "Interface\\AddOns\\Chocobo\\music\\",
    Global = {},
    Events = {},
    Songs = { -- Default songs loaded on first run
        -- Please note that you can't add custom songs here,
        -- this is only used when restoring default settings or on initial setup
        "chocobo.ogg",
        "chocobo_ffiv.ogg",
        "chocobo_ffxii.ogg",
        "chocobo_ffxiii.ogg"
    },

    -- Values are overridden later with the return from GetSpellInfo
    -- The ones specified here are just placeholders and to help
    -- identify IDs during development
    Mounts = {
        Hawkstriders = {
            [35022] = "Black Hawkstrider",
            [35020] = "Blue Hawkstrider",
            [35018] = "Purple Hawkstrider",
            [34795] = "Red Hawkstrider",
            [63642] = "Silvermoon Hawkstrider",
            [66091] = "Sunreaver Hawkstrider",
            [35025] = "Swift Green Hawkstrider",
            [33660] = "Swift Pink Hawkstrider",
            [35027] = "Swift Purple Hawkstrider",
            [65639] = "Swift Red Hawkstrider",
            [35028] = "Swift Warstrider", -- (Thanks Khormin for pointing it out)
            [46628] = "Swift White Hawkstrider"
        },
        Plainstriders = {
            [102346] = "Swift Forest Strider",
            [102350] = "Swift Lovebird",
            [101573] = "Swift Shorestrider",
            [102349] = "Swift Springtrider"
        },
        RidingCranes = {
            [127174] = "Azure Riding Crane",
            [127176] = "Golden Riding Crane",
            [127177] = "Regal Riding Crane"
        },
        RavenLord = {
            [41252] = "Raven Lord" -- (If enabled in options)
        },
        Flametalon = {
            [101542] = "Flametalon of Alysrazor" -- (Fire version of Raven Lord)
        },
        DruidForms = { -- When AllMounts is enabled
            [33943] = "Flight form",
            [40120] = "Swift Flight Form"
        }
    }
}

local C = Chocobo

--@debug@
if C.Version == "@".."project-version".."@" then C.Version = "Development" end
--@end-debug@

local CLib = ChocoboLib
local L = _G["ChocoboLocale"]

assert(CLib, "Chocobo Lib not loaded")
assert(L, "Chocobo Locales not loaded")

local nowPlaying -- The current song playing, used when preventing the same song playing twice

function C:OnEvent(_, event, ...)
    if self.Events[event] then self.Events[event](self, ...) end
end

function C.Events.ADDON_LOADED(self, ...)
    -- Currently, this seems a bit bugged when having multiple addons. The "loaded" message will disappear sometimes.
    local addonName = (select(1, ...)):lower()
    if addonName ~= "chocobo" or self.Loaded then return end
    if type(_G["CHOCOBO"]) ~= "table" then _G["CHOCOBO"] = {} end
    self.Global = _G["CHOCOBO"]
    if type(self.Global["DEBUG"]) ~= "boolean" then
        -- Should be fired on first launch, set the saved variable to default value
        self:Msg(L["DebugNotSet"])
        self.Global["DEBUG"] = false
    end
    if type(self.Global["ALLMOUNTS"]) ~= "boolean" then
        -- Should be fired on first launch, set the saved variable to default value
        self:Msg(L["AllMountsNotSet"])
        self.Global["ALLMOUNTS"] = false
    end
    if type(self.Global["PLAINSTRIDER"]) ~= "boolean" then
        self:Msg(L["PlainstridersNotSet"])
        self.Global["PLAINSTRIDER"] = true
    end
    if type(self.Global["RIDINGCRANE"]) ~= "boolean" then
        self:Msg(L["RidingCranesNotSet"])
        self.Global["RIDINGCRANE"] = true
    end
    if type(self.Global["RAVENLORD"]) ~= "boolean" then
        self:Msg(L["RavenLordNotSet"])
        self.Global["RAVENLORD"] = false
    end
    if type(self.Global["FLAMETALON"]) ~= "boolean" then
        self:Msg(L["FlametalonNotSet"])
        self.Global["FLAMETALON"] = false
    end
    if not self.Global["MUSIC"] then -- If the song list is empty
        -- Populate the table with default songs
        self:Msg(L["NoMusic"])
        self.Global["MUSIC"] = {}
        for _,v in pairs(self.Songs) do -- Add all of the default songs
            self:AddMusic(v)
        end
    end
    if not self.Global["MUSIC_OGG_UPDATE"] then -- Reset music if still using mp3s
        self:ResetMusic()
        self.Global["MUSIC_OGG_UPDATE"] = true
    end
    if type(self.Global["PREVENTDUPE"]) ~= "boolean" then
        self:Msg(L["PreventDupeNotSet"])
        self.Global["PREVENTDUPE"] = true
    end
    if not self.Global["MOUNTS"] then
        self:Msg(L["NoMounts"])
        self.Global["MOUNTS"] = {}
    end
    if not self.Global["CUSTOM"] then
        self.Global["CUSTOM"] = {}
    end
    if type(self.Global["ENABLED"]) ~= "boolean" then
        -- Should be fired on first launch, set the saved variable to default value
        self:Msg(L["EnabledNotSet"])
        self.Global["ENABLED"] = true
    end

    self.SoundControl:Init()
    self.SoundControl:Check()

    -- [NEW] Check all songs and convert out-of-date ones to new format
    -- (Removing the Interface\\AddOns\\Chocobo\\music\\ part)
    self:MusicCheck()

    self:Msg((L["AddOnLoaded"]):format(self.Version))
    self:Msg(L["Enjoy"])
    self.Loaded = true
end

function C.Events.UNIT_AURA(self)
    if not self.Global["ENABLED"] then return end -- Return if addon is disabled
    self:DebugMsg((L["Event_UNIT_AURA"]):format("player"))
    if self.Loaded == false then
        -- This should NOT happen
        self:ErrorMsg(L["NotLoaded"])
        return
    end
    if self.Running then return end -- Return if the timer is already running.
    self.Running = true
    C_Timer.After(1, function() self:CheckMount() end)
end

function C.Events.PLAYER_LOGOUT(self)
    -- Save local copy of globals
    -- TODO: Is this redundant?
    _G["CHOCOBO"] = self.Global
end

function C:CheckMount()
    local mounted, mountName, _ = self:HasMount() -- Get mounted status and name of mount (if mounted)
    if IsMounted() or mounted then -- More efficient way to make it also detect flight form here?
        -- Print what mount the player is mounted on
        if mountName then self:DebugMsg((L["CurrentMount"]):format(mountName)) end
        self:DebugMsg(L["PlayerIsMounted"]) -- Print that the player is mounted
        -- TODO: Redundant to have both the above messages? Remove the second?
        -- Proceed if player is on one of the activated mounts or if allmounts (override) is true
        if mounted or self.Global["ALLMOUNTS"] then
            self:DebugMsg(L["PlayerOnHawkstrider"])
            if not self.Mounted then -- Check so that the player is not already mounted
                self.SoundControl:Check() -- Enable sound if disabled and the option is enabled
                self:DebugMsg(L["PlayingMusic"])
                self.Mounted = true
                -- Player mounted but mount is not recognised, check all buffs to find a match
                if type(mountName) ~= "string" then
                    local found = false
                    local index = 1
                    repeat
                        local name = UnitBuff("player", index, "PLAYER CANCELABLE")
                        if not name then break end -- No more buffs to check
                        if self.Global["CUSTOM"][name:lower()] then
                            self:PlayRandomMusic(name)
                            found = true
                        end
                        index = index + 1
                    until found or index > 40
                    if not found then self:PlayRandomMusic() end
                elseif self.Global["CUSTOM"][mountName:lower()] then
                    self:PlayRandomMusic(mountName)
                else
                    self:PlayRandomMusic()
                end
            else -- If the player has already mounted
                self:DebugMsg(L["AlreadyMounted"])
            end
        else -- Player is not on a hawkstrider
            self:DebugMsg(L["NoHawkstrider"])
        end
    elseif self.Mounted then -- When the player has dismounted
        self.SoundControl:Check() -- Disable sound if enabled and the option is enabled
        self:DebugMsg(L["NotMounted"])
        self.Mounted = false
        -- Note that StopMusic() will also stop any other custom music playing (such as from EpicMusicPlayer)
        StopMusic()
    end
    self.Running = false
end

function C:HasMount()
    local mountColl = {}

    for _, name in pairs(self.Mounts.Hawkstriders) do
        mountColl[#mountColl + 1] = name
    end

    if self.Global["PLAINSTRIDER"] then
        for _, name in pairs(self.Mounts.Plainstriders) do
            mountColl[#mountColl + 1] = name
        end
    end

    if self.Global["RIDINGCRANE"] then
        for _, name in pairs(self.Mounts.RidingCranes) do
            mountColl[#mountColl + 1] = name
        end
    end

    if self.Global["RAVENLORD"] then
        for _, name in pairs(self.Mounts.RavenLord) do
            mountColl[#mountColl + 1] = name
        end
    end

    if self.Global["FLAMETALON"] then
        for _, name in pairs(self.Mounts.Flametalon) do
            mountColl[#mountColl + 1] = name
        end
    end

    if self.Global["ALLMOUNTS"] then -- Add druid flight forms
        for _, name in pairs(self.Mounts.DruidForms) do
            mountColl[#mountColl + 1] = name
        end
    end

    if #self.Global["MOUNTS"] > 0 then
        for _, v in pairs(self.Global["MOUNTS"]) do
            mountColl[#mountColl + 1] = v -- Can be both a string and a number value
        end
    end

    for mountName, _ in pairs(self.Global["CUSTOM"]) do
        mountColl[#mountColl + 1] = mountName
    end

    return CLib:HasBuff(mountColl)
end

function C:MusicCheck()
    local matchString = "^" .. self.MusicDir -- Match the music dir path at the beginning of the string only.
    -- The substring has to start AFTER the matched string, adding one to the length.
    local length = self.MusicDir:len() + 1
    local updated = 0 -- Keep track of how many songs that had to update
    for i,v in ipairs(self.Global["MUSIC"]) do
        if v:match(matchString) then
            local change = v:sub(length, v:len()) -- A substring that includes only the filename (or subfolders, if any)
            self.Global["MUSIC"][i] = change
            self:Msg((L["SongUpdated"]):format(i, change))
            updated = updated + 1
        end
    end
    if updated > 0 then -- Print how many songs that were updated
        self:Msg((L["SongsUpdated"]):format(updated))
    else -- All songs up to date, no action needed
        self:Msg(L["SongsUpToDate"])
    end
end

-- If isMount is true, treat song as the mount name/ID
function C:PlayMusic(song, isMount)
    local songFile
    if isMount then
        song = song:lower()
        local mountSongs = self.Global.CUSTOM[song]
        if mountSongs and #mountSongs > 0 then
            local id = math.random(1, #mountSongs)
            songFile = mountSongs[id]
            if #mountSongs > 1 and self.Global["PREVENTDUPE"] and songFile == nowPlaying then
                while songFile == nowPlaying do
                    id = math.random(1, #mountSongs)
                    songFile = mountSongs[id]
                end
            end
            self:DebugMsg((L["PlayingSong"]):format(id, songFile))
        else
            self:ErrorMsg((L["CustomNotDefined"]):format(song))
            return
        end
        if type(songFile) ~= "string" then
            self:ErrorMsg((L["CustomSongNotFound"]):format(song))
            return
        end
    elseif type(song) == "string" then
        songFile = song
    else
        songFile = self.Global["MUSIC"][song]
        if not songFile then
            self:ErrorMsg(L["SongNotFound"])
            return false
        end
        self:DebugMsg((L["PlayingSong"]):format(song, songFile))
    end
    nowPlaying = songFile
    songFile = self.MusicDir .. songFile
    PlayMusic(songFile)
end

function C:PlayRandomMusic(mount)
    if mount then
        self:PlayMusic(mount, true)
    else
        local id = math.random(1, #self.Global["MUSIC"])
        if self.Global["PREVENTDUPE"] and #self.Global["MUSIC"] > 1 then
            local name = self.Global["MUSIC"][id]
            while name == nowPlaying do
                id = math.random(1, #self.Global["MUSIC"])
                name = self.Global["MUSIC"][id]
            end
        end
        self:PlayMusic(id)
    end
end

function C:AddMusic(songName) -- Add a song the the list
    songName = CLib:Trim(songName)
    if songName == "" or songName == nil then
        self:ErrorMsg(L["NoFile"])
        return false
    end
    for _,v in pairs(self.Global["MUSIC"]) do -- Loop through all the songs currently in the list and...
        if v == songName then -- ... make sure it isn't there already
            self:ErrorMsg(L["AlreadyExists"])
            return false
        end
    end
    table.insert(self.Global["MUSIC"], songName) -- Insert the song into list
    self:Msg((L["AddedSong"]):format(songName))
    return true
end

function C:RemoveMusic(list, songName) -- Remove a song from the list
    if type(list) ~= "table" then
        songName = list
        list = self.Global.MUSIC
    end
    if type(songName) == "number" then
        if list[songName] then
            local name = list[songName]
            table.remove(list, songName)
            self:Msg((L["RemovedSong"]):format(name))
            return true
        end
        return false
    end
    songName = CLib:Trim(songName)
    if songName == "" or songName == nil then
        self:ErrorMsg(L["NoFile"])
        return false
    end
    for i,v in ipairs(list) do -- Loop through all the songs in the list until...
        if v == songName then -- ... the desired one is found and then...
            table.remove(list, i) -- ... remove it from the list.
            self:Msg((L["RemovedSong"]):format(songName))
            return true
        end
    end
    self:ErrorMsg(L["SongNotFound"])
    return false
end

function C:GetCustomMusic(mount)
    mount = CLib:Trim(tostring(mount)):lower()

    if type(self.Global.CUSTOM[mount]) ~= "table" then
        self.Global.CUSTOM[mount] = {}
    end

    return self.Global.CUSTOM[mount]
end

function C:AddCustomMusic(song, mount)
    if song then
        song = CLib:Trim(tostring(song))
    end
    mount = mount:lower()
    if song == "" or type(song) ~= "string" then
        song = nil
        --self:ErrorMsg((L["AddCustomInvalidSong"]):format(tostring(song)))
        --return
    end
    if type(mount) ~= "string" or mount == "" then
        self:ErrorMsg((L["AddCustomInvalidMount"]):format(tostring(mount)))
        return
    end
    if self.Global.CUSTOM[mount] then
        if song and CLib:InTable(self.Global.CUSTOM[mount], song) then
            self:ErrorMsg((L["AddCustomExists"]):format(song, mount))
            return
        end
        if not song then return end
        table.insert(self.Global.CUSTOM[mount], song)
        self:Msg((L["AddCustomSuccess"]):format(song, mount))
    else
        self.Global.CUSTOM[mount] = {}
        if not song then return end
        table.insert(self.Global.CUSTOM[mount], song)
        self:Msg((L["AddCustomSuccess"]):format(song, mount))
    end
end

function C:RemoveCustomMusic(mount, song)
    mount = mount:lower()
    if type(mount) ~= "string" then
        self:ErrorMsg((L["RemoveCustomInvalidMount"]):format(tostring(mount)))
    end
    local list = self.Global.CUSTOM[mount]
    if list then
        if song then
            self:RemoveMusic(list, song)
        else
            wipe(list)
            self.Global.CUSTOM[mount] = nil
            self:Msg((L["RemoveCustomSuccess"]):format(mount))
        end
    else
        self:ErrorMsg((L["RemoveCustomNotExist"]):format(mount))
    end
end

function C:PrintMusic() -- Print all the songs currently in list to chat
    if #self.Global["MUSIC"] <= 0 then
        self:Msg(L["MusicListEmpty"])
    else
        for i,v in ipairs(self.Global["MUSIC"]) do
            self:Msg(("\124cff00CCFF%i: %s\124r"):format(i, v))
        end
    end

    if CLib:Count(self.Global["CUSTOM"]) <= 0 then
        return
    end

    self:Msg(L["PrintMusicCustomStart"])

    for k,v in pairs(self.Global["CUSTOM"]) do
        self:Msg((L["PrintMusicCustomHeader"]):format(k))
        for _,s in pairs(v) do
            self:Msg((L["PrintMusicCustomSong"]):format(s))
        end
    end
end

function C:ResetMusic() -- Resets the values in Chocobo.Global["MUSIC"] to default
    self:Msg(L["ResetMusic"])
    wipe(self.Global.MUSIC)
    for _,v in pairs(self.Songs) do -- Add all the default songs again
        self:AddMusic(v)
    end
end

function C:AddMount(mount)
    mount = CLib:Trim(mount)
    mount = tonumber(mount) or mount
    if mount == "" or mount == nil then
        self:ErrorMsg(L["NoMount"])
        return
    end
    local compare = tostring(mount):lower()
    for _,v in pairs(self.Global["MOUNTS"]) do
        if tostring(v):lower() == compare then
            self:ErrorMsg(L["MountAlreadyExists"])
            return
        end
    end
    table.insert(self.Global["MOUNTS"], mount)
    self:Msg((L["AddedMount"]):format(mount))
end

function C:RemoveMount(mount)
    if mount == "" or mount == nil then
        self:ErrorMsg(L["NoMount"])
        return
    end
    mount = mount:lower()
    for i,v in ipairs(self.Global["MOUNTS"]) do
        if v:lower() == mount then
            table.remove(self.Global["MOUNTS"], i)
            self:Msg((L["RemovedMount"]):format(mount))
            return
        end
    end
    self:ErrorMsg(L["MountNotFound"])
end

function C:PrintMounts()
    if #self.Global["MOUNTS"] <= 0 then
        self:Msg(L["MountListEmpty"])
    else
        for i,v in ipairs(self.Global["MOUNTS"]) do
            self:Msg(("\124cff00CCFF%i: %s\124r"):format(i, v))
        end
    end
end

function C:ResetMounts()
    self:Msg(L["ResetMounts"])
    wipe(self.Global.MOUNTS)
end

function C:FilterMount(filter, silent)
    if type(filter) == "nil" then filter = Chocobo.Global["ALLMOUNTS"] end
    if filter then
        if not silent then self:Msg(L["HawkstriderOnly"]) end
        self.Global["ALLMOUNTS"] = false
    else
        if not silent then self:Msg(L["AllMounts"]) end
        self.Global["ALLMOUNTS"] = true
    end
end

function C:ToggleDebug()
    self:Debug(not self.Global["DEBUG"], true)
end

function C:Debug(set, silent)
    if set == "enable" or set == "on" or set == true then
        if not silent then self:Msg(L["DebuggingEnabled"]) end
        self.Global["DEBUG"] = true
    elseif set == "disable" or set == "off" or set == false then
        if not silent then self:Msg(L["DebuggingDisabled"]) end
        self.Global["DEBUG"] = false
    elseif not silent then
        if self.Global["DEBUG"] then
            self:Msg(L["DebugIsEnabled"])
        else
            self:Msg(L["DebugIsDisabled"])
        end
    end
end

function C:PlainstriderToggle(silent)
    self.Global["PLAINSTRIDER"] = not self.Global["PLAINSTRIDER"]
    if silent then return end
    if self.Global["PLAINSTRIDER"] then
        self:Msg(L["PlainstriderTrue"])
    else
        self:Msg(L["PlainstriderFalse"])
    end
end

function C:RidingCraneToggle(silent)
    self.Global["RIDINGCRANE"] = not self.Global["RIDINGCRANE"]
    if silent then return end
    if self.Global["RIDINGCRANE"] then
        self:Msg(L["RidingCranesTrue"])
    else
        self:Msg(L["RidingCranesFalse"])
    end
end

function C:RavenLordToggle(silent)
    self.Global["RAVENLORD"] = not self.Global["RAVENLORD"]
    if silent then return end
    if self.Global["RAVENLORD"] then
        self:Msg(L["RavenLordTrue"])
    else
        self:Msg(L["RavenLordFalse"])
    end
end

function C:FlametalonToggle(silent)
    self.Global["FLAMETALON"] = not self.Global["FLAMETALON"]
    if silent then return end
    if self.Global["FLAMETALON"] then
        self:Msg(L["FlametalonTrue"])
    else
        self:Msg(L["FlametalonFalse"])
    end
end

function C:Toggle(silent) -- Toggle the AddOn on and off
    if self.Global["ENABLED"] then -- If the addon is enabled
        self.Global["ENABLED"] = false -- Disable it
        StopMusic()
        if not silent then self:Msg(L["AddOnDisabled"]) end -- Print status
    else -- If the addon is disabled
        self.Global["ENABLED"] = true -- Enable it
        if not silent then self:Msg(L["AddOnEnabled"]) end -- Print status
    end
end

function C:PreventDupeToggle(silent)
    if self.Global["PREVENTDUPE"] then
        self.Global["PREVENTDUPE"] = false
        if not silent then self:Msg(L["PreventDupeDisabled"]) end
    else
        self.Global["PREVENTDUPE"] = true
        if not silent then self:Msg(L["PreventDupeEnabled"]) end
    end
end

function C:GetGlobal(var)
    return self.Global[var]
end

function C:Msg(msg) -- Send a normal message
    DEFAULT_CHAT_FRAME:AddMessage(L["MsgPrefix"] .. msg)
end

function C:ErrorMsg(msg) -- Send an error message, these are prefixed with the word "ERROR" in red
    DEFAULT_CHAT_FRAME:AddMessage(L["ErrorPrefix"] .. msg)
end

-- Send a debug message, these are only sent when debugging is enabled and are prefixed by the word "Debug" in yellow
function C:DebugMsg(msg)
    if self.Global["DEBUG"] == true then
        DEFAULT_CHAT_FRAME:AddMessage(L["DebugPrefix"] .. msg)
    end
end

function C:GetVersion()
    return self.Version
end

-- Create the frame, no need for an XML file!
C.Frame = CreateFrame("Frame")
C.Frame:SetScript("OnEvent", function (frame, event, ...) C:OnEvent(frame, event, ...) end)
for k,_ in pairs(C.Events) do
    if k == "UNIT_AURA" then
        C.Frame:RegisterUnitEvent(k, "player")
    else
        C.Frame:RegisterEvent(k)
    end
end

for _, section in pairs(C.Mounts) do
    for id, _ in pairs(section) do
        section[id] = GetSpellInfo(id)
    end
end
