# azerothcore_installer
AzerothCore (WotLK 3.3.5a) + mod-playerbots installer, for development and play.

[![Intro!](https://i3.ytimg.com/vi/iCn14KLCerY/maxresdefault.jpg)](https://www.youtube.com/watch?v=iCn14KLCerY)

## Contents
- [Server setup](#server-setup)
- [Installation](#installation)
- [Daily use](#daily-use)
- [Client](#client)
- [Useful GM commands](#useful-gm-commands)
- [Useful bot commands](#useful-bot-commands)
- More playerbot docs: [wiki/](wiki/Home.md)

## Server setup
- VMware Player
- `ubuntu-24.04-live-server-amd64.iso` (minimal setup)
- 100 GB disk
- 64 GB memory
- 16 threads assigned (AMD 7945HX)
- Network in bridged mode

### MySQL 8.4.x (LTS)
Installation: see [install_mysql_8.4.2_lts.md](install_mysql_8.4.2_lts.md).

```bash
mysql --help | grep my.cnf                # where my.cnf is read from
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
# restart failed?
sudo journalctl -xeu mysql.service --no-pager | tail -n 30
```
Check in mysql: `SHOW VARIABLES LIKE 'innodb_buffer_pool_size';`

`/etc/mysql/mysql.conf.d/mysqld.cnf` (tuned for 64 GB RAM / NVMe):
```ini
[mysqld]
# ------------------ Memory Usage ------------------
innodb_buffer_pool_size = 24G
innodb_buffer_pool_instances = 8
innodb_log_buffer_size = 512M
innodb_redo_log_capacity = 2G

# ------------------ I/O & NVMe Tuning ------------------
innodb_flush_method = O_DIRECT              # Avoid OS cache — best for NVMe
innodb_use_fdatasync = ON
innodb_io_capacity = 8000                   # Pushes high IOPS for writes
innodb_io_capacity_max = 16000              # Maximize during bursts

# ------------------ Temp Tables & Buffers ------------------
tmp_table_size = 256M
max_heap_table_size = 256M
join_buffer_size = 2M
sort_buffer_size = 4M
read_buffer_size = 2M
read_rnd_buffer_size = 1M

# ------------------ Concurrency / Threads ------------------
thread_handling = one-thread-per-connection
thread_cache_size = 64
max_connections = 300
table_open_cache = 4000
open_files_limit = 65535

# ------------------ Locking/Deadlocks ------------------
innodb_lock_wait_timeout = 10
innodb_deadlock_detect = ON

# ------------------ File & Table Management ------------------
innodb_file_per_table = 1

# ------------------ Logging / Debug ------------------
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mysql-slow.log
long_query_time = 1
log_queries_not_using_indexes = 1
binlog_expire_logs_seconds = 604800         # 7 days
```

## Installation

### Step 1 – Install and compile
```bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y git net-tools nano

git clone https://github.com/hermensbas/azerothcore_installer.git
cd azerothcore_installer
chmod +x *.sh

ip -4 addr                     # find your server IP (or: ifconfig)
nano settings.env              # set REALM_IP, REALM_NAME, repos/branches, client-data

./setup.sh && source ~/.bashrc   # source loads the aliases into the current shell

install                        # download sources + client-data
build                          # copy sources into _server/ and unpack client-data
compile
```

`settings.env` selects the core and module repositories/branches (currently `test-staging`)
and the client-data release. After changing it, run `./setup.sh && source ~/.bashrc` again;
a changed `AC_CLIENT_DATA` is downloaded again on the next `install`.

### Step 2 – Disable playerbots and ahbot for the first start
`config/modules/playerbots.conf`
```ini
Playerbots.Enabled = 0
```

`config/modules/mod_ahbot.conf`
```ini
AuctionHouseBot.GUID = 0
AuctionHouseBot.EnableSeller = false
```

### Step 3 – Start the server and create accounts
```bash
config
start
wow
```

In the worldserver console:
```
account create ahbot mypass
account create admin mypass
account set gmlevel admin 3 -1
```

### Step 4 – Set up the ahbot character
Log on with `ahbot`, create a level 1 character and log off again.

Look up its character id:
```bash
./script/find_characters.sh ahbot
accountId       characterName   characterId
1       Yappe   1
Find character executed...
```

Enable ahbot with that id in `config/modules/mod_ahbot.conf`:
```ini
AuctionHouseBot.GUID = 1
AuctionHouseBot.EnableSeller = true
```

Enable playerbots in `config/modules/playerbots.conf`:
```ini
Playerbots.Enabled = 1
```

### Step 5 – Apply the configuration and restart
Detach from the console with `Ctrl-b` then `d`, then:
```bash
stop
config
start
```

### MMaps for playerbots (optional)
The client-data release ships stock AzerothCore mmaps. The playerbots core additionally tags
steep slopes for the bot pathfinder, which needs mmaps generated with the core's own
`mmaps_generator`. Use `extract_ac_client_data.sh` from mod-playerbots with only
`EXTRACT_MMAPS=true` (no WoW client needed). Note that `build` recreates `_server/`,
so regenerated mmaps have to be generated again (or copied back) after a `build`.

## Daily use
Type `menu` for all commands.

| Command | What it does |
|---|---|
| `install` | Download the source code and client-data |
| `update` | Update the source code to the latest version |
| `build` | Build the server folder from the source code |
| `compile` / `compile_debug` | Compile (Release / RelWithDebInfo) |
| `config` | Apply the configuration from `config/` |
| `start` / `start_debug` | Start auth and world in tmux sessions (debug = GDB) |
| `stop` | Stop all sessions |
| `wow` / `auth` | Attach to the worldserver / authserver console |

In the `wow` / `auth` console (tmux):
- Scroll with the mouse wheel (set up by `setup.sh`), or `Ctrl-b` then `[` and arrow keys / PgUp (`q` to quit).
- Detach without stopping the server: `Ctrl-b` then `d`.
- Select text for copying to your PC: hold `Shift` while selecting.

## Client
- 3.3.5a (Chromiecraft.com)
- Optional: Chromiecraft HD patch, or the huge 2024 patch: [23 GB graphics patch](https://github.com/Marotheit/A-Guide-to-Modernizing-the-WotLK-Client/)

Personally I prefer the Chromiecraft HD patch without the T-patch, blizzlike :)

### Server IP
Set your server IP in the client's `Data/enUS/realmlist.wtf`.

### Addons ([download](https://felbite.com/chromiecraft-addons))
- Allstats
- Mapster (map fog disabled — we want to explore instead of seeing the whole map out of the box)
- Grid
- UnBot ([English version](https://github.com/noisiver/unbot-addon/tree/english))
- [AI_VoiceOver](https://github.com/mrthinger/wow-voiceover/releases/download/v1.4.3/AI_VoiceOver-WoW_3.3.5-v1.4.3.zip)
- [AI_VoiceOverData_Vanilla](https://github.com/mrthinger/wow-voiceover/releases/download/v1.3.1/AI_VoiceOverData_Vanilla-v1.0.0.zip)
- [CompactRaidFrame](https://gitlab.com/Tsoukie/compactraidframe-3.3.5)
- [MultiBot](https://github.com/Macx-Lio/MultiBot) (still under development)

### Router port-forward (public server)
Forward these ports to the server IP found in step 1 (router and/or firewall):
```
3724 TCP  authserver
8085 TCP  worldserver
```

## Useful GM commands
[Wiki reference](https://www.azerothcore.org/wiki/gm-commands)
```
.server info                    shows latency and number of bots
.server shutdown 5
.modify speed <default 1>
.modify money
.gm fly on | off
.appear
.maxskill
.learn all my class
.level <levels to add>
.character level <name> <level>
.teleport orgrimmar             (or .tel orgrimmar)
.leave                          leave the group (when you want the group to leave you alone)
.additem <itemName>             (or ctrl+click the item)
.lookup item Thunderfury
.lookup event moonfair
.event start|stop <id>
.distance                       yards between you and the selected target
.gps
.go xyz
```

Playerbot debugging:
```
/whisper <bot> nc +debug
/whisper <bot> nc +debug spell
/whisper <bot> rpg status
.playerbots pmon toggle
.playerbots pmon stack
.playerbots debug bg showpath=all     (only works in BGs)
```

## Useful bot commands
More in [wiki/Playerbot-Commands.md](wiki/Playerbot-Commands.md). Code references (mod-playerbots):
- [ChatActionContext.h](https://github.com/hermensbas/mod-playerbots/blob/test-staging/src/Ai/Base/ChatActionContext.h)
- [ActionContext.h](https://github.com/hermensbas/mod-playerbots/blob/test-staging/src/Ai/Base/ActionContext.h)
- [ChatFilter.cpp](https://github.com/hermensbas/mod-playerbots/blob/test-staging/src/Bot/Cmd/ChatFilter.cpp)
- [PlayerbotMgr.cpp](https://github.com/hermensbas/mod-playerbots/blob/test-staging/src/Bot/PlayerbotMgr.cpp)
- UnBot add-on tooltips

```
# UnBot has init=auto but that doesn't always work, especially at level 1. Alternatively use
# the following, or lower the equipment when the bots are too strong.
.playerbot bot init=white | common | uncommon | rare | epic | legendary
.playerbot bot init=MaxItemLevel
.playerbot rndbot init          re-randomize all bots (also: stats/update/reset/refresh/add/remove)

autogear                        when init is broken; max item level is configured in playerbots.conf
maintenance                     e.g. clears quest log, smart-destroys inventory items

# let alt bots attack other bots on sight in PvP zones
nc +pvp
nc -pvp

# equip yourself
.playerbot bot self
/w maintenance
/w autogear
/w nc +new rpg,+grind,+gather,+loot,+quest     (whisper yourself)

# After init or a talent respec, reset the bot AI (see UnBot).
.playerbot bot add <character-name>   (or an account name to add all characters of that account)
```

Tank attacks, DPS attacks 10 seconds later:
```
@tank attack
/in 10 @dps attack
```
Or keep the DPS passive with `co +passive` until you use `co -passive`.
