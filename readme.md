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
```bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y git net-tools nano

git clone https://github.com/hermensbas/azerothcore_installer.git
cd azerothcore_installer.git
chmod +x *.sh

ifconfig (in order to find your ip)
nano settings.env (update ur settings)

./setup.sh
```
Simply follow the steps in sequence and abit of common sense.


##### Configure ah-bot
Create normal account and use script/find-character.sh 'charname' to find the accountId and characterId (GUID)
and update your ah-mod config in the ./config folder and reapply the config and start the server again.

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

## Create account
world-server
```bash
> acccount create ahbot mypass 

> acccount create admin mypass
> account set gmlevel 3 -1 
```
