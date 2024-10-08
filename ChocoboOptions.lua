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

C.Options = {}

local CO = C.Options

local function check(name, parent, label, handler)
    local c = CreateFrame(
        "CheckButton",
        name,
        parent,
        "UICheckButtonTemplate")
    c:SetSize(40, 40)
    c:SetScript("OnClick", function(s)
        if (s:GetChecked()) then
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
        else
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
        end
        handler()
    end)
    c.label = _G[c:GetName() .. "Text"]
    c.label:SetText(label)
    return c
end

local function createList(parent, header, listGetter, addFunc, removeFunc, resetFunc)
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
        local items = self.items
        local buttons = HybridScrollFrame_GetButtons(self.ListScrollFrame)
        local offset = HybridScrollFrame_GetOffset(self.ListScrollFrame)

        for buttonIndex = 1, #buttons do
            local button = buttons[buttonIndex]
            local itemIndex = buttonIndex + offset

            if itemIndex <= #items then
                local item = items[itemIndex]
                button:SetID(itemIndex)
                button.Text:SetText(item)
                button:SetWidth(self.ListScrollFrame.scrollChild:GetWidth())
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

    HybridScrollFrame_SetDoNotHideScrollBar(list.ListScrollFrame, true)

    return list
end

local frame = CreateFrame("Frame")
CO.Frame = frame
frame:Hide()
frame.name = "Chocobo"
frame.refresh = function() CO:Update() end

frame.logo = frame:CreateTexture(nil, "ARTWORK")
frame.logo:SetBlendMode("BLEND")
frame.logo:SetTexture([[Interface\AddOns\Chocobo\images\chocobo.tga]])
frame.logo:SetSize(256, 512)
frame.logo:SetPoint("BOTTOMRIGHT", 0, -75)

frame.description = CreateFrame("Frame", nil, frame)
frame.description:SetSize(370, 30)
frame.description:SetPoint("TOP", 0, -10)
frame.description.label = frame.description:CreateFontString(nil, "OVERLAY")
frame.description.label:SetFont([[Fonts\FRIZQT__.TTF]], 12, "OUTLINE")
frame.description.label:SetPoint("TOPLEFT")
frame.description.label:SetPoint("BOTTOMRIGHT")
frame.description.label:SetTextColor(1, 0.8196079, 0)

frame.songs = createList(
    frame,
    L["SongsAndMounts_Songs"],
    function() return C.Global.MUSIC end,
    function(item) C:AddMusic(item) end,
    function(item) C:RemoveMusic(item) end,
    function() C:ResetMusic() end)
frame.songs:SetHeight(200)
frame.songs:SetPoint("TOP", 0, -40)
frame.songs:SetPoint("LEFT", 5, 0)
frame.songs:SetPoint("RIGHT", frame, "BOTTOM", -20, 0)

frame.mounts = createList(
    frame,
    L["SongsAndMounts_Mounts"],
    function() return C.Global.MOUNTS end,
    function(item) C:AddMount(item) end,
    function(item) C:RemoveMount(item) end,
    function() C:ResetMounts() end)
frame.mounts:SetPoint("TOP", frame.songs)
frame.mounts:SetPoint("LEFT", frame, "BOTTOM")
frame.mounts:SetPoint("RIGHT", -28, 0)
frame.mounts:SetPoint("BOTTOM", frame.songs)

frame.toggleMount = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleMount:SetSize(240, 38)
frame.toggleMount:SetPoint("TOP", 0, -250)
frame.toggleMount:SetScript("OnClick", function()
    Chocobo:FilterMount(nil, true)
    CO:Update()
end)
frame.toggleDebug = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleDebug:SetSize(240, 38)
frame.toggleDebug:SetPoint("TOP", 0, -293)
frame.toggleDebug:SetScript("OnClick", function()
    Chocobo:ToggleDebug(true)
    CO:Update()
end)
frame.toggleButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
frame.toggleButton:SetSize(240, 38)
frame.toggleButton:SetPoint("TOP", 0, -336)
frame.toggleButton:SetScript("OnClick", function()
    Chocobo:Toggle(true)
    CO:Update()
end)

frame.preventDupeToggle = check("ChocoboOptionsPreventDupeToggle", frame, L["Options_PreventDupeToggle"], function()
    Chocobo:PreventDupeToggle(true)
    CO:Update()
end)
frame.preventDupeToggle:SetPoint("BOTTOMLEFT", 20, 160)
frame.plainstriderToggle = check("ChocoboOptionsPlainstriderToggle", frame, L["Options_PlainstriderToggle"], function()
    Chocobo:PlainstriderToggle(true)
    CO:Update()
end)
frame.plainstriderToggle:SetPoint("BOTTOMLEFT", frame.preventDupeToggle, 0, -40)
frame.ravenLordToggle = check("ChocoboOptionsRavenLordToggle", frame, L["Options_RavenLordToggle"], function()
    Chocobo:RavenLordToggle(true)
    CO:Update()
end)
frame.ravenLordToggle:SetPoint("BOTTOMLEFT", frame.plainstriderToggle, 0, -40)
frame.flametalonToggle = check("ChocoboOptionsFlametalonToggle", frame, L["Options_FlametalonToggle"], function()
    Chocobo:FlametalonToggle(true)
    CO:Update()
end)
frame.flametalonToggle:SetPoint("BOTTOMLEFT", frame.ravenLordToggle, 0, -40)
frame.ridingCraneToggle = check("ChocoboOptionsRidingCraneToggle", frame, L["Options_RidingCraneToggle"], function()
    Chocobo:RidingCraneToggle(true)
    CO:Update()
end)
frame.ridingCraneToggle:SetPoint("BOTTOMLEFT", frame.flametalonToggle, 0, -40)

function CO:Open()
    Settings.OpenToCategory(frame.name)
end

function CO:Update()
    local AddOnState, MountState, DebugState
    local asColor
    local dColor
    if Chocobo.Global["ENABLED"] then
        AddOnState = L["Options_Enabled"]
        asColor = "00FF00"
    else
        AddOnState = L["Options_Disabled"]
        asColor = "FF0000"
    end
    if Chocobo.Global["ALLMOUNTS"] then
        MountState = L["Options_AllMounts"]
    else
        MountState = L["Options_Hawkstrider"]
    end
    if Chocobo.Global["DEBUG"] then
        DebugState = L["Options_Enabled"]
        dColor = "00FF00"
    else
        DebugState = L["Options_Disabled"]
        dColor = "FF0000"
    end
    frame.toggleButton:SetText((L["Options_AddOnState"]):format(asColor, AddOnState))
    frame.toggleMount:SetText(MountState)
    frame.toggleDebug:SetText((L["Options_DebugState"]):format(dColor, DebugState))
    frame.description.label:SetText((L["Options_Description"]):format(Chocobo:GetVersion()))
    frame.preventDupeToggle:SetChecked(Chocobo.Global["PREVENTDUPE"])
    frame.plainstriderToggle:SetChecked(Chocobo.Global["PLAINSTRIDER"])
    frame.ridingCraneToggle:SetChecked(Chocobo.Global["RIDINGCRANE"])
    frame.ravenLordToggle:SetChecked(Chocobo.Global["RAVENLORD"])
    frame.flametalonToggle:SetChecked(Chocobo.Global["FLAMETALON"])
end

frame:SetScript("OnShow", function() CO:Update() end)

frame.OnCommit = function() end
frame.OnDefault = function() end
frame.OnRefresh = function() CO:Update() end

local category = Settings.RegisterCanvasLayoutCategory(frame, C.Name)
category.ID = C.Name
Settings.RegisterAddOnCategory(category)
