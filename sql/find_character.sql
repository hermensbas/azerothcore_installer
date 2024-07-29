USE acore_auth;
SELECT acc.id AS accountId, ch.name as characterName, ch.guid AS characterId,  
FROM acore_auth.account AS acc 
INNER JOIN acore_characters.characters AS ch 
WHERE acc.id = ch.account and acc.username = '{{ACCOUNT_NAME}}';
