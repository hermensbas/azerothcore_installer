# azerothcore_installer [WIP]
A simple classic Azerothcore installer with playerbots and ahbot for solo / friends play. 
For now a quick guide with a abit of common sense and experience i guess, this is just quick setup since i kinda made it for personal use. I prolly will test abit more and add some additional 'features' such as
auto character import/export. 

Why classic and not docker? Even though i love docker it does add some additional layer of complexity especially when playing around with modules and settings. Hence making this tiny wrapper instead of a 
docker image. Obviously this can be translated into a container, but if you able to run a container you should be able to run the default wiki installation embedded in the azerothcore instead.

It might contain some errors and whatnot, hopefully it will give you some guidance when you have trouble with the classic installation with playerbots and ah-bot. I havent covered every step with great detail
i might add a 'real' guide when i have the time.

## Todo
 - min/max bot amount, threads performance
 - test MariaDB vs mySQL, mariaDB feels faster maybe i am seeing ghost though. (done and seeems equal)
 - Integrate the player export/import
 - Integrate database full backup
 - Consider setting vmplayer on priority from 'normal' to 'high'


# Server setup
 - vmware player
 - ubuntu-24.04-live-server-amd64.iso
 - minimal setup
 - 70GB disksize (minimal 50GB)
 - 16 GB memorysize
 - 4 cores (amd 5700x)
 - network (bridged mode)

## Ubuntu server settings

Update and install tooling
```bash
sudo apt update -y && sudo apt upgrade -y
sudo git net-tools
```

Find network IP, should be something like 192.168.x.x 
```bash
ifconfig
```

###### Internet server
Use the above (ifconfig) IP for the following router poort-forwarding and/or firewall rules settings.
````
# 3724 TCP AUTH-SERVER
# 8085 TCP WORLD-SERVER
````
Go to e.g. [whatsmyip](https://whatismyip.com/) and use that IP as realm IP in the variables.sh
and the client 3.3.5a 'data/enUS/realmlist.wtf' files

###### Local server
Use the above IP (ifconfig) as realm IP in the variables.sh and the client 3.3.5a 
'data/enUS/realmlist.wtf' files.


# Installer
```bash
git clone https://github.com/hermensbas/azerothcore_installer.git
cd azerothcore_installer.git
chmod +x *.sh
```
And simply follow the steps of the scripts.

For the first install, make sure after 'start.sh' you logon on the tmux session of the world-server by typing 'wow'
and hit next, next, next when prompting for creating databases.

###### ah-bot
Create normal account and use helper/find-character.sh 'charname' to find the accountId and characterId (GUID)
and update your ah-mod config in the ./config folder and reapply the config and start the server again.

```tree
├── 1_download.sh (downloads the sources and client-data)
├── 2_update.sh (updates and resets the downloaded sources to latest)
├── 3_build.sh (builds the server structure and such)
├── 4_compile.sh (compiles the server code)
├── 5_config.sh (applies general configuration and that defined in ./config, restart required)
├── 6_start.sh (starts the client but can be done through alias created by config.sh)
├── _data (client-data v16)
│   └── data.zip
├── _download (downloaded core and modules)
│   ├── azerothcore
│   └── modules
├── _server (the build and compiled server code based on the downloaded code)
│   └── azerothcore
├── config (custom config which be merged on top of the generated .dist configs)
│   ├── authserver.conf
│   ├── modules
│   └── worldserver.conf
├── helper (simple helper scripts for ah-bot and clearing ah-bot)
│   ├── clear-ah.sh
│   └── find-character.sh
├── lib
│   ├── clear-bots.sql
│   ├── general-settings.sh
│   └── merge_core.sh (maybe when your abit more advanced with git and concepts like rebase and merge, but this merges the original azerothcore into the playerbot fork, if e.g. the u need a fix asap)
└── variables.sh (contains project variables such as realm IP and name, min-max items for ah-bot etc.
````

General info
The ah-bot and playerbots modules are integrated sort off, you will need to create an account for th ah-bot and complete the 
ah-bot config by using the find-character.sh script. 

And every start all bots data will be deleted to maintai a clean database and remain the balance between the 
levels of among the bots as they grow over time.

# Client
3.3.5a (Can be found through chromiecraft or simply join that server hosted and developed y azerothcore

Addons:
- Allstats
- QuestHelper
- UnBot (english version), used to control the playerbots
- AI_VoiceOver
- AI_VoiceOverData_Vanilla

# Server stability
Obviously the more custom modules are installed the more risk of encountering problems, playerbot is still being developed. 
If you experience random disconnects without 'any' reason playerbot might be the cause, you might wanna try to rebuild/recompile the code and/or lower the bot amount)

# Changing config
After changing the config files in the /config folder, run the following commands:
  - 1. config - by alias 'config' or running the 5_config.sh) 
  - 2. Server restart - by stop/start or simply a 'AC> server restart 1' command in the world-server session

