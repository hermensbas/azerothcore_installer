# azerothcore_installer

## Server setup
 - vmware player
 - ubuntu-24.04-live-server-amd64.iso
 - minimal setup
 - 70GB disksize (minimal 50GB)
 - 16 GB memorysize
 - 6 cores (amd 5700x)
 - network (bridged mode)

## How to start
### 1
```bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y git net-tools nano

git clone https://github.com/hermensbas/azerothcore_installer.git
cd azerothcore_installer.git
chmod +x *.sh

ifconfig (in order to find your ip)
nano settings.env (update ur settings)

./setup.sh
 source ~/.bashrc
```
Simply follow the steps in sequence and abit of common sense, first run till config step.

### 2
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

### 3
start the server
```bash
start
```

create accounts
```bash
> acccount create ahbot mypass 
> acccount create admin mypass
> account set gmlevel 3 -1 
```

### 4 
logon the server with 'ahbot' and create lvl 1 char and logoff again.

Find ah-bot character settings
```bash
./script/find-character.sh
```

configure and enable ahbot
```bash
nano config/modules/mod_ahbot.config
AuctionHouseBot.Account = 1
AuctionHouseBot.GUID = 1
AuctionHouseBot.EnableSeller = 1
AuctionHouseBot.EnableBuyer = 1
```

enable playerbots
```bash
nano config/modules/playerbots.config
AiPlayerbot.Enabled = 1
```

update config
```bash
update
```

and finally restart the server.

## Client
3.3.5a (Chromiecraft)
HD patch optional

##### ip server config
Configure your server IP in 'data/enUS/realmlist.wtf' files

##### Addons (https://felbite.com/chromiecraft-addons):
- Allstats
- Mapster
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
