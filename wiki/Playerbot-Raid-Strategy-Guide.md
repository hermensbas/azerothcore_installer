## Raid Strategy Status

This guide works alongside https://github.com/liyunfan1223/mod-playerbots/wiki/Playerbot-Raid-Completion-Status by going into detail on each strategy coded per boss for each raid, as well as note expected player actions where the coded strategy may be insufficient or not necessary. Please note that the strategies and overall feasibility are made assuming appropriate level gear for that content, although many are also completable using the Individual Progression module nerfs.

## Vanilla

### Molten Core
*This raid is completable with IP nerfs.

**Lucifron**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Shadow resistance aura will be automatically applied.
* Tips & Tricks: None

**Magmadar**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Fire resistance aura will be automatically applied.
* Tips & Tricks: Use Bots to place fear ward on tank, and have shamans use tremor totems to help with fear; may be added as a strat in the future.

**Gehennas**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Shadow resistance aura will be automatically applied.
* Tips & Tricks: None

**Garr**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Fire resistance aura will be automatically applied. Disabled aoe dps abilities via multiplier to help prevent multiple simultaneous explosions.
* Tips & Tricks: None

**Baron Geddon**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Fire resistance aura will be automatically applied. Bots will run away from the raid if they get Living Bomb and will run away from boss during Inferno.
* Tips & Tricks: None

**Shazzrah**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Ranged bots will position themselves at maximum distance in order to avoid the arcane explosion while still being able to dps and heal.
* Tips & Tricks: None

**Sulfuron Harbinger**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Fire resistance aura will be automatically applied.
* Tips & Tricks: Use Skull icon to focus target down individual boss adds.

**Golemagg the Incinerator**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed. 
* Coded Strategies: Fire resistance aura will be automatically applied. Disabled aoe dps via multiplier. Offtanks pull Core Ragers away from Golemagg to remove their buff.
* Tips & Tricks: None

**Majordomo Executus**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Shadow resistance aura will be automatically applied.
* Tips & Tricks: Use Skull icon to focus target down individual boss adds.

**Ragnaros**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Fire resistance aura will be automatically applied.
* Tips & Tricks: None

### Blackwing Lair
*Note that all Playerbots are automatically granted the Onyxia Scale Cloak buff and will automatically disable suppression devices. This raid is completable with IP nerfs.

**Razorgore the Untamed**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: Player will need to control Razorgore to destroy the eggs in Phase 1.

**Vaelastrasz the Corrupt**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: None

**Broodlord Lashlayer**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: None

**Firemaw**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: None

**Ebonroc**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: None

**Flamegor**

* Defeatable Solo with Bots: Yes, without coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: None

**Chromaggus**

* Defeatable Solo with Bots: Yes, with coded strategies and some manual control needed.
* Coded Strategies: Bots will automatically clear Brood Affliction: Bronze
* Tips & Tricks: Depending on gear, some manual bot control may be necessary using RTSC to place Chromaggus by the door to LOS during certain breath attacks.

**Nefarian**

* Defeatable Solo with Bots: Yes, with some degree of manual control needed.
* Coded Strategies: None
* Tips & Tricks: In Phase 2, use RTSC to place main tank for Nefarian by the stairs facing away from the raid. Use commands for shamans to use tremor totem, and remove tank assist (co -tank assist) from main tank to avoid him moving Nefarian around when the skeleton adds spawn in Phase 3.

## Burning Crusade

### Karazhan
*This raid is completable with suggested IP nerfs. Strategies were written and tested with 1) bot damage and healing each reduced to 50% of normal strength, and 2) HP of all raid mobs restored to Patch 2.4.3 levels (reverting the global 30% nerf to HP of TBC raid mobs from Patch 3.0.2).

**Attumen the Huntsman & Midnight**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * The main tank will tank Midnight, and bots will focus DPS on Midnight.
  * When Attumen spawns, the assist tank will pick him up and move him away from the raid because he cleaves.
  * When Midnight reaches 25% health and Attumen mounts Midnight, the main tank will pick up Attumen, and other bots will briefly pause DPS. All bots other than the tank will stack up behind Attumen, inside the minimum range of his Berserker Charge.
* Tips & Tricks: Although not required, the easiest way to pull Midnight is to have bots stay out of line-of-sight behind the haycart and pull Midnight yourself (and then take bots off of stay once Midnight gets around the haycart).

**Moroes**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * The main tank will target Moroes for the duration of the encounter.
  * Other bots will mark adds with the skull icon and prioritize accordingly based on the standard kill order (Millstipe first, Von’indi second, etc.), taking into account which four adds were randomly chosen.
* Tips & Tricks: In practice, the adds will likely be grouped up, and bots will AoE them down (with classes without AoE capabilities targeting the add marked with a skull). If you want bots to only single-target prioritize adds, you will need to disable their standard AoE DPS strategies. However, it is likely (even when playing with IP nerfs) that AoEing down the adds will be fast and effective.

**Maiden of Virtue**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * The main tank will position Maiden in the middle of the room, and ranged bots will fan out around the center, between the pillars. 
  * When Maiden casts Repentance, the tank will move her to a healer to use the Holy Ground to break the healer’s stun.
* Tips & Tricks: Each ranged bot has an assigned position between pillars—if you are also playing a ranged class, make sure to find an open spot so you do not chain Holy Wrath.  

**Opera Event**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * Bots will switch the skull icon back and forth between Romulo and Julianne as needed to try to kill them at about the same time. 
  * Bots will mark the Wizard of Oz bosses with the skull icon and prioritize accordingly based on the standard kill order (Dorothee, Tito, Roar, Strawman, Tinhead, Crone). Mage bots will spam Scorch on Strawman to disorient him. 
  * The main tank will position the Big Bad Wolf in the front left corner of the stage (from the perspective of facing the stage). Bots that are transformed into Little Red Riding Hood will attempt to run around the stage to get away from the Big Bad Wolf.
* Tips & Tricks: To speed up your clear, you can talk to Barnes and initiate the Opera Event while letting bots clear the final trash mobs. You will likely still have plenty of time to prepare to engage the boss due to the long intro to the event.

**The Curator**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * The main tank will position Curator in a designated spot in the center of the hallway near the entrance to the Guardian’s Library.
  * Ranged bots will spread out, and all bots will mark and prioritize destroying Astral Flares. 
  * The assist tank will stay on Curator (instead of picking up Flares) to try to stay second on aggro to absorb Hateful Bolts.
  * Bots will save Bloodlust/Heroism until Curator uses Evocation and is vulnerable to double damage.
* Tips & Tricks: Set bots to “co -boost” before the fight to prevent them from using other major cooldowns and activate “co +boost” when Curator uses Evocation.

**Terestian Illhoof**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Bots will mark and prioritize targets with the skull icon in the following order: (1) Demon Chains, (2) Kil’rek, and (3) Terestian Illhoof.
* Tips & Tricks: If you are playing DPS, consider using a /target macro for the Demon Chains.

**Shade of Aran**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: 
  * Ranged bots will attempt to maintain spread positions outside of Aran’s Counterspell range.
  * When Aran casts Massive Magnetic Pull, bots will run to the edge of the room to escape the Arcane Explosion. 
* When Aran casts Flame Wreath, and for the duration of the Flame Wreath aura being active, bots will stop moving.
* When Aran summons Conjured Elementals, bots will mark and prioritize them with the skull icon.
* Tips & Tricks: 
  * Coded strategies do not persist after Aran dies so if Flame Wreath is active when he dies, make sure to manually command bots to stay or they will blow up the raid. 
  * An Azerothcore bug exists that sometimes causes Flame Wreath to persist long beyond its correct duration. If Aran casts Arcane Explosion while Flame Wreath is still active, there is not much you can do, and it is probably a wipe.

**Netherspite**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Bots are assigned to block beams during the Portal Phase, and proper raid composition is important to ensure sufficient beam coverage. 
  * Tank bots are assigned to block the red beam. Each tank will block the red beam for an entire Portal Phase and will dance in and out of the beam to avoid taking too many stacks of the debuff. 
  * DPS bots (excluding Rogues and Warriors) are assigned to block the blue beam. They will transition at 24 stacks of the debuff, and therefore two such bots are required for each Portal Phase. 
  * Healer, Rogue, and DPS Warrior bots are assigned to block the green beam. Rogues and DPS Warriors will be prioritized, and if they are assigned, they will remain in the beam for the duration of the Portal Phase (since there is no disadvantage to them from the debuff). Only if there are not enough eligible Rogues and DPS Warriors will healers block the green beam, and they will transition at 24 stacks of the debuff.
  * Bots are coded to avoid Void Zones and to avoid beams that they are not assigned to block.
  * Bots will briefly pause DPS when Netherspite is pulled and again upon each transition into the Portal Phase.
* Tips & Tricks: 
  * Netherspite is bugged in Azerothcore in that the beams cannot be blocked inside of Netherspite’s hitbox (18 yards from his center), even though they visually continue to his center (and were blockable inside his hitbox in retail). The bots are coded to account for this, but the player should also be aware in the event that the player needs to block a beam. Additionally, this makes it important to pull the boss in the middle of the room since if the boss is too close to a portal, it will be impossible to block the beam.
  * The player’s primary role during the Portal Phase (other than filling in for a bot that dies without replacement) should be to back up the bots on beams. Bots may not transition blocking duties as quickly as competent players (who would be prepared next to a beam when they are about to take over blocking to ensure an instant transition—for various reasons, trying to code this for bots is problematic). In particular, any gap in blocking of the Green Beam can be disastrous. Accordingly, if a healer bot is blocking the Green Beam, players should be prepared to block the Green Beam temporarily then the transition occurs.
  * Bot tanks are coded not to attempt to avoid Void Zones while moving in and out of the Red Beam. The ability to control their movement is not sufficiently precise or dynamic to allow for their avoidance without ensuring that the boss does not move (and cause all beam blockers to get out of position). Therefore, tanks will need to be healed through the extra damage.
  * The only strategy coded for the Banish phase is for bots to avoid Void Zones, and therefore it is the player’s choice whether to continue to DPS the boss or to bring the raid out of range of Netherbreath and wait for the next Portal Phase to reengage.

**Chess Event**

* Defeatable Solo with Bots: Yes, no bot involvement needed.
* Coded Strategies: None.
* Tips & Tricks: From White’s point of view, use your first three turns to move pawns forward to b3, d3, and g3. Use your next two turns to move rooks to a2 and g2. If Medivh sets a fire under your king or queen, stop what you are doing and immediately move them out of the fire. Thereafter, generally focus on controlling the queen and using Fireball (Horde) or Elemental Blast (Alliance) to target the opposing king. This method is effective but not guaranteed, as success is dependent on RNG (including where Medivh moves the king and what cheats he uses and when). Depending on the situation, it may be helpful to capture other pieces before the king (in particular, the opposing bishops and/or queen).

**Prince Malchezaar**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies:
  * Bots that are Enfeebled will run out of Shadow Nova range and should select escape vectors that do not come in range of any Netherspite Infernal’s Hellfire.
  * All bots will attempt to avoid Infernals. The tank will attempt to stay a bit further from the Infernals than other bots to try to give players and other bots (particularly melee DPS) some room to maneuver.
  * Bots will save Bloodlust/Heroism until phase 3 (Malchezaar at 30% HP), when the Infernal spawn rate increases drastically.
* Tips & Tricks: Bots may get “stuck” behind an Infernal that lands between them and Malchezaar, as they will refuse to run into the Hellfire and are unable to move around Infernals. If this happens, briefly activate “flee” and lead the bots slightly off to the side of the Hellfire (or even into or through the Hellfire if they are able to survive) so that they can reach the boss by moving in a straight line after the flee strategy is removed.

**Nightbane**

* Defeatable Solo with Bots: Yes. During phase changes, the player will be responsible for leading bots to the correct positions in anticipation of combat (discussed below). No RTSC is needed; just make sure to run to the general area called for by the strategies at the right time.
* Coded Strategies: 
  * The tank and ranged bots have fixed positions near the Northeastern door to the Master’s Terrace. After summoning the boss, players should lead the bots to that general area to wait for combat to begin.
  * The tank will attempt to move Nightbane in a manner that results in him being positioned perpendicularly from the raid, facing the edge of the balcony (though this is imperfect, and he may end up at a slight angle).
  * Priest bots will cast Fear Ward on the tank.
  * There are three fixed positions coded for ranged bots. The ranged bots will stack and cycle through the positions if Charred Earth spawns underneath them. It is a known issue that bots will sometimes arrive at a safe position but continue to cycle—this is due to the fact that the bots determine whether they are in an unsafe position by the presence of the Charred Earth aura on themselves. It is possible for the aura not to have faded before the bot arrives at the next position, even if the next position is safe, resulting in the bot thinking it is not safe and continuing to cycle. However, they should eventually settle into a safe position.
  * When the flight phase starts, bots will mark Nightbane with a moon and stop attacking. They will stack at a position near Nightbane’s flight phase position so he does not use Fireball Barrage. When Rain of Bones is cast and Restless Skeletons spawn, all bots will move away and stack in a new position that is outside of the Rain of Bones AoE before killing the Skeletons.
  * Hunter and Warlock pets are set to passive during the flight phase. Players should make sure to do this as well. The maps on the Master’s Terrace are extremely buggy, and pets will chase Nightbane into midair and may even run out of the tower grounds, which can cause Restless Skeletons to spawn in odd places and even aggro mobs from other parts of the instance. Because of this, bots are disabled from using any temporary pets (e.g., Spirit Wolves, Water Elementals, Treants) during the encounter.
  * The flight phase lasts for 45 seconds, but Nightbane is not aggressive during the final 10 seconds (when he is preparing to land). Nightbane will yell that he is landing, at which point the player will need to lead the bots back to the ground phase combat area.
  * Bots will pause DPS after the pull and after each transition into the ground phase to allow the tank to get aggro. 
* Tips & Tricks: 
  * Because of the buggy maps, there is a tendency for mobs to pull through the floor, and it is suggested that prior to the encounter, you clear all mobs from the Livery Stables, including the upper level, and the Scullery.
  * AoE avoidance is intentionally disabled for the tank. This is necessary to prevent the tank from spinning Nightbane and causing him to face the raid, as bot movement is not sufficiently precise or dynamic to avoid the Charred Earth while still keeping Nightbane properly positioned. As a result, the tank will need to be healed through Charred Earth.
  * Ultimately, Nightbane may be the most challenging boss in T4 content. At appropriate gear levels with IP nerfs, it is likely that three healers will be needed (even though two is likely sufficient for the rest of Karazhan).

### Magtheridon's Lair
*This raid is completable with IP module nerfs. Strategies were written/tested with (1) bot damage and healing each reduced to 50% of normal strength, and (2) HP of all raid mobs restored to Patch 2.4.3 levels (i.e., reverting the global 30% nerf to HP of TBC raid mobs from Patch 3.0.2).

**Magtheridon**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: The strategy is designed for a raid with three traditional tanks, but having that many is not critical.
  * During phase one, the main tank (determined by setting the client-side main tank flag) will tank three of the Hellfire Channelers, and the second and third off tanks will each tank one Channeler, dragging them away from the raid out of Shadow Bot Volley range. DPS bots will prioritize Channelers by RTI marks (in order, Square, Star, Circle, Diamond, and Triangle).
  * Also during phase one, Warlocks will be assigned to Banish the Burning Abyssals (and Fear any in excess of the number of Warlocks in the raid).
  * After the first three Channelers are down, the main tank will wait in the center of the room to pick up Magtheridon while the remainder of the raid finishes the final two Channelers. When Magtheridon is released, the main tank will pull him to the Northern point of the room. DPS bots will wait a few seconds before attacking Magtheridon to prevent them from pulling aggro while the tank gets positioned.
  * To handle the Manticron Cubes, one ranged DPS bot (excluding Warlocks) will be assigned to click each Cube. Warlocks are excluded for Cube assignments so they can keep residual Abyssals crowd controlled and focus their high DPS on the boss. However, the strategy will automatically reassign a Cube clicker if the previously assigned bot dies, and if there are not five living non-Warlock ranged DPS alive, then any living non-tank bot can be selected.
  * Magtheridon will cast Blast Nova approximately every 55 seconds. About 6 seconds before the cast, each bot that is assigned to a Cube will move to their Cube and wait in position a short distance away. They will move in to use the Cube as soon as the Blast Nova cast begins. Once Blast Nova is interrupted, they will return to the fight and will repeat the cycle until the boss is down.
* Tips & Tricks: 
  * During the brief lull between the final Channeler dying and Magtheridon becoming released, bots will be idle and follow their player master. The player should make sure not to lead the bots in front of Magtheridon at this time, or the bots may be killed immediately when Magtheridon is released.  
  * It is helpful (though not required) for Warriors and/or Druids to tank the fourth and fifth Channelers because they will be able to keep the Channelers consistently interrupted (particularly their Dark Mending heals).  
  * You may want to have bots manually pause DPS before Magtheridon reaches 30% HP if his Blast Nova cast is imminent, and wait for the Blast Nova to be interrupted before taking him to 30% HP. Otherwise, the combination of the ceiling collapsing at 30%, followed by an immediate Blast Nova with the raid stunned, can cause a wipe.  

### Gruul’s Lair
*This raid is completable with IP nerfs. Strategies were written/tested with (1) bot damage and healing each reduced to 50% of normal strength, and (2) HP of all raid mobs restored to Patch 2.4.3 levels (i.e., reverting the global 30% nerf to HP of TBC raid mobs from Patch 3.0.2).

**High King Maulgar**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: The strategy is designed for a raid with three traditional tanks, a Mage tank with 9000+ buffed max HP, and a Moonkin Druid tank (special gearing not necessary).
  * The main tank (determined by setting the client-side main tank flag) will tank Maulgar. The other two traditional tanks will tank Olm and Blindeye. The Mage tank (which the strategy selects as the Mage bot in the raid with the highest max HP) will tank Krosh by Spellstealing Krosh’s Spell Shield. The Moonkin tank (Moonkin bot in the raid with the highest max HP) will tank Kiggler, but it is not truly necessary, and the fight can be completed with no Moonkin Druid in the raid.
  * Ranged DPS will prioritize targets in the following order: Blindeye, Olm, Krosh, Kiggler, Maulgar
  * Melee DPS will prioritize targets in the following order: Blindeye, Olm, Kiggler, Maulgar
* Tips & Tricks: 
  * Pull the boss head-on and send your traditional tanks in to start the encounter.
  * All tanks (except the Moonkin tank) have designated spots in the room—be careful not to stand too close to Krosh.
  * If playing with IP nerfs, the fight will likely be difficult without a Mage tank with sufficient HP not to get one-shot by Krosh. At pre-raid gear levels, achieving enough HP will likely require some intentional stacking of stamina gear and/or enchants.

**Gruul the Dragonkiller**

* Defeatable Solo with Bots: Yes, no manual control or command of bots needed.
* Coded Strategies: Two tanks are needed, a main tank and an offtank to absorb Hurtful Strike.
The main tank will attempt to keep Gruul in the center of the room, and ranged bots will spread in a circle around the center point.
Bots will attempt to spread out as much as possible after Ground Slam is used in advance of Shatter. 
* Tips & Tricks: In appropriate gear levels, the bots are likely to start dying to Shatter before 10 stacks of Growth, as they do not spread as well as coordinated players. This should be plenty of time to kill Gruul with IP nerfs and pre-raid gear (not even pre-raid BiS needed), but if you are struggling to get the kill before then, you may need to farm more gear or better optimize the composition of your raid.


## Wrath of the Lich King

### Naxxramas

**Anub'Rekhan**

* Defeatable Solo with Bots: Yes, with coded strategies, with some manual control recommended.
* Coded Strategies: ??
* Tips & Tricks: For better ranged bot positioning use `/ra @ranged disperse set 20` to avoid [Impale](https://wowgaming.altervista.org/aowow/?spell=28783).

**Grand Widow Faerlina**

* Defeatable Solo with Bots: Yes, with no coded strategies or manual control needed.
* Coded Strategies: None
* Tips & Tricks: Focus all damage on boss using skull mark. Adds will die from aoe.

**Maexxna**

* Defeatable Solo with Bots: Yes, with with some manual control needed.
* Coded Strategies: None
* Tips & Tricks: To command bot to free from [Web Wrap](https://wowgaming.altervista.org/aowow/?spell=28622) use [targeting macro](https://github.com/liyunfan1223/mod-playerbots/wiki/Playerbot-Macro-Collection#targeting-predefinied-creature). Use [bloodlust/heroism macro](https://github.com/liyunfan1223/mod-playerbots/wiki/Playerbot-Macro-Collection#bloodlustheroism) to focus damage when boss reach 30% HP and use [Frenzy](https://wowgaming.altervista.org/aowow/?spell=28747)

**Patchwerk**

* Defeatable Solo with Bots: Yes, with with some manual control needed.
* Coded Strategies: None
* Tips & Tricks: Melee bots will be targeted by [Hateful Strike](https://wowgaming.altervista.org/aowow/?spell=41926) then take more tanks or ranged. Use [bloodlust/heroism macro](https://github.com/liyunfan1223/mod-playerbots/wiki/Playerbot-Macro-Collection#bloodlustheroism) to focus damage when boss reach 5% HP and use [Frenzy](https://wowgaming.altervista.org/aowow/?spell=28131)

### Vault of Archavon
To set proper faction which controls Wintergrasp use commands \
`.bf switch 1` \
`.bf timer 1 0h00m01s`

**Koralon the Flame Watcher**

* Defeatable Solo with Bots: Yes, with coded strategies, with some manual control recommended.
* Coded Strategies: 
    * auto apply fire resistance aura
* Tips & Tricks: For better ranged bot positioning use `/ra @ranged disperse set 6` to avoid [Flaming Cinder](https://wowgaming.altervista.org/aowow/?spell=66684).