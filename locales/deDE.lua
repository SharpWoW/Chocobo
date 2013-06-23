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

if GetLocale() == "deDE" then
	local L = _G["ChocoboLocale"]
	
	L["AddedSong"] = "|cff00CCFF%s|r wurde zu der Musik-Liste hinzugefügt! " -- Needs review
    L["AddOnDisabled"] = "AddOn |cffFF0000DEAKTIVIERT|r"
    L["AddOnEnabled"] = "AddOn |cff00FF00AKTIVIERT|r"
    L["AddOnLoaded"] = "Chocobo Version %s wurde erfolgreich geladen! Verwenden Sie /chocobo für Optionen" -- Needs review
    L["AddSyntax"] = "Syntax: add <Name des Songs>" -- Needs review
    L["AllMounts"] = "Jetzt spielen chocobo auf alle Mounts!" -- Needs review
    L["AllMountsNotSet"] = "AllMounts Variable nicht gesetzt, Einstellung AllMounts Variable ist FALSE" -- Needs review
    L["AlreadyExists"] = "Song bereits vorhanden" -- Needs review
    L["AlreadyMounted"] = "Spieler ist bereits im Sattel, Lied spielt bereits" -- Needs review
    L["CurrentMount"] = "Festgestellt dass %q ist Ihr aktueller Sattel" -- Needs review
    L["DebuggingDisabled"] = "Debugging deaktiviert!" -- Needs review
    L["DebuggingEnabled"] = "Debugging aktiviert!" -- Needs review
    L["DebugIsDisabled"] = "Debugging ist deaktiviert" -- Needs review
    L["DebugIsEnabled"] = "Debugging ist aktiviert" -- Needs review
    L["DebugNotSet"] = "Debug-Variable nicht gesetzt, Debug-Variable eingestellt auf FALSE" -- Needs review
    L["DebugPrefix"] = "|cff00FF00[Chocobo]|r |cffFFFF00DEBUG:|r "
    L["DisabledNotPlaying"] = "AddOn ist deaktiviert, Musik wird nicht abgespielt" -- Needs review
    L["EnabledNotSet"] = "Variable Enabled nicht gesetzt, Variable Enabled eingestellt auf TRUE"
    L["Enjoy"] = "Genießen Sie Ihren Chocobo!" -- Needs review
    L["ErrorPrefix"] = "|cff00FF00[Chocobo]|r |cffFF0000FEHLER:|r "
    L["Event_UNIT_AURA"] = "UNIT_AURA Event erkannt (%s)"
    L["HawkstriderOnly"] = "Jetzt spielen chocobo auf Falkenschreiter nur!" -- Needs review
    L["HelpMessage1"] = "Befehle:" -- Needs review
    L["HelpMessage10"] = "reset: Zurücksetzen auf Songliste auf Standardwerte (DIES WIRD ALLE SONGS CUSTOM Sie eingestellt haben)" -- Needs review
    L["HelpMessage11"] = "debug: Debug-Check Status, Typ \"enable\" oder zu \"disable\", nachdem zu aktivieren oder deaktivieren Sie das Debuggen" -- Needs review
    L["HelpMessage2"] = "options: Zeige die GUI" -- Needs review
    L["HelpMessage3"] = "allmounts: Chocobo Song spielen auf jedem mount" -- Needs review
    L["HelpMessage4"] = "hawkstrider: nur spielen Chocobo Song auf Falkenschreiter" -- Needs review
    L["HelpMessage5"] = "toggle: Drücken Sie die AddOn-und ausschalten" -- Needs review
    L["HelpMessage6"] = "add <Name des Liedes>: Fügt eine Musikdatei mit dem angegebenen Namen (einschließlich Dateierweiterung)" -- Needs review
    L["HelpMessage7"] = "remove <Name des Liedes>: Entfernt eine Musikdatei mit dem angegebenen Namen (einschließlich Dateierweiterung)" -- Needs review
    L["HelpMessage8"] = "(Beachten Sie, dass die Entfernen-Befehl löscht nicht die Datei aus dem System, nur aus der Song-Liste ingame)" -- Needs review
    L["HelpMessage9"] = "list: Liste aller Songs in der Song-Liste" -- Needs review
    L["MsgPrefix"] = "|cff00FF00[Chocobo]|r "
    L["NoFile"] = "Keine Datei angegeben" -- Needs review
    L["NoHawkstrider"] = "Der Spieler ist nicht auf einem Falkenschreiter" -- Needs review
    L["NoMusic"] = "Musik-Liste leer ist, indem die Standardwerte" -- Needs review
    L["NotLoaded"] = "Irgend etwas stimmt nicht, tut Addon offenbar nicht richtig eingelegt haben" -- Needs review
    L["NotMounted"] = "Spieler nicht montiert, Anhalten Musik" -- Needs review
    L["Options_Add"] = "Hinzufügen" -- Needs review
    L["Options_AddOnState"] = "AddOn ist |cff%s%s|r" -- Needs review
    L["Options_AllMounts"] = "Musik auf |cffFFFFFFallen Mounts|r" -- Needs review
    L["Options_DebugState"] = "Debugging ist |cff%s%s|r" -- Needs review
    L["Options_Description"] = "Konfigurieren Sie die AddOn!|n%s" -- Needs review
    L["Options_Disabled"] = "deaktiviert"
    L["Options_Enabled"] = "aktiviert"
    L["Options_Hawkstrider"] = "Musik auf |cffFFFFFFFalkenschreiter nur|r" -- Needs review
    L["Options_List"] = "Auflisten" -- Needs review
    L["Options_RavenLordToggle"] = "Abspielen von Musik bei der Montage Rabenfürsten (Anzu)" -- Needs review
    L["Options_Remove"] = "Entfernen" -- Needs review
    L["Options_Reset"] = "Reset" -- Needs review
    L["Options_SongPanelDesc"] = "Hinzufügen/Entfernen, Reset und Lieder Liste" -- Needs review
    L["PlayerIsMounted"] = "Spieler ist montiert" -- Needs review
    L["PlayerOnHawkstrider"] = "Spieler befindet sich auf einem Falkenschreiter oder CHOCOBO_ALLMOUNTS auf true gesetzt" -- Needs review
    L["PlayingMusic"] = "Wiedergeben von Musik" -- Needs review
    L["PlayingSong"] = "Abspielen song mit id |cff00CCFF%d|r (|cff00CCFF%s|r)" -- Needs review
    L["RavenLordFalse"] = "Nicht Abspielen von Musik auf Rabenfürsten (Anzu)" -- Needs review
    L["RavenLordNotSet"] = "Ravenlord Variable nicht gesetzt, Einstellung Ravenlord Variable auf FALSE" -- Needs review
    L["RavenLordTrue"] = "Jetzt Abspielen von Musik auf Rabenfürsten (Anzu)" -- Needs review
    L["RemovedSong"] = "Entfernt |cff00CCFF%s|r aus dem Musik-Liste!" -- Needs review
    L["RemoveSyntax"] = "Syntax: remove songName" -- Needs review
    L["ResetMusic"] = "Zurücksetzen Musik Liste zum ursprünglichen" -- Needs review
    L["SongNotFound"] = "Kann das angegebene Lied in der Liste finden" -- Needs review
    L["SoundControl_Ambience"] = "Atmosphäre" -- Needs review
    L["SoundControl_AmbienceDesc"] = "Einstellungen für Atmosphären playback" -- Needs review
    L["SoundControl_AmbienceEnable"] = "Aktiviere Atmösphären Einstellungen" -- Needs review
    L["SoundControl_AmbienceMount"] = "Atmosphäre aktiviert, wenn gesattelt" -- Needs review
    L["SoundControl_AmbienceNoMount"] = "Atmosphäre aktiviert, wenn nicht gesattelt" -- Needs review
    L["SoundControl_MusicMount"] = "Musik aktiviert, wenn gesattelt" -- Needs review
    L["SoundControl_MusicNoMount"] = "Musik aktiviert, wenn nicht gesattelt" -- Needs review
    L["SoundControl_SFX"] = "SFX" -- Needs review
    L["SoundControl_Toggle"] = "Aktiviere Sound Steuerung" -- Needs review
    L["SoundControl_ToggleDefault"] = "Aktiviere Standard Modus" -- Needs review

	setmetatable(L, {__index=ChocoboLocale_Default})
end
