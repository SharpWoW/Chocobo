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

if GetLocale() == "esES" then
	local L = _G["ChocoboLocale"]
	
	L["AddedMount"] = "¡|cff00CCFF%s|r agregado a la lista de monturas!"
    L["AddedSong"] = "¡|cff00CCFF%s|r agregado a la lista de música!"
    L["AddMountSyntax"] = "Sintaxis: addmount <nombre o ID de la montura>" -- Needs review
    L["AddOnDisabled"] = "Extensión |cffFF0000DESACTIVADA|r"
    L["AddOnEnabled"] = "Extensión |cff00FF00ACTIVADA|r"
    L["AddOnLoaded"] = "¡Chocobo% s se ha cargado con éxito! Usa /chocobo para las opciones"
    L["AddSyntax"] = "Sintaxis: add <nombre de la canción>"
    L["AllMounts"] = "¡Reproduciendo chocobo en todas las monturas!"
    L["AllMountsNotSet"] = "El AllMounts variable no está ajustado, configurando el AllMounts variable a FALSE"
    L["AlreadyExists"] = "La canción ya está en la lista"
    L["AlreadyMounted"] = "El jugador ya estuba sobre una montura, la canción se está reproduciendo"
    L["Broker_Text"] = "Abrir las opciones de Chocobo" -- Needs review
    L["CurrentMount"] = "Se encontró que %q es tu montura actual"
    L["DebuggingDisabled"] = "¡Depuración desactivada!"
    L["DebuggingEnabled"] = "¡Depuración activada!"
    L["DebugIsDisabled"] = "Depuración desactivado"
    L["DebugIsEnabled"] = "Depuración activado"
    L["DebugNotSet"] = "El variable \"Debug\" no está ajustado, configurando el variable a FALSE"
    L["DebugPrefix"] = "|cff00FF00[Chocobo]|r |cffFFFF00DEPURACIÒN:|r "
    L["DisabledNotPlaying"] = "Extensión desactivada, no se está reproduciendo música"
    L["EnabledNotSet"] = "El variable \"Enable\" no está ajustado, configurando el variable a TRUE"
    L["Enjoy"] = "¡Disfruta tu chocobo!"
    L["ErrorPrefix"] = "|cff00FF00[Chocobo]|r |cffFF0000ERROR:|r "
    L["Event_UNIT_AURA"] = "UNIT_AURA Evento Detectado (%s)"
    L["HawkstriderOnly"] = "¡Ahora reproduciendo música solamente para halcónes zancudo!"
    L["HelpMessage1"] = "Commandos:" -- Needs review
    L["HelpMessage10"] = "reset: Restablece a la lista de canciones predeterminadas (ESTO BORRARÁ CUALQUIER CANCIÓNES PERSONALIZADAS QUE HAYAS HECHO)" -- Needs review
    L["HelpMessage11"] = "debug: comprobando el estatus de depuración, escribe \"enable\" o \"disable\" para después activar o desactivar depuración" -- Needs review
    L["HelpMessage13"] = "removemount <nombre o ID de la montura>: Remueve una montura de la lista de monturas (sólo para monturas agregadas por usuarios)" -- Needs review
    L["HelpMessage14"] = "listmounts: Lista todos las monturas agregadas por los usuarios"
    L["HelpMessage15"] = "reset: Reestableciendo la lista de monturas por el usuario a forma predeterminada (vacío)" -- Needs review
    L["HelpMessage16"] = "soundcontrol: Varios ajustes para los controles de sonido. Escribe /chocobo SoundControl para usar." -- Needs review
    L["HelpMessage2"] = "options: Muestra la interfaz gráfica" -- Needs review
    L["HelpMessage3"] = "allmounts: reproduce canciones chocobo en cualquire montura" -- Needs review
    L["HelpMessage4"] = "hawkstrider: sólo reproduce canciones chocobo en halcones zancudo" -- Needs review
    L["HelpMessage5"] = "toggle: Activa o desactiva la extensión "
    L["HelpMessage6"] = "add <nombre de la canción> Agrega un archivo de música con el nombre especificado (incluyendo la extensión de formato)"
    L["HelpMessage7"] = "remove <nombre de la canción>: Remueve un archivo de música con el nombre especificado (incluyendo la extensión de formato)"
    L["HelpMessage8"] = "(Ten en cuenta que el comando no removerá el archivo del sistema, sólo de la lista en el juego)" -- Needs review
    L["HelpMessage9"] = "list: Lista todas las canciones en la lista de canción" -- Needs review
    L["MountAlreadyExists"] = "La montura ya está en la lista" -- Needs review
    L["MountNotFound"] = "No se puede encontrar la montura especificada en la lista" -- Needs review
    L["MsgPrefix"] = "|cff00FF00[Chocobo]|r "
    L["NoFile"] = "Ningún archivo especificado"
    L["NoHawkstrider"] = "El jugador no está montado en un halcón zancudo"
    L["NoMount"] = "Ninguna montura especificada" -- Needs review
    L["NoMounts"] = "Lista de monturas por el usuario está vacía, configurando a valores predeterminados (vacío)" -- Needs review
    L["NoMusic"] = "La lista de música esta vacía, agregando valores predeterminados"
    L["NotLoaded"] = "Algo está mal, la extención no parece que ha se cargado correctamente"
    L["NotMounted"] = "El jugador no está montado, deteniendo la música "
    L["Options_Add"] = "Agregar"
    L["Options_AddOnState"] = "La extensión está |cff%s%s|r"
    L["Options_AllMounts"] = [=[Música en |cffFFFFFFtodas las monturas|r
    ]=]
    L["Options_DebugState"] = "Depuración está |cff%s%s|r"
    L["Options_Description"] = "Página de configuración para Chocobo|n%s"
    L["Options_Disabled"] = "desactivado"
    L["Options_Enabled"] = "activado"
    L["Options_Hawkstrider"] = "Música |cffFFFFFFsolamente en halcones zancudo|r" -- Needs review
    L["Options_List"] = "Lista"
    L["Options_MountPanelDesc"] = "Agregar/Remover, reestablecer y listar "
    L["Options_RavenLordToggle"] = "Reproduciendo música al montar Lord Cuervo (Anzu)" -- Needs review
    L["Options_Remove"] = "Quitar" -- Needs review
    L["Options_Reset"] = "Reiniciar" -- Needs review
    L["Options_SongPanelDesc"] = "Agregar/Quitar, reiniciar y listar canciones" -- Needs review
    L["RavenLordFalse"] = "No se está reproduciendo música con Lord Curevo (Anzu)" -- Needs review
    L["RemovedMount"] = "¡|cff00CCFF%s|r removido de la lista de monturas!"
    L["RemoveMountSyntax"] = "Sintaxis: removemount <nombre o ID de la montura>" -- Needs review
    L["ResetMounts"] = "Reestableciendo la lista de monturas por el usuario a DEFAULT (vacío)" -- Needs review
	
	setmetatable(L, {__index=ChocoboLocale_Default})
end
