### clear bots
```bash
USE `acore_playerbots`;
DELETE FROM `playerbots_random_bots`;

USE `acore_characters`;
DELETE FROM `characters` WHERE `account` IN (SELECT `id` FROM `acore_auth`.`account` WHERE `username` LIKE 'RNDBOT%') OR `account` NOT IN (SELECT `id` FROM `acore_auth`.`account`);
DELETE FROM `arena_team_member` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `arena_team` WHERE `arenaTeamId` NOT IN (SELECT `arenaTeamId` FROM `arena_team_member`);
DELETE FROM `character_account_data` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_achievement` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_achievement_progress` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_action` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_aura` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_glyphs` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_homebind` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `item_instance` WHERE `owner_guid` NOT IN (SELECT `guid` FROM `characters`) AND `owner_guid` > 0;
DELETE FROM `character_inventory` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_pet` WHERE `owner` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `pet_aura` WHERE `guid` NOT IN (SELECT `id` FROM `character_pet`);
DELETE FROM `pet_spell` WHERE `guid` NOT IN (SELECT `id` FROM `character_pet`);
DELETE FROM `pet_spell_cooldown` WHERE `guid` NOT IN (SELECT `id` FROM `character_pet`);
DELETE FROM `character_queststatus` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_queststatus_rewarded` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_reputation` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_skills` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_social` WHERE `friend` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_spell` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_spell_cooldown` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `character_talent` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `corpse` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `groups` WHERE `leaderGuid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `group_member` WHERE `memberGuid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `mail` WHERE `receiver` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `mail_items` WHERE `receiver` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `guild` WHERE `leaderguid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `guild_bank_eventlog` WHERE `guildid` NOT IN (SELECT `guildid` FROM `guild`);
DELETE FROM `guild_member` WHERE `guildid` NOT IN (SELECT `guildid` FROM `guild`) OR `guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `guild_rank` WHERE `guildid` NOT IN (SELECT `guildid` FROM `guild`);
DELETE FROM `petition` WHERE `ownerguid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `petition_sign` WHERE `ownerguid` NOT IN (SELECT `guid` FROM `characters`) OR `playerguid` NOT IN (SELECT `guid` FROM `characters`);

USE `acore_auth`;
DELETE FROM `account` WHERE `username` LIKE 'RNDBOT%';
```
[Thanks to noisiver@Revision](https://github.com/noisiver/codebase/blob/master/SQL%2FAzerothCore%2Fdelete_playerbots.sql)