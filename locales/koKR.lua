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

if GetLocale() == "koKR" then
	local L = _G["ChocoboLocale"]
	
    L["AddedSong"] = "|cff00CCFF%s|r 를 재생목록에 추가하였습니다." -- Needs review
    L["AddOnLoaded"] = "초코보 ver. %s가 성공적으로 로딩되었습니다. 환경설정은 /chocobo 를 입력해 주십시오." -- Needs review
    L["AlreadyExists"] = "음악이 이미 목록에 있습니다." -- Needs review
    L["AlreadyMounted"] = "이미 탈 것에 탑승중이며 음악이 재생되고 있습니다." -- Needs review
    L["CurrentMount"] = "현재 %q에 탑승 중입니다." -- Needs review
    L["DebugIsDisabled"] = "디버깅이 비활성되었습니다." -- Needs review
    L["DebugIsEnabled"] = "디버깅이 활성되었습니다." -- Needs review
    L["DisabledNotPlaying"] = "애드온이 비활성중이라 음악이 재생되지 않습니다." -- Needs review
    L["HawkstriderOnly"] = "매타조에 탑승할 때만 초코보를 재생합니다." -- Needs review
    L["HelpMessage1"] = "Commands:" -- Needs review
    L["HelpMessage10"] = "reset: 음악 목록을 초기화 (사용자가 설정한 모든 음악목록이 삭제됩니다.)" -- Needs review
    L["HelpMessage11"] = "debug: 디버그 상태 확인, 명령어 다음에 enable 또는 disable 입력" -- Needs review
    L["HelpMessage2"] = "options: GUI 보기" -- Needs review
    L["HelpMessage3"] = "allmounts: 탈 것 탑승시 항상 초코보 음악 재생" -- Needs review
    L["HelpMessage4"] = "hawkstrider: 매타조 탑승시에만 음악 재생" -- Needs review
    L["HelpMessage5"] = "toggle: 애드온 on/off" -- Needs review
    L["HelpMessage6"] = "<name of song> 추가 : 해당 이름의 음악파일을 추가합니다. (파일 확장자 포함)" -- Needs review
    L["HelpMessage7"] = "<name of song> 삭제 : 해당 이름의 음악파일을 제거합니다. (파일 확장자 포함)" -- Needs review
    L["HelpMessage8"] = "(삭제 명령은 시스템 내의 파일이 아니라 게임중 재생목록에 반영됩니다.)" -- Needs review
    L["HelpMessage9"] = "목록: 모든 음악파일의 목록을 표시합니다." -- Needs review
    L["NoHawkstrider"] = "플레이어가 매타조에 탑승하지 않았습니다." -- Needs review
    L["NoMusic"] = "재생목록이 비어있어 기본값으로 설정합니다." -- Needs review
    L["NotLoaded"] = "문제가 발생하여 애드온이 정상적으로 로딩되지 않았습니다." -- Needs review
    L["NotMounted"] = "플레이어가 탑승하지 않아 음악재생을 중지합니다." -- Needs review
    L["Options_Add"] = "추가" -- Needs review
    L["Options_AllMounts"] = "모든 탈 것에 탑승시 음악을 재생합니다." -- Needs review
    L["Options_Description"] = "애드온 활경설정|nv%s" -- Needs review
    L["Options_Disabled"] = "비활성화" -- Needs review
    L["Options_Enabled"] = "활성화" -- Needs review
    L["Options_Hawkstrider"] = "매타조 탑승시에만 음악을 재생합니다." -- Needs review
    L["Options_List"] = "목록" -- Needs review
    L["Options_RavenLordToggle"] = "까마귀 군주의 고삐(안주) 탑승 시 음악 재생" -- Needs review
    L["Options_Remove"] = "제거" -- Needs review
    L["Options_Reset"] = "재설정" -- Needs review
    L["Options_SongPanelDesc"] = "음악 추가/제거, 재설정 및 목록" -- Needs review

	setmetatable(L, {__index=ChocoboLocale_Default})
end
