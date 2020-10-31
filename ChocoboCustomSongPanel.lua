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

local L = _G["ChocoboLocale"]

local C = Chocobo

C.CustomSongPanel = {}

local CSP = C.CustomSongPanel

local function createList(parent, header, listGetter, addFunc, removeFunc, resetFunc, itemClickFunc)
    local list = CreateFrame("Frame", nil, parent, "ChocoboSongsAndMountsListTemplate")
    list.items = {}
    list.Header:SetText(header)
    list.AddButton:SetText(L["Options_Add"])
    list.AddButton:SetScript("OnClick", function()
        local item = list.EditBox:GetText()
        addFunc(item)
        list:RefreshLayout()
        list.EditBox:SetText("")
    end)
    list.ResetButton:SetText(L["Options_Reset"])
    list.ResetButton:SetScript("OnClick", function()
        resetFunc()
        list:RefreshLayout()
    end)
    list.ListScrollFrame.update = function() list:RefreshLayout() end
    list:SetScript("OnShow", function(self)
        self.items = listGetter()
        HybridScrollFrame_CreateButtons(self.ListScrollFrame, "ChocoboSongsAndMountsItemTemplate")
        self:RefreshLayout()
    end)
    function list:RemoveItem(index)
        local item = listGetter()[index]
        removeFunc(item)
        self:RefreshLayout()
    end
    function list:RefreshLayout()
        local items = listGetter()

        if items then
            self.EditBox:Enable()
            self.AddButton:Enable()
        else
            self.EditBox:Disable()
            self.AddButton:Disable()
            items = {}
        end

        local buttons = HybridScrollFrame_GetButtons(self.ListScrollFrame)
        local offset = HybridScrollFrame_GetOffset(self.ListScrollFrame)

        for buttonIndex = 1, #buttons do
            local button = buttons[buttonIndex]
            local itemIndex = buttonIndex + offset

            button:UnlockHighlight()

            if itemIndex <= #items then
                local item = items[itemIndex]
                button:SetID(itemIndex)
                button.Text:SetText(item)
                button:SetWidth(self.ListScrollFrame.scrollChild:GetWidth())
                if itemClickFunc then
                    button:SetScript("OnClick", function(btn)
                        for _, b in pairs(buttons) do b:UnlockHighlight() end
                        btn:LockHighlight()
                        itemClickFunc(item)
                    end)
                end
                button:Show()
            else
                button:Hide()
            end
        end

        local buttonHeight = self.ListScrollFrame.buttonHeight
        local totalHeight = #items * buttonHeight
        local shownHeight = #buttons * buttonHeight

        HybridScrollFrame_Update(self.ListScrollFrame, totalHeight, shownHeight)
    end
    function list:ClearHighlights()
        local buttons = HybridScrollFrame_GetButtons(self.ListScrollFrame)
        for _, btn in pairs(buttons) do
            btn:UnlockHighlight()
        end
    end

    HybridScrollFrame_SetDoNotHideScrollBar(list.ListScrollFrame, true)

    return list
end

local frame = CreateFrame("Frame")
CSP.Frame = frame
frame:Hide()
frame.name = "Custom Songs"
frame.parent = "Chocobo"
frame.refresh = function() CSP:Update() end

frame.description = CreateFrame("Frame", nil, frame)
frame.description:SetSize(600, 25)
frame.description:SetPoint("TOP", 0, -10)
frame.description.label = frame.description:CreateFontString(nil, "OVERLAY", nil)
frame.description.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.description.label:SetText("%CUSTOMSONG_DESCRIPTION%")
frame.description.label:SetPoint("TOPLEFT")
frame.description.label:SetPoint("BOTTOMRIGHT")
frame.description.label:SetTextColor(1, 0.8196079, 0)
frame.description.label:SetText(L["CustomSongPanel_Description"])

frame.mounts = createList(
    frame,
    L["SongsAndMounts_Mounts"],
    function()
        local items = {}
        for k, _ in pairs(C.Global.CUSTOM) do
            items[#items + 1] = k
        end
        sort(items)
        return items
    end,
    function(item)
        C:AddCustomMusic(nil, item)
        frame.songs:Clear()
    end,
    function(item)
        C:RemoveCustomMusic(item)
        frame.songs:Clear()
    end,
    function() end,
    function(item)
        frame.songs.mount = item
        frame.songs:RefreshLayout()
        frame.songs.Header:SetText(L["SongsAndMounts_SongsForMount"]:format(item))
    end)
frame.mounts:SetPoint("TOP", frame.description, "BOTTOM")
frame.mounts:SetPoint("LEFT", 5, 0)
frame.mounts:SetPoint("RIGHT", frame, "BOTTOM", -20, 0)
frame.mounts:SetPoint("BOTTOM", 0, 5)
frame.mounts.ResetButton:Disable()

frame.songs = createList(
    frame,
    L["SongsAndMounts_Songs"],
    function()
        local mount = frame.songs.mount
        if not mount then return nil end
        return C:GetCustomMusic(mount)
    end,
    function(item)
        local mount = frame.songs.mount
        if not mount then return end
        C:AddCustomMusic(item, mount)
    end,
    function(item)
        local mount = frame.songs.mount
        if not mount then return end
        C:RemoveCustomMusic(mount, item)
    end,
    function()
        local mount = frame.songs.mount
        if not mount then return end
        C:RemoveCustomMusic(mount)
        frame.mounts:RefreshLayout()
    end)
frame.songs:SetPoint("TOP", frame.mounts, "TOP")
frame.songs:SetPoint("LEFT", frame, "BOTTOM")
frame.songs:SetPoint("RIGHT", -25, 0)
frame.songs:SetPoint("BOTTOM", frame.mounts, "BOTTOM")
function frame.songs:Clear()
    self.mount = nil
    self.Header:SetText(L["SongsAndMounts_Songs"])
    self:RefreshLayout()
end

function CSP:Update()
    frame.mounts:ClearHighlights()
    frame.songs.mount = nil
    frame.songs.Header:SetText(L["SongsAndMounts_Songs"])
    frame.songs:RefreshLayout()
end

frame:SetScript("OnShow", function() CSP:Update() end)

InterfaceOptions_AddCategory(frame)
