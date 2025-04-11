Playerbots are programmed to respond to chat commands. The Multibot or Unbot (not actively maintained) addon is designed to handle most of the common chat commands for the player, but you may still have need for manual chat commands as you play. It is important to distinguish between "Altbots" and "Rndbots": Altbots are manually player-created bots on a normal account, whereas "Rndbots" and their accounts are automatically generated based on .conf settings. Rndbots will automatically gear themselves, apply talents, and roam the world whereas Altbots will not.

## Altbot Setup Commands

command | action
:---|:---
``.playerbots bot add [name1,name2,name3]`` | login altbots. Note that you are also able to login altbots from other accounts depending on your configurations.
``.playerbots bot addaccount [accountname]`` | login an entire account of altbots. Depending on your configurations you can login other accounts.
``.playerbots bot remove name1,name2,name3`` | logout altbots
``.playerbots bot add *`` |  login all altbots
``.playerbots bot remove *`` | logout all altbots
``maintenance`` | enable altbot to learn all available spells and skills, supplement consumables, enchant gear, and repair. Can also be used on rndbots, but they automatically do this. Whisper for an individual bot or use /p or /r to simultaneously target multiple bots.
``autogear`` | automatically gear your altbot, with quality based on your .conf settings AutoGearQualityLimit and AutoGearScoreLimit. Can also be used on rndbots, but they automatically do their own gear initilization upon level up.
``talents`` | check current spec of bot
``talents spec list`` | check specs available for the class
``talents spec [spec name]`` | force bot to change their talents to the chosen spec, see the .conf for list of spec names or whisper your bot "talents spec list". At this time it is highly advised to also use “reset botAI” after using this command.
``talents apply <link>`` | apply talents link to bot
``reset botAI`` | reset bot settings

## Party/Raid General Commands

command | action
:---|:---
``summon`` | summon bot to you (see .conf for different options to configure this command)
``release`` | release spirit when dead
``revive`` | revive when near a spirit healer
``leave`` | leave party
``attack`` | attack selected target
``follow`` | run toward player (/w for individual or /p or /r for party/raid)
``flee`` | run toward player ignoring everything else (/w for individual or /p or /r for party/raid)
``stay`` | stay in place
``runaway`` | kite mob
``grind`` | attack anything
``disperse set x`` | force bots to maintain a distance of x yards from each other
``give leader`` | if bot is party/raid leader it will pass it to their master

Furthermore, you can specify by group or type for some commands like "attack" and "follow", such as:
- "@group1 follow"
- "@group2 attack"
- "@tank follow"
- "@ranged attack"


## Playerbot Spell Commands

command | action
:---|:---
``spells`` | show bot's spells
``cast [spell_name]`` | /w a bot to cast a spell
``cast [spell_name] on [PlayerName]`` | /w a bot to cast a spell on a specified Player
``ss +[spell id]`` | add spell to ignored spells list
``ss -[spell id]`` | remove spell from ignored spells list
``trainer`` | show what bot can learn from the selected trainer
``trainer learn`` | learn from the selected trainer

## Party/Raid Target Selection

command | action
:---|:---
``rti <icon>`` | sets the target icon for the bot to prioritize (icons: skull, cross, circle, star, square, triangle, diamond, and moon)
``attack rti target`` | commands bots to attack their rti target
``<name/group> rtsc toggle`` | toggles the ability to point and click with mouse button to save a location for specified bots to move to, can specify by group or class (ie "@druid rtsc toggle" or "@group1 rtsc toggle")
``rtsc go save`` | command bots to move back into saved rtsc position
``rtsc cancel`` | cancel rtsc toggle
``rti cc <icon>`` | sets a specific icon as the cc target (the default is moon) 

Video demonstration:
https://www.youtube.com/watch?v=Pwt7schIC08

## Strategies

The bots are programmed to respond to triggers by listing possible actions and choosing one based on a strategy. Bots use two categories of strategies: combat and non-combat.  You can add, subtract, or toggle strategies using the combat (co) and non-combat (nc) prefixes in your commands:

```
co +strategy1,-strategy2,~strategy3
nc +strategy1,-strategy2,~strategy3
```

You can query the bot to report what strategies are currently being used:

```
co ?
nc ?
```


### Combat Strategies

strategy | description
:---|:---|
``tank`` | use threat-generating abilities (warrior, paladin, druid will use ``bear``)
``dps`` |  use dps abilities (rogue, hunter, shaman, priest, druid will use ``cat``)
``cc`` |  use cc abilities (requires cc rti target, default is moon icon; it is useful to know that bots will not attack rti target and will not try to use cc if target is not stunnable)
``caster`` | wasn't in docs but is in game
``assist`` | target one mob at a time
``aoe`` | target many mobs at a time
``boost`` | bots will use big cds (useful to use -boost and +boost on macros to control when to burst on bosses)
``threat`` | dps will actively avoid grabbing threat (useful for bosses that wipe aggro or if tanks are struggling to hold aggro)
``grind`` | attack any visible target, then switch to another one and so on.
``heal`` | focus on party healing (shaman, priest, druid, paladin)
``focus`` | stop casting aoe spell or debuff spells on multiple attackers (focus on the single target)
``avoid aoe`` | automatically avoid the majority of harmful aoe spells
``save mana`` | healers save mana by prioritizing high-efficiency spells when mana falls below a threshold
``healer dps`` | healers cast damage spells if they have enough mana
``tank face`` | ensure the current target does not face ranged players in the group (to counter breath and cleave-like spells)
``behind`` | move to the target's back (rear flank) when they are not positioned behind the target
``frost``, ``fire`` | mage only
``bear``, ``cat``, ``caster`` | druid only
``bdps`` | buff dps (paladin will use seal of might)
``bspeed`` | buff movement speed (hunter only)
``bhealth``, ``bmana`` | buff health or mana (paladin will use seal of light vs seal of wisdom)
``rfire``, ``rfrost``, ``rshadow``, ``rnature`` | resistance strategies (paladin auras and hunter aspects)


### Non-Combat Strategies

strategy | description
:---|:---
``food`` | initiate or stop eating/drinking
``pvp`` |  turn on or off pvp mode

### Raid-Specific Strategies

Note: These raid strategies are now automatically applied upon entering the instance. You should receive a whisper from your bots confirming activation.

strategy | description
:---|:---
mc | enable mc strats (Note: Baron Geddon only, rest are beatable without strats)
bwl | enable bwl strats (Note: only grants Onyxia Scale Cloak buff to all bots and enables automatic disabling of suppression devices)
aq20 | enable aq20 strats (Note: Ossirian only, rest are beatable without strats)
naxx | enable naxx strats (Note: only some bosses currently coded for at this stage, WIP on future bosses)
os | enable os strats (Note: strat is only functional up to OS+2, need to kill Vesperon first)
uld | enable uld strats (Note: Flame Leviathan and Razorscale only, WIP on future bosses)
icc | enable icc strats (Note: all normal mode currently doable, HC is WIP)


### Defaults

- Tank classes default w/ ``tank aoe``
- Non-tank classes default w/ ``attack weak``
- Strategies that are incompatible, such as ``stay`` and ``follow``, are ignored


## Loot

You can control which items to loot (``ll`` stands for loot list):

command | action
:---|:---
``nc +loot`` | activate looting (note ``grind`` strategy activates looting as well)
``ll all`` | loot everything
``ll normal`` | loot anything except BOP (bind-on-pickup) items
``ll gray`` | loot only gray items
``ll quest`` |  loot only quest items
``ll skill`` | loot only items based on their skills (herbalism, mining, or skinning)
``ll [item]`` | add specific item to loot list
``ll -[item]`` | remove specific item from loot list

## Items

command | action
:---|:---
``[item]`` | bot will tell you how many it has, and quest status
``e [item]`` | equip item
``ue [item]`` | unequip item
``u [item]`` | use item
``u [item] [target]`` | use item on target (use gem on item)
``open items`` | open items in inventory that have loot, ie Satchel of Spoils
``destroy [item]`` | destroy item
``s [item]`` | sell item
``s *`` | sell all grey items
``s vendor`` | sell all items that can be sold
``b [item]`` | buy item
``2g 3s 5c`` | give you gold
``bank [item]`` | deposit item in bank
``bank -[item]`` | withdraw item from back
``gb [item]`` | deposit item in guild bank
``gb -[item]`` | withdraw item from guild bank

## Quests

command | action
:---|:---
``quests`` | show quest summary
``quests all`` | shows a list with links of all quests in quest log
``accept [quest]`` | accept quest at the selected quest giver
``accept *`` | accept all quests at the selected quest giver
``drop [quest]`` | abandon quest
``r [item]`` | choose quest reward
``[quest]`` | show quest and objectives status
``talk`` | talk to the selected npc (to complete a quest)
``u [game object]`` | use game object (use "los" command to obtain the game object link)


## Miscellaneous Commands

command | action
:---|:---
``los`` | list game objects, items, creatures and npcs the bot can see
``stats`` | show stat summary (inventory, gold, xp, etc.)
``home`` | set home at the selected innkeeper
``playerbot bot initself`` | CAREFUL WITH THIS - re-rolls YOUR character
``playerbot bot list`` | lists your altbots (and your other characters you can add as bots if you have that enabled, but I'd be very careful if you do that as you can then re-roll your other characters using the init command)
``playerbot bot tweak`` | sets the tweakvalue (seems to be related to a config value that's no longer present and the variable it changes doesn't seem to actually do anything anymore)
``playerbot bot self`` | make yourself into a bot, you have to logout to turn this off, dont run it twice without doing so (it wont toggle it back off like its supposed to, it actually seems to apply multiple AI's onto yourself all fighting to do different things, sounds fun until it crashes the server)
``playerbot bot lookup`` | doesn't do anything but print out a useless usage message (which says you're supposed to give it a class parameter but doing so doesn't change anything because the function called is literally *just* the usage message there's no functionality there)
``.playerbots bot init=rare name1,name2,name3`` | respawn bot at your level with talents & rare gear (gearing currently bugged, recommend autogear instead)


## Overrides

You can override everything and instruct the bot to do something specific:

command | description
:---|:---|
``do attack`` | attack target
``do loot`` | loot target
``do attack my target`` | attack my target
``do add all loot`` | check every corpse and game object for loot

## Example Macros

To make bots flee with you from the danger:

```
/p reset
/p nc -stay,+follow,+passive
/p co +passive
/p do follow
```

To make bots follow you and assist you in attack:

```
/p nc -stay,+follow,-passive
/p co -passive
/p do follow
```

To make bots stay in place and assist you in attack:

```
/p nc -follow,+stay,+passive
/p co +passive
/p do stay
```

## Help

The bot can tell you all available commands it will accept:

```
/w help
```

## Reactions

The bots will automatically do certain things based on what the party leader is doing.

your action | bot reaction
:---|:---
accept a quest | bot will accept it as well
talk to a quest giver | bot will turn in his completed quests
use meeting stone | teleport using the stone
start using game object and interrupt | use the game object
open trade window | show inventory and start trading
invite to a party/raid | accept the invitation
start raid ready check | tell his ready status
mount/unmount | mount/unmount as well
go through a dungeon portal | follow into the dungeon


## Rndbot Console Only Commands

command | action
:---|:---
``playerbot pmon toggle`` | enables/disables the performance monitor
``playerbot pmon stack`` | displays the performance monitor, useful to show which actions/triggers cost the most performance
``playerbot rndbot reset`` | clears acore_playerbots.playerbots_random_bots table (seems to contain events) and requires server restart after
``playerbot rndbot stats`` | prints rndbot stats (numbers of rndbots per level, per class, etc)
``playerbot rndbot reload`` | reloads playerbots.conf
``playerbot rndbot update`` | triggers a "full tick" (call to RandomPlayerbotMgr::UpdateAIInternal())
``playerbot rndbot init`` | re-rolls the rndbots (useful when you've modified settings like min/max level, the spec probabilities, etc)
``playerbot rndbot clear`` | reset bots back to starting level (55 for Deathknight)
``playerbot rndbot levelup`` | level up all rndbots by 1
``playerbot rndbot refresh`` |  revives rndbots if dead, uses botAI->Reset(), rerolls gear, while keeping the same level
``playerbot rndbot teleport`` | teleports all bots to appropriate area for level
``playerbot rndbot revive`` | (BUGGED: will double number of rndbots) revive rndbot, refresh, and teleport (combo of "refresh" and "teleport")
``playerbot rndbot grind`` | (BUGGED: crashes server) teleport rndbot only if needed (needs more testing)
``playerbot rndbot change_strategy`` | re-roll whether bots are grinding or RPG'ing (based on AiPlayerbot.RandomBotRpgChance setting)



Special thanks to Whipowill for creating the original Playerbots Operators Manual https://github.com/whipowill/wow-addon-playerbots/blob/master/MANUAL.md, fuzz1111 for contributing many confirmed active commands, and Ky for testing many old and new commands.