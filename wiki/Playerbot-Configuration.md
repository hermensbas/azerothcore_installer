## MySQL Tuning
The default MySQL configuration is not adequate for use with Playerbots, and will lead to increased disk activity and decreased performance.

You should add/change the below config options, in your MySQL configuration where ```innodb_buffer_pool_size``` ideally should be 50% of your total RAM:

```
#
# * Fine Tuning
# Example with 64 GB RAM

# INNODB
innodb_buffer_pool_size = 32G
innodb_io_capacity = 500
innodb_io_capacity_max = 2500
innodb_use_fdatasync = ON
innodb_buffer_pool_instances = 12
innodb_log_buffer_size = 32M

# Max age of binary logs - 5 days to prevent binary log pileups
binlog_expire_logs_seconds = 432000

# Optionally:
# Prevent SQL Deadlocks as much as possible
transaction_isolation="READ-COMMITTED"
```

Recommended configuration to extend lifespan of your hard drive:
- in mysql configuration file change/add line `skip-log-bin` which reduce ~75-90% of writes because skipping binary logging (Use at own risk)
- in playerbots configuration file enable `AiPlayerbot.DisabledWithoutRealPlayer` to make sure no bots are logged in, while no players are
- use as few bots as possible or limit yourself to only using altbots to minimize the amount of writes

## Bot activity profiles and performance
Before going into the configuration options we need explain the logic a bit. Every update tick of the server its calculated whether a bot can
or can't be active. An active bots takes and eats alot more resources then an idle bot.

The following logic is applied to determine whether a bot is active or not, applied in the explained order.

```
1. NOT ACTIVE: When server uptime smaller then (max amount of bots * 0.12 seconds) 
2. ALWAYS ACTIVE: When bot is in battleground, instance or raid.
3. ALWAYS ACTIVE: When in combat and not in party (defend urself)
4. ALWAYS ACTIVE: If the zone where the bot is located has real players
5. ALWAYS ACTIVE: When the bots is a member of a guild with real players
6. ALWAYS ACTIVE: Has real player as master
7. ALWAYS ACTIVE: if grouped and the leader is a real player
8. ALWAYS ACTIVE: if in battleground queue
9. ALWAYS ACTIVE: if looking for group
10. ALWAYS ACTIVE: If bot has a real player within the radius 300 yards
11. ALWAYS ACTIVE: When bot is on a friendlist of a online real player
12. ALWAYS ACTIVE: When bot has more then 10 other bots within the sightDistance, force to spread out
```
These rules will always be applied regardless what value you have configured **'AiPlayerbot.BotActiveAlone'**.

***

All remaining situations e.g. bots in zones or maps without real players, empty server etc will be configured
based on the **'AiPlayerbot.BotActiveAlone'** value. That value basically means that the bot has about
% chance to get active for only a few seconds. Unless in those few seconds one of the above rules
is triggered then it might result staying active longer.

Then **'AiPlayerbot.botActiveAloneSmartScale'** basically auto scale the activity percentages
based on the latency, relative to the configured value of **'AiPlayerbot.BotActiveAlone'**. And only when the bots are in level scope of the configured values of:
* **'AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel'**
* **'AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel'**

***

#### 1. best performance with high bot count.
My personal preference is that i keep my bots idle when i am not in the zone or map, which is applied with the following config
and in this specific requirement it doesnt rlly matter autoscale is on or off but i leave it on.

```
AiPlayerbot.BotActiveAlone = 10
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 2. Default; best effort to enforce 100% acitivity but auto adjust when needed 
(prolly best profile with a server with more real players spread over different zones and maps).
When you want all bots active in all situations but you want to server to compensate the bot 
acitivity based on your latency then use (basically best effort for 100%) : 
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 3. All bots active regardless your latency and performance impact.
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 0
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

#### 4. All bots active and only apply autoscale on a level range (e.g. high levels)
```
AiPlayerbot.BotActiveAlone = 100
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 75
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80
```

***

#### Verify bot performance
Use the command '.server info' to see your server latency. The general latency should be under 70-80 and the percentiles maxed out around 
100, 120, 150. Next to that verify how quick a bot executes your command. It should be pretty much instant. If not to should choose a different profile 
and/or lower your bot amount.

If you dont use these performance checks it might result into strange and incorrect bot behaviours and/or huge amount of memory footprint growth in a relative short time (OOM)

##### Reference
I use 'profile 1' with 5000 bots with an AMD 5700x (4.6ghz, 6 cores), linux, 20GB mem with the following result:

![image](https://github.com/user-attachments/assets/6760feaf-3dc7-4d7a-9534-d4183ff43284)


## Recommended hardware
```
Memory
 minimal: 16GB (when all map grids are loaded 11-12GB)
 preferable: 32GB or more
CPU cores:
 minimal: 4 cores
 preferable: 6 or more cores
CPU speed:
 minimal: 3000mhz
 preferable: 4400mhz or more
```

## Recommended config
worldserver.conf
```bash
# bots might not pickup quests in certain condidations
Quests.IgnoreAutoAccept = 1

# performance 
PreloadAllNonInstancedMapGrids = 0
SetAllCreaturesWithWaypointMovementActive = 0
DontCacheRandomMovementPaths = 0
MapUpdate.Threads = 4 or 6
MapUpdateInterval = 10
MinWorldUpdateTime = 1

# no player limit for the bots
PlayerLimit = 0

# prevent buggy situations
LeaveGroupOnLogout.Enabled = 1
```

playerbots.conf
```bash


#-------------------------------------------------------------------
# general
#-------------------------------------------------------------------
AiPlayerbot.Enabled = 1
AiPlayerbot.DeleteRandomBotAccounts = 0
AiPlayerbot.RandomBotAccountPrefix = "rndbot"

#-------------------------------------------------------------------
# randombots 
# - RandomBotMaps: 0=Eastern Kingdoms, 1=Kalimdor, 530=Outland, 571=Northrend
#-------------------------------------------------------------------
AiPlayerbot.RandomBotMinLevel = 1
AiPlayerbot.RandomBotMaxLevel = 80
AiPlayerbot.AutoTeleportForLevel = 1
AiPlayerbot.RandomBotMaps = 0,1,530,571
AiPlayerbot.ProbTeleToBankers = 0.25
AiPlayerbot.RandomBotMaxLevelChance = 0.01
AiPlayerbot.RandomBotFixedLevel = 0
AiPlayerbot.DisableRandomLevels = 0
AiPlayerbot.RandombotStartingLevel = 5
AiPlayerbot.SyncLevelWithPlayers = 0
AiPlayerbot.SyncQuestWithPlayer = 1
AiPlayerbot.AutoDoQuests = 1

#-------------------------------------------------------------------
# command (gear: 1 = normal, 2 = uncommon, 3 = rare, 4 = epic, 5 = legendary)
#-------------------------------------------------------------------
AiPlayerbot.AutoGearQualityLimit = 4
AiPlayerbot.AutoGearScoreLimit = 0
AiPlayerbot.AutoGearCommand = 1
AiPlayerbot.MaintenanceCommand = 1
AiPlayerbot.AllowPlayerBots = 1
AiPlayerbot.AllowGuildBots = 1

#-------------------------------------------------------------------
# chat and broadcast (default; RepeatDelay = 2000)
#-------------------------------------------------------------------
#AiPlayerbot.RepeatDelay = 2000
AiPlayerbot.EnableBroadcasts = 0
AiPlayerbot.RandomBotTalk = 0
AiPlayerbot.RandomBotEmote = 0
AiPlayerbot.RandomBotSuggestDungeons = 0
AiPlayerbot.EnableGreet = 0
AiPlayerbot.ToxicLinksRepliesChance = 0
AiPlayerbot.ThunderfuryRepliesChance = 0
AiPlayerbot.GuildRepliesRate = 0
AIPlayerbot.GuildFeedback = 0
AiPlayerbot.RandomBotSayWithoutMaster = 0


#-------------------------------------------------------------------
# intervals
#-------------------------------------------------------------------
AiPlayerbot.RandomBotUpdateInterval = 20
AiPlayerbot.RandomBotCountChangeMinInterval = 1800
AiPlayerbot.RandomBotCountChangeMaxInterval = 7200
AiPlayerbot.MinRandomBotInWorldTime = 3600
AiPlayerbot.MaxRandomBotInWorldTime = 1209600
AiPlayerbot.MinRandomBotRandomizeTime = 7200
AiPlayerbot.MaxRandomBotRandomizeTime = 1209600
AiPlayerbot.RandomBotsPerInterval = 60
AiPlayerbot.MinRandomBotReviveTime = 60
AiPlayerbot.MaxRandomBotReviveTime = 300
AiPlayerbot.MinRandomBotTeleportInterval = 3600
AiPlayerbot.MaxRandomBotTeleportInterval = 18000
AiPlayerbot.RandomBotInWorldWithRotationDisabled = 31104000


#-------------------------------------------------------------------
# distance
#-------------------------------------------------------------------
AiPlayerbot.FarDistance = 20.0
AiPlayerbot.SightDistance = 75.0
AiPlayerbot.SpellDistance = 28.5
AiPlayerbot.ShootDistance = 26.0
AiPlayerbot.ReactDistance = 150.0
AiPlayerbot.GrindDistance = 75.0
AiPlayerbot.HealDistance = 38.5
AiPlayerbot.LootDistance = 25.0
AiPlayerbot.FleeDistance = 8.0
AiPlayerbot.TooCloseDistance = 5.0
AiPlayerbot.MeleeDistance = 1.5
AiPlayerbot.FollowDistance = 1.5
AiPlayerbot.WhisperDistance = 6000.0
AiPlayerbot.ContactDistance = 0.5
AiPlayerbot.AoeRadius = 10
AiPlayerbot.RpgDistance = 200
AiPlayerbot.AggroDistance = 22


#-------------------------------------------------------------------
# performance related
#-------------------------------------------------------------------
AiPlayerbot.BotActiveAlone = 10 (either use 10% or 100% anything is between is kinda useless)
AiPlayerbot.botActiveAloneSmartScale = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMinLevel = 1
AiPlayerbot.botActiveAloneSmartScaleWhenMaxLevel = 80

PlayerbotsDatabase.WorkerThreads = 1
PlayerbotsDatabase.SynchThreads = 2
```

## Memory footprint
The memory footprint does grow in most cases. Consider restarting your server every x hours depending on your 
configuration, hardware, player base/usage. 

e.g. with a cronjob
..
