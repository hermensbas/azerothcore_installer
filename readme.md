# azerothcore_installer
For development and play

## Server setup
 - vmware player
 - ubuntu-24.04-live-server-amd64.iso
 - minimal setup
 - 70GB disksize (minimal 50GB)
 - 16 GB memorysize
 - 8 cores (amd 5700x)
 - network (bridged mode)

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
> acccount create ahbot mypass 
> acccount create admin mypass
> account set gmlevel 3 -1 
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
3.3.5a (Chromiecraft)
HD patch optional

##### ip server config
Configure your server IP in 'data/enUS/realmlist.wtf' files

##### Addons (https://felbite.com/chromiecraft-addons):
- Allstats
- Mapster (map fog disabled, we wanna explore instead seeing the whole map out of the box)
- Grid
- UnBot ([english version](https://github.com/noisiver/unbot-addon/tree/english)) 
- AI_VoiceOver https://github.com/mrthinger/wow-voiceover/releases/download/v1.4.3/AI_VoiceOver-WoW_3.3.5-v1.4.3.zip
- AI_VoiceOverData_Vanilla https://github.com/mrthinger/wow-voiceover/releases/download/v1.3.1/AI_VoiceOverData_Vanilla-v1.0.0.zip

## Router port-forward if public
Use the above (ifconfig) IP for the following router poort-forwarding and/or firewall rules settings.
````
# 3724 TCP AUTH-SERVER
# 8085 TCP WORLD-SERVER
````

## useful bot commands 
See mod-playerbot/src/strategy/actions/ChatActionContext.h | cpp
```bash
.playerbot bot init=white | common | uncommon | rare | epic | legendary
.playerbot bot init=MaxItemLevel
autogear (whenever init is broken)
maintenance ( e.g. clears quest log, smart destroy items in inventory etc)
```

## useful AC GM commands
```bash
.server info (shows latency and amount of bots)
.modify speed <default 1>
.modify money
.appear
.server shutdown 5
.maxskill
.learn all my class
.level <amount of levels to add>
.character level <name> <level>
```
