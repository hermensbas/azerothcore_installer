Playerbots are programmed to respond to chat commands. The Unbot addon is designed to handle most of the common chat commands for the player, but you may still have need for manual chat commands as you play. It is important to distinguish between "Altbots" and "Rndbots": Altbots are manually player-created bots on a normal account, whereas "Rndbots" and their accounts are automatically generated based on .conf settings. Rndbots will automatically gear themselves, apply talents, and roam the world whereas Altbots will not.

## Altbot Setup Commands

command | action
:---|:---
``.playerbots bot add name1,name2,name3`` | login altbots. You can login an entire account at once by using the account name instead of character name if they are in your guild, given you have the corresponding config settings set to 1. Note that you are also able to login altbots from other accounts depending on your configurations.
``.playerbots bot remove name1,name2,name3`` | logout altbots
``.playerbots bot add *`` |  login all altbots
``.playerbots bot remove *`` | logout all altbots
``maintenance`` | enable altbot to learn all available spells and skills, supplement consumables, enchant gear, and repair. Can also be used on rndbots, but they automatically do this. Whisper for an individual bot or use /p or /r to simultaneously target multiple bots.
``autogear`` | automatically gear your altbot, with quality based on your .conf settings AutoGearQualityLimit and AutoGearScoreLimit. Can also be used on rndbots, but they automatically do this upon level up.
``talents spec [spec] pve`` | force altbot (or rndbot) to change their talents to the chosen spec, see the .conf for list of spec shortnames. At this time it is highly advised to also use “reset botAI” after using this command.
``reset botAI`` | reset bot settings
``.playerbots bot init=rare name1,name2,name3`` | respawn bot at your level with talents & rare gear (gearing currently bugged, recommend autogear instead)

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
``rtsc`` | similar to the position/go commands, but adds spell to your spell book which can be used to set the positions. For now it is recommend to use "position"/"go" instead as they work more reliably

Furthermore, you can specify by group or type for some commands like "attack" and "follow", such as:
- "@group1 follow"
- "@group2 attack"
- "@tank follow"
- "@ranged attack"

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
``caster`` | wasn't in docs but is in game
``assist`` | target one mob at a time
``aoe`` | target many mobs at a time
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
mc | enable mc strats (Note: Baron Geddon only)
bwl | enable bwl strats - can type in chat as shorthand for "co +bwl nc +bwl" (currently grants Onyxia Scale Cloak buff to all bots and enables automatic disabling of suppression devices)
aq20 | enable aq20 strats (Note: Ossirian only)
naxx | enable naxx strats - can type in chat as shorthand for "co +naxx nc +naxx" (Note: only some bosses currently coded for at this stage)
uld | enable uld strats (Note: Flame Leviathan only)




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
``b [item]`` | buy item
``2g 3s 5c`` | give you gold
``bank [item]`` | deposit item in bank
``bank -[item]`` | withdraw item from back
``gb [item]`` | deposit item in guild bank
``gb -[item]`` | withdraw item from guild bank

## Quests

command | action
:---|:---
``accept [quest]`` | accept quest at the selected quest giver
``accept *`` | accept all quests at the selected quest giver
``drop [quest]`` | abandon quest
``r [item]`` | choose quest reward
``quests`` | show quest summary
``[quest]`` | show quest and objectives status
``talk`` | talk to the selected npc (to complete a quest)
``u [game object]`` | use game object (use los command to obtain the game object link)


## Miscellaneous Commands

command | action
:---|:---
``los`` | enlist game objects, items, creatures and npcs bot can see
``stats`` | show stat summary (inventory, gold, xp, etc.)
``trainer`` | show what bot can learn from the selected trainer
``trainer learn`` | learn from the selected trainer
``spells`` | show bot's spells
``cast [spell]`` | cast the spell
``home`` | set home at the selected innkeeper
``playerbot bot initself`` | CAREFUL WITH THIS - re-rolls YOUR character
``playerbot bot list`` | lists your altbots (and your other characters you can add as bots if you have that enabled, but I'd be very careful if you do that as you can then re-roll your other characters using the init command)
``playerbot bot tweak`` | sets the tweakvalue (seems to be related to a config value that's no longer present and the variable it changes doesn't seem to actually do anything anymore)
``playerbot bot self`` | make yourself into a bot, you have to logout to turn this off, dont run it twice without doing so (it wont toggle it back off like its supposed to, it actually seems to apply multiple AI's onto yourself all fighting to do different things, sounds fun until it crashes the server)
``playerbot bot lookup`` | doesn't do anything but print out a useless usage message (which says you're supposed to give it a class parameter but doing so doesn't change anything because the function called is literally *just* the usage message there's no functionality there)


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


## Rndbot Console Commands

your action | bot reaction
:---|:---
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