## Pull

To make bots engage target and let tank build aggro (requires Slashin or ElvUI (not all versions) addon)
/in 8 determine delay before pull to other bots engage

```
/p @dps co +passive
/p @heal co +passive
/p @tank attack
/in 8 /p @dps co -passive
/in 8 /p @heal co -passive
```

## Bloodlust/Heroism

Stop bots using bloodlust/heroism

```
/p @shaman ss +2825,32182
```

Start bots again using bloodlust/heroism

```
/p @shaman ss -2825,32182
```

## Moving in fight

To make bots flee with you from the danger:

```
/p reset
/p nc -stay,+follow,+passive
/p co +passive
/p do follow
```

To make bots follow you and assist you in attack:

```
/p nc -stay,+follow,-passive
/p co -passive
/p do follow
```

To make bots stay in place and assist you in attack:

```
/p nc -follow,+stay,-passive
/p co +passive
/p do stay
```

## Targeting predefinied creature

To focus bots on target for example Web Wrap:

```
/target Web Wrap
/stopmacro [noharm][dead]
/script SetRaidTarget("target", 8)
```