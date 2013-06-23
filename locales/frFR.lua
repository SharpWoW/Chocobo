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

if GetLocale() == "frFR" then
    local L = _G["ChocoboLocale"]

    L["AddedMount"] = "|cff00CCFF%s|r ajouté à la liste des montures !" -- Needs review
    L["AddedSong"] = "|cff00CCFF%s|r ajouté à la liste des musiques !" -- Needs review
    L["AddMountSyntax"] = "Syntaxe : addmount <nom ou ID de la monture>" -- Needs review
    L["AddOnDisabled"] = "AddOn |cffFF0000DESACTIVE|r" -- Needs review
    L["AddOnEnabled"] = "AddOn |cff00FF00ACTIVE|r" -- Needs review
    L["AddOnLoaded"] = "La version %s de Chocobo a été chargée avec succès ! Tapez /chocobo pour les options" -- Needs review
    L["AddSyntax"] = "Syntaxe : add <nom de la chanson>" -- Needs review
    L["AllMounts"] = "Joue maintenant chocobo sur toutes les montures !" -- Needs review
    L["AllMountsNotSet"] = "Variable AllMounts non définie, mise à FALSE" -- Needs review
    L["AlreadyExists"] = "La chanson est déjà dans la liste" -- Needs review
    L["AlreadyMounted"] = "Le joueur était déjà sur une monture, la chanson déjà en lecture" -- Needs review
    L["Broker_Text"] = "Ouvrir les options de Chocobo" -- Needs review
    L["Broker_Version"] = "|cffFFFFFFBroker Chocobo v%s|r" -- Needs review
    L["CurrentMount"] = "%q est déjà votre monture actuelle" -- Needs review
    L["DebuggingDisabled"] = "Débogage désactivé !"
    L["DebuggingEnabled"] = "Débogage activé !"
    L["DebugIsDisabled"] = "Le débogage est désactivé"
    L["DebugIsEnabled"] = "Le débogage est activé"
    L["DebugNotSet"] = "La variable de débogage n'est pas définie, mise à FALSE" -- Needs review
    L["DebugPrefix"] = "|cff00FF00[Chocobo]|r |cffFFFF00DEBOGUAGE:|r " -- Needs review
    L["DisabledNotPlaying"] = "AddOn est actuellement désactivé, pas de musique en lecture" -- Needs review
    L["EnabledNotSet"] = "Variable Activé non définie, mise à TRUE" -- Needs review
    L["ErrorPrefix"] = "|cff00FF00[Chocobo]|r |cffFF0000ERREUR:|r " -- Needs review
    L["Event_UNIT_AURA"] = "Evènement UNIT_AURA Detecté (%s)" -- Needs review
    L["HawkstriderOnly"] = "Joue maintenant chocobo uniquement sur les hawkstriders !" -- Needs review
    L["HelpMessage1"] = "Commandes :" -- Needs review
    L["HelpMessage10"] = "reset : Remet la liste des chansons aux valeurs par défaut (CECI EFFACERA TOUTES LES CHANSONS PERSONNALISEES QUE VOUS AVEZ ENREGISTREES)" -- Needs review
    L["HelpMessage11"] = "debug : Vérifie l'état du débogage, tapez \"enable\" ou \"disable\" après la commande pour activer ou désactiver le débogage" -- Needs revieweds review
    L["HelpMessage13"] = "removemount <nom ou ID de la monture> : Enlève une monture de la liste des montures (montures ajoutées par l'utilisateur uniquement)" -- Needs review
    L["HelpMessage14"] = "listmounts : Liste toutes les montures ajoutées par l'utilisateur" -- Needs review
    L["HelpMessage15"] = "resetmounts : Réinitialise les montures ajoutées par l'utilisateur à DEFAULT (vide)" -- Needs review
    L["HelpMessage2"] = "options : Afficher l'interface graphique" -- Needs review
    L["HelpMessage3"] = "allmounts : jouer chocobo sur toutes les montures" -- Needs review
    L["HelpMessage4"] = "hawkstrider : ne jouer chocobo que sur les hawkstriders" -- Needs review
    L["HelpMessage5"] = "toggle : Active ou désactive l'AddOn" -- Needs review
    L["HelpMessage6"] = "add <nom de la chanson> : Ajoute un fichier son avec le nom spécifié (extension du fichier comprise)" -- Needs review
    L["HelpMessage7"] = "remove <nom de la chanson> : Supprime un fichier son avec le nom spécifié (extension du fichier comprise)" -- Needs review
    L["HelpMessage8"] = "(Veuillez noter que la commande remove ne supprimera pas le fichier du système, seulement de la liste de chansons dans le jeu)" -- Needs review
    L["HelpMessage9"] = "list : Liste toutes les chansons de la liste" -- Needs review
    L["InvalidCommand"] = "%q n'est pas une commande valide, merci de consulter la documentation sur AddOn pour une liste des commandes disponibles" -- Needs review
    L["MountAlreadyExists"] = "La monture est déjà dans la liste" -- Needs review
    L["MountListEmpty"] = "La liste des montures est vide" -- Needs review
    L["MountNotFound"] = "Impossible de trouver la monture spécifiée dans la liste" -- Needs review
    L["MsgPrefix"] = "|cff00FF00[Chocobo]|r "
    L["MusicListEmpty"] = "La liste des musiques est vide" -- Needs review
    L["NoFile"] = "Aucun fichier spécifié"
    L["NoHawkstrider"] = "Le joueur n'est pas sur un hawkstrider" -- Needs review
    L["NoMount"] = "Pas de monture spécifiée" -- Needs review
    L["NoMounts"] = "La liste des montures de l'utlisateur est vide, maintenant définie à DEFAULT (vide)" -- Needs review
    L["NoMusic"] = "La liste des musiques est vide, valeurs par défaut ajoutées" -- Needs review
    L["NotLoaded"] = "Quelque chose ne va pas, l'addon semble ne pas s'être chargé correctement" -- Needs review
    L["NotMounted"] = "Le joueur n'est pas sur une monture, arrêt de la musique" -- Needs review
    L["Options_Add"] = "Ajouter" -- Needs review
    L["Options_AddOnState"] = "AddOn est |cff%s%s|r" -- Needs review
    L["Options_AllMounts"] = "Musique sur |cffFFFFFFtoutes les montures|r" -- Needs review
    L["Options_DebugState"] = "Le débogage est |cff%s%s|r" -- Needs review
    L["Options_Description"] = "Page de configuration de Chocobo|nv%s" -- Needs review
    L["Options_Disabled"] = "désactivé"
    L["Options_Enabled"] = "activé"
    L["Options_Hawkstrider"] = "Musique sur les |cffFFFFFFhawkstriders uniquement|r" -- Needs review
    L["Options_List"] = "Liste"
    L["Options_MountPanelDesc"] = "Ajoute/supprime, réinitialise et liste les montures" -- Needs review
    L["Options_RavenLordToggle"] = "Joue de la musique quand le joueur est sur la monture Seigneur Corbeau (Anzu)" -- Needs review
    L["Options_Remove"] = "Supprimer" -- Needs review
    L["Options_Reset"] = "Réinitialiser" -- Needs review
    L["Options_SongPanelDesc"] = "Ajoute/supprime, réinitialise et liste les chansons"
    L["PlayerIsMounted"] = "Le joueur est sur une monture" -- Needs review
    L["PlayerOnHawkstrider"] = "Le joueur est sur un hawkstrider ou CHOCOBO_ALLMOUNTS est sur TRUE" -- Needs review
    L["PlayingMusic"] = "Joue de la Musique" -- Needs review
    L["PlayingSong"] = "Joue la chanson id |cff00CCFF%d|r (|cff00CCFF%s|r)" -- Needs review
    L["RavenLordFalse"] = "Ne joue plus chocobo sur Seigneur Corbeau (Anzu)" -- Needs review
    L["RavenLordNotSet"] = "Variable RavenLord non définie, mise à FALSE" -- Needs review
    L["RavenLordTrue"] = "Joue maintenant chocobo sur Seigneur Corbeau (Anzu)" -- Needs review
    L["RemovedMount"] = "|cff00CCFF%s|r enlevé de la liste des montures !" -- Needs review
    L["RemovedSong"] = "|cff00CCFF%s|r supprimé de la liste des musique !" -- Needs review
    L["RemoveMountSyntax"] = "Syntaxe : removemount <nom ou ID de la monture>" -- Needs review
    L["RemoveSyntax"] = "Syntaxe : remove <nom de la chanson>" -- Needs review
    L["ResetMounts"] = "Liste des montures de l'utilisateur réinitialisée à DEFAULT (vide)" -- Needs review
    L["ResetMusic"] = "Liste des musiques réinitialisée" -- Needs review
    L["SongNotFound"] = "Impossible de trouver la chanson spécifiée dans la liste" -- Needs review
    L["SoundControl_DefaultNote"] = "|cffFF0000Merci de noter que quand le mode par défaut est activé, tous les paramètres ci-dessous sont ignorés.|r" -- Needs review
    L["SoundControl_Music"] = "Musique" -- Needs review
    L["SoundControl_ToggleDefault"] = "Activer le mode par défaut" -- Needs review
	
	setmetatable(L, {__index=ChocoboLocale_Default})
end
