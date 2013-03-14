Chocobo!
========

A friend wanted me to make an addon that plays the chocobo theme when he mounts. Didn't see any of them around so I decided to make one myself!
The Chocobo addon will play a random (4 possible) chocobo theme song when you mount on a hawkstrider of any type.
You can also change it to play the song on any mount if you want or add specific mounts that it should play on (more about that further down).

The broker plugin made by Lothaer mysteriously disappeared from Curse, it is now included with Chocobo instead.

*If you have the old Broker_Chocobo plugin installed, please uninstall/disable it or it might conflict with the built-in plugin.*


*Available commands:*
Some commands have more details about them in the sections below.
 * */chocobo* - Shows a list of available commands.
 * */chocobo options* - Shows the GUI to change settings.
 * */chocobo allmounts* - Play song on any mount.
 * */chocobo hawkstrider* - Only play song when on a hawkstrider.
 * */chocobo toggle* - Toggle the AddOn on or off, will stop music if it's currently playing.
 * */chocobo debug [enable|disable]* - Enable or disable debugging, calling with no argument shows current debug status.
 * */chocobo add &lt;name of song&gt;* - Add a song.
 * */chocobo remove &lt:name of song&gt;* - Remove a song.
 * */chocobo list* - List songs.
 * */chocobo reset* - Reset song list to default.
 * */chocobo addmount &lt;name or ID of mount&gt;* - Add a mount.
 * */chocobo removemount &lt;name or ID of mount&gt;* - Remove a mount.
 * */chocobo listmounts* - List all mounts.
 * */chocobo resetmounts* - Reset mount list to default.
 * */chocobo soundcontrol* - Show help for soundcontrol.
 * */chocobo soundcontrol gui* - Show the Sound Control GUI for changing settings.
 * */chocobo soundcontrol toggle* - Toggle sound control on and off.
 * */chocobo soundcontrol default* - Toggle default mode on and off (more info about that below).
 * */chocobo soundcontrol music|sfx|ambience toggle|mount|nomount* - Toggle various options for music, sfx or ambience sound control.

Version 3.0
-----------

Version 3.0 of Chocobo has been released and brings a few major features with it.

The most obvious is the new Sound Control, it now allows for a lot more customization than just "Play music on mount, stop when not on mount".
You can access the new sound control options in the subcategory of "Chocobo" in *Game Menu (Escape key) -> Interface -> AddOns*.

In there you will find two checkboxes at the top and three tabbed panels below them.

The checkboxes are fairly straightforward:
 * *Enable sound control* - This is a global setting that will override any other sound control settings. If it's checked, sound control is in effect, otherwise it's not.
 * *Enable default mode* - When this is checked, sound control will behave like it used to, enabling music playback when you mount and disabling it when you dismount. This setting overrides any settings in the three panels.

The three available panels below allow for more customization.
All of these three panels have the same options available, the difference is that they affect three different "sound areas" in the game; *Music*, *SFX* and *Ambience*.

Below is a description of what the three different options mean:
 * *Enable music/SFX/ambience control* - Controls whether the AddOn should control the playback of music, SFX or ambienc.
 * *Music/SFX/Ambience enabled when mounted* - If this is checked, the respective sound will be enabled when you are mounted.
 * *Music/SFX/Ambience enabled when not mounted* - This works like the former option, except backwards! The respective sound will be enabled when you are not mounted.

Other changes include:
 * Complete rewrite of the slash command system, nothing that normal users should be affected by.

Customizing the AddOn
---------------------

*When adding a song, the file extension must be included when you add it. E.g: "mySong_.mp3_" instead of "mySong".*

You can add your own songs to be played when mounting. To do this, simply type */chocobo add &lt;name of song&gt;* where &lt;name of song&gt; is the name of the music file you want to add. The file must be located in *WoW\Interface\AddOns\Chocobo\music\*  and It can be of any filetype WoW supports.

To remove a song, type /chocobo remove &lt;name of song&gt;
To see a list of all songs, type /chocobo list
To reset the list to default, type /chocobo reset

Note that &lt;name of song&gt; should not contain the "Interface\AddOns\Chocobo\music\" part, only the name of the file, i.e "mySong.mp3" without quotes.

Adding your own mounts
----------------------

*New in v2.14!*

Feel like you want the addon to play on some additional mounts but not every single one? Well in Chocobo 2.14 it's possible!
When the AddOn is in "Hawkstrider Only" mode, in addition to the Hawkstriders, it will also play music if you mount on any of the mounts added in the list of user-defined mounts.

To add a mount to the list, type */chocobo addmount &lt:name or ID of mount&gt;*.
To remove it, type */chocobo removemount &lt:name or ID of mount&gt;*.
To list all mounts in the list, type */chocobo listmounts*.
To reset the list to default (empty), type */chocobo resetmounts*.

If supplying the name of a mount, you need to supply the *full name* of it.

You can get the ID of a mount by going to the mount *spell* on WoWHead and copying it into WoW.
The ID is the number after the "spell=" part in the URL: "wowhead.com/spell=*1234*".

It's also possible to do this through the GUI, just enter the same details in the second text field and use the corresponding buttons below it.

Controlling in-game sounds
--------------------------

*New in v2.17!*

Some users have expressed a wish for all sounds to be disabled and for music to only be enabled when actually mounting something.
This feature has been added in v2.17!
To enable this, use the command */chocobo soundcontrol* (Aliases: *sc*, *sndctrl*), this will toggle the addon between controlling in-game sounds or leaving them as they are.

When sound control is enabled, all sounds (including music) will be disabled. When you mount on any of the currently enabled mounts, music will be enabled and a random song will play just like it does in its normal mode.

*Please note that* if your music volume is set to **0** when mounting with sound control enabled, the AddOn will automatically set the music volume to maximum (1.0, or 100%). If the music volume is at anything other than 0, it will be left unmodified.

If you're not the guy who likes typing long slash commands all day long, you can also bring up a GUI with a simple button to toggle it.
Bring up the normal options window by typing */chocobo options* or by using the Broker plugin and then go to *"Sound Control"*. When you're done, exit the options and everything will be saved.

Custom songs per-mount
----------------------

**New in v3.7!**

Do you have special mounts, that should also have special songs associated with them, as opposed to the normal songs used for all your other mounts?
This is possible to do in v3.7!

Say that you want "HorseAwesomeness.mp3" to play when you mount the Brown Horse, you can do this in one of two ways:

### Using Commands

*/chocobo addcustom "&lt;MountName&gt;" "&lt;SongName&gt;"*
Where *&lt;MountName&gt;* is the name of the mount you want to add music to, and *&lt;SongName&gt;* is the song file.
In our example, the result would be:
*/chocobo addcustom "Brown Horse" "HorseAwesomeness.mp3"*

*Note that %lt;MountName&gt; and &lt;SongName&gt; MUST be enclosed in quotation marks.*

### Using Interface Options

The other option is to use the interface options, simply navigate to *Chocobo -> Custom Songs* and use the two textboxes to specify song and mount name, then use the buttons to add, remove or list songs.

Localization
------------

Localization support has been added in v2.6-beta, if you want to help with localizing, please visit [the localization page on CurseForge][localization].

I found a bug!
--------------

Report any bugs you find on [the issues page][issues]!

Thanks to...
------------

Thanks to *Flurdy* for giving me the idea to make this AddOn (he's the "friend" I talk about at the top there), hi Flur!

Thanks to the following people for providing code suggestions:
 * ITSBTH
 * Tinyash (Ashik)

[localization]: http://wow.curseforge.com/addons/chocobo/localization/
[issues]: https://github.com/Sharparam/Chocobo/issues
