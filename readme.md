# azerothcore_installer
For development and play


[![Intro!](https://i3.ytimg.com/vi/iCn14KLCerY/maxresdefault.jpg)](https://www.youtube.com/watch?v=iCn14KLCerY)

## Server setup
 - vmware player
 - ubuntu-24.04-live-server-amd64.iso (minimal setup)
 - 70GB disk
 - 20 GB memory
 - 8 cores (amd 5700x)
 - network (bridged mode)

#### mysql 8.4.3

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```
key_buffer_size         = 0
# max_allowed_packet    = 64M
# thread_stack          = 256K

# INNODB stuff
innodb_buffer_pool_size = 8G
innodb_redo_log_capacity = 4G
innodb_io_capacity = 500
innodb_io_capacity_max = 2500
innodb_use_fdatasync = ON
innodb_buffer_pool_instances = 16
innodb_log_buffer_size = 32M

join_buffer_size = 1M
thread_cache_size = 12
```

sudo systemctl restart mysql

SHOW VARIABLES LIKE 'innodb_buffer_pool_size';

## How to start
### Step 1
```bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y git net-tools nano

git clone https://github.com/hermensbas/azerothcore_installer.git
cd azerothcore_installer.git
chmod +x *.sh

ifconfig (in order to find your ip)
nano settings.env (update ur settings)

./setup.sh
 source ~/.bashrc

update
build
compile
```

### Step 2
disable playerbots
```bash
nano config/modules/playerbots.config
AiPlayerbot.Enabled = 0
```

disable ahbot
```bash
nano config/modules/mod_ahbot.config
AuctionHouseBot.Account = 0
AuctionHouseBot.GUID = 0
AuctionHouseBot.EnableSeller = 0
AuctionHouseBot.EnableBuyer = 0
```

### Step 3
Start the server
```bash
config
start
```

Create accounts
```bash
> account create ahbot mypass 
> acccount create admin mypass
> account set gmlevel admin 3 -1 
```

### Step 4 
Logon the server with 'ahbot' and create lvl 1 char and logoff again.

Find ah-bot character settings
```bash
./script/find-character.sh ahbot
accountId       characterName   characterId
1       Yappe   1
Find character executed...
```

Configure and enable ahbot
```bash
nano config/modules/mod_ahbot.config
AuctionHouseBot.Account = 1
AuctionHouseBot.GUID = 1
AuctionHouseBot.EnableSeller = 1
AuctionHouseBot.EnableBuyer = 1
```

Enable playerbots
```bash
nano config/modules/playerbots.config
AiPlayerbot.Enabled = 1
```

### Step 5 

Stop server, re-apply configuration, and start server
```bash
ctrl + z
stop
config
start
```

## Client
- 3.3.5a (Chromiecraft.com)
 - Chromiecraft HD patch optional or huge patch 2024 [23GB graphic patch](https://github.com/Marotheit/A-Guide-to-Modernizing-the-WotLK-Client/)

Personally i prefere the chromiecraft HD patch without the T-patch, blizzlike :)

##### ip server config
Configure your server IP in 'data/enUS/realmlist.wtf' files

##### Addons ([download](https://felbite.com/chromiecraft-addons)):
- Allstats
- Mapster (map fog disabled, we wanna explore instead seeing the whole map out of the box)
- Grid
- UnBot ([english version](https://github.com/noisiver/unbot-addon/tree/english)) 
- [AI_VoiceOver](https://github.com/mrthinger/wow-voiceover/releases/download/v1.4.3/AI_VoiceOver-WoW_3.3.5-v1.4.3.zip)
- [AI_VoiceOverData_Vanilla](https://github.com/mrthinger/wow-voiceover/releases/download/v1.3.1/AI_VoiceOverData_Vanilla-v1.0.0.zip)
- https://gitlab.com/Tsoukie/compactraidframe-3.3.5
- https://github.com/Macx-Lio/MultiBot (still under development)

## Router port-forward if public
Use the above (ifconfig) IP for the following router poort-forwarding and/or firewall rules settings.
````
# 3724 TCP AUTH-SERVER
# 8085 TCP WORLD-SERVER
````

## useful AC GM commands
[Wiki reference](https://www.azerothcore.org/wiki/gm-commands)
```bash
.server info (shows latency and amount of bots)
.modify speed <default 1>
.gm fly on | off
.modify money
.appear
.server shutdown 5
.maxskill
.learn all my class
.level <amount of levels to add>
.character level <name> <level>
.teleport orgrimmar or .tel orgrimmar)
.leave (when you want the group to leave you alone!)
.addItem itemName (or ctrl+click the item)
.lookup item ThunderFury
.lookup event moonfair
.event start|stop id
.distance (amount of yards between you and selected target)
```

## useful bot commands 
Code references
- See [mod-playerbot/src/strategy/actions/ChatActionContext.h](https://github.com/hermensbas/mod-playerbots/blob/master/src/strategy/actions/ChatActionContext.h) | cpp
- See [mod-playerbot/src/strategy/action/ActionContext.h](https://github.com/hermensbas/mod-playerbots/blob/master/src/strategy/actions/ActionContext.h) | cpp
- See [mod-playerbot/src/ChatFilter.cp](https://github.com/hermensbas/mod-playerbots/blob/master/src/ChatFilter.cpp)
- See [mod-playerbot/src/PlayerbotMgr.cpp](https://github.com/hermensbas/mod-playerbots/blob/master/src/PlayerbotMgr.cpp#L692)
- See unbot add-on tooltips

```bash
# Unbot has init=auto but that doesnt always work, esp when ur level 1 (for now) alternativy use
# the following or when the bots are to strong you can lower the equipment.

.playerbot bot init=white | common | uncommon | rare | epic | legendary
.playerbot bot init=MaxItemLevel
.playerbot rndbot init (re-randomize all bots again)
     (rndbot stats/update/reset/init/refresh/add/remove)

autogear (whenever init is broken, max equipment levelItem configured in playerbot.conf)
maintenance ( e.g. clears quest log, smart destroy items in inventory etc)

# let alt bots attack other bot on sight in pvp zone
nc +pvp
nc -pvp

# equip urself
.playerbot bot self, whisper yourself autogear and then use .playerbot bot self

# After init or talents respec make sure you reset bot AI (see unbot).
.playerbot bot add <name-of-character-on-account> (or account name instead of character name to add all characters on an account

# while in BG
.playerbots debug bg showpath=all 
```

Tank attack @dps attack in 10 seconds
```
@tank attack
/in 10 @dps attack

or use
you could also use co +passive to get the dps to not attack until you use co -passive
```
