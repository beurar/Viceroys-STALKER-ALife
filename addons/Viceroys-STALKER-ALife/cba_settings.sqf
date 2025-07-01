// CBA settings configuration for Viceroy's STALKER ALife
// Slider value arrays follow [min, max, default, step]

// -----------------------------------------------------------------------------
// Emission
// -----------------------------------------------------------------------------
[
    "VSA_AIPanicEnabled",
    "CHECKBOX",
    ["Enable AI Emission Panic", "AI units will attempt to find cover indoors or in trenches when an emission is building up."],
    "Viceroy's STALKER ALife - Emission",
    true
] call CBA_fnc_addSetting;


// -----------------------------------------------------------------------------
// Core
// -----------------------------------------------------------------------------
[
    "VSA_playerNearbyRange",
    "SLIDER",
    ["Player Nearby Range", "Distance used to check if players are near"],
    "Viceroy's STALKER ALife - Core",
    [0, 7500, 1500, 0]
] call CBA_fnc_addSetting;


[
    "VSA_autoInit",
    "CHECKBOX",
    ["Automatically Initialize", "Populate the world and start managers on mission start"],
    "Viceroy's STALKER ALife - Core",
    true
] call CBA_fnc_addSetting;

[
    "VSA_townRadius",
    "SLIDER",
    ["Town Radius", "Distance considered inside a town"],
    "Viceroy's STALKER ALife - Core",
    [0, 1500, 500, 0]
] call CBA_fnc_addSetting;

[
    "VSA_townHysteresis",
    "SLIDER",
    ["Town Hysteresis", "Extra distance beyond town radius for debug markers"],
    "Viceroy's STALKER ALife - Core",
    [0, 1000, 200, 0]
] call CBA_fnc_addSetting;






/*
    cba_settings.sqf
    Registers addon options for Viceroys STALKER ALife.
    Each subsystem exposes basic options such as toggles,
    counts, spawn weights and night-only behaviour.
*/

// -----------------------------------------------------------------------------
// Anomalies
// -----------------------------------------------------------------------------
[
    "VSA_enableAnomalies",
    "CHECKBOX",
    ["Enable Anomaly Fields", "Toggle anomaly field spawning"],
    "Viceroy's STALKER ALife - Anomalies",
    true
] call CBA_fnc_addSetting;

[
    "VSA_anomalyFieldCount",
    "SLIDER",
    ["Anomaly Fields per Area", "Number of fields spawned per area"],
    "Viceroy's STALKER ALife - Anomalies",
    [0, 50, 3, 0]
] call CBA_fnc_addSetting;

[
    "VSA_maxAnomalyFields",
    "SLIDER",
    ["Max Active Fields", "Maximum number of anomaly fields present at once"],
    "Viceroy's STALKER ALife - Anomalies",
    [0, 200, 20, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomalySpawnWeight",
    "SLIDER",
    ["Anomaly Spawn Weight", "Relative spawn chance of anomaly types"],
    "Viceroy's STALKER ALife - Anomalies",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

// Individual anomaly spawn weights
["VSA_anomalyWeight_Burner","SLIDER",["Burner Weight","Relative spawn chance for Burner fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Clicker","SLIDER",["Clicker Weight","Relative spawn chance for Clicker fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Electra","SLIDER",["Electra Weight","Relative spawn chance for Electra fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Fruitpunch","SLIDER",["Fruit Punch Weight","Relative spawn chance for Fruit Punch fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Gravi","SLIDER",["Gravi Weight","Relative spawn chance for Gravi fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Meatgrinder","SLIDER",["Meatgrinder Weight","Relative spawn chance for Meatgrinder fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Springboard","SLIDER",["Springboard Weight","Relative spawn chance for Springboard fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Whirligig","SLIDER",["Whirligig Weight","Relative spawn chance for Whirligig fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Launchpad","SLIDER",["Launchpad Weight","Relative spawn chance for Launchpad fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Leech","SLIDER",["Leech Weight","Relative spawn chance for Leech fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Trapdoor","SLIDER",["Trapdoor Weight","Relative spawn chance for Trapdoor fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Zapper","SLIDER",["Zapper Weight","Relative spawn chance for Zapper fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyWeight_Bridge","SLIDER",["Bridge Anomaly Weight","Relative spawn chance for Bridge anomaly fields"],"Viceroy's STALKER ALife - Anomaly Weights",[0,100,100,0]] call CBA_fnc_addSetting;

// Individual anomaly density multipliers
["VSA_anomalyDensity_Burner","SLIDER",["Burner Density","Multiplier for Burner anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Clicker","SLIDER",["Clicker Density","Multiplier for Clicker anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Electra","SLIDER",["Electra Density","Multiplier for Electra anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Fruitpunch","SLIDER",["Fruit Punch Density","Multiplier for Fruit Punch anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Gravi","SLIDER",["Gravi Density","Multiplier for Gravi anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Meatgrinder","SLIDER",["Meatgrinder Density","Multiplier for Meatgrinder anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Springboard","SLIDER",["Springboard Density","Multiplier for Springboard anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Whirligig","SLIDER",["Whirligig Density","Multiplier for Whirligig anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Launchpad","SLIDER",["Launchpad Density","Multiplier for Launchpad anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Leech","SLIDER",["Leech Density","Multiplier for Leech anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Trapdoor","SLIDER",["Trapdoor Density","Multiplier for Trapdoor anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Zapper","SLIDER",["Zapper Density","Multiplier for Zapper anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;
["VSA_anomalyDensity_Bridge","SLIDER",["Bridge Anomaly Density","Multiplier for Bridge anomaly count"],"Viceroy's STALKER ALife - Anomaly Density",[0,300,100,0]] call CBA_fnc_addSetting;

[
    "VSA_stableFieldChance",
    "SLIDER",
    ["Stable Field Chance", "Percentage of fields that are stable"],
    "Viceroy's STALKER ALife - Anomalies",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomalyFieldRadius",
    "SLIDER",
    ["Anomaly Field Radius", "Radius of each anomaly field"],
    "Viceroy's STALKER ALife - Anomalies",
    [0, 2000, 200, 0]
] call CBA_fnc_addSetting;

["VSA_bridgeFieldRadius",
 "SLIDER",
 ["Bridge Field Radius", "Radius of bridge anomaly fields"],
 "Viceroy's STALKER ALife - Anomalies",
 [0, 2000, 200, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomaliesPerField",
    "SLIDER",
    ["Max Anomalies per Field", "Upper limit for anomalies spawned"],
    "Viceroy's STALKER ALife - Anomalies",
    [5, 200, 40, 0]
] call CBA_fnc_addSetting;

[
    "VSA_anomalyNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Anomalies only spawn at night"],
    "Viceroy's STALKER ALife - Anomalies",
    false
] call CBA_fnc_addSetting;

[
    "VSA_anomalyEmissionMode",
    "LIST",
    ["Field Change On Emission", "How anomaly fields react to emissions"],
    "Viceroy's STALKER ALife - Anomalies",
    [[0,1,2],["None","Shuffle","Replace"],1]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Chemical Zones
// -----------------------------------------------------------------------------
[
    "VSA_enableChemicalZones",
    "CHECKBOX",
    ["Enable Chemical Zones", "Toggle chemical gas zone spawning"],
    "Viceroy's STALKER ALife - Chemical",
    true
] call CBA_fnc_addSetting;

[
    "VSA_chemicalZoneCount",
    "SLIDER",
    ["Chemical Zones per Area", "Number of chemical zones created"],
    "Viceroy's STALKER ALife - Chemical",
    [0, 20, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_IEDSiteCount",
    "SLIDER",
    ["Total IED Sites", "Number of road IED locations maintained"],
    "Viceroy's STALKER ALife - Minefields",
    [0, 400, 10, 0]
] call CBA_fnc_addSetting;

[
    "VSA_chemicalSpawnWeight",
    "SLIDER",
    ["Chemical Spawn Weight", "Relative chance for chemical zone creation"],
    "Viceroy's STALKER ALife - Chemical",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_chemicalNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Chemical zones only appear at night"],
    "Viceroy's STALKER ALife - Chemical",
    false
] call CBA_fnc_addSetting;

[
    "VSA_chemicalZoneRadius",
    "SLIDER",
    ["Chemical Zone Radius", "Radius of each chemical zone"],
    "Viceroy's STALKER ALife - Chemical",
    [0, 250, 50, 0]
] call CBA_fnc_addSetting;

["VSA_chemicalGasType",
 "LIST",
 ["Chemical Gas Type", "Gas used for chemical zones"],
 "Viceroy's STALKER ALife - Chemical",
 [[0,1,2,3,4],["CS","Asphyxiant","Nerve","Blister","Nova"],1]
] call CBA_fnc_addSetting;

[
    "VSA_emissionChemicalCount",
    "SLIDER",
    ["Zones After Emission", "Chemical zones spawned after an emission"],
    "VSA - Chemical",
    [0, 50, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_emissionChemicalRadius",
    "SLIDER",
    ["Emission Chemical Radius", "Search radius around players for emission zones"],
    "VSA - Chemical",
    [50, 2000, 300, 0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Mutants
// -----------------------------------------------------------------------------
[
    "VSA_enableMutants",
    "CHECKBOX",
    ["Enable Mutants", "Toggle mutant spawning"],
    "Viceroy's STALKER ALife - Mutants",
    true
] call CBA_fnc_addSetting;

[
    "VSA_mutantGroupCount",
    "SLIDER",
    ["Mutant Groups per Area", "Number of mutant groups"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 50, 3, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantSpawnWeight",
    "SLIDER",
    ["Mutant Spawn Weight", "Relative chance for mutant spawns"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Mutants only spawn at night"],
    "Viceroy's STALKER ALife - Mutants",
    false
] call CBA_fnc_addSetting;

// Individual mutant enable toggles
["VSA_enableBloodsucker","CHECKBOX",["Enable Bloodsuckers","Allow bloodsucker spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableBoar","CHECKBOX",["Enable Boars","Allow boar spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableCat","CHECKBOX",["Enable Cats","Allow cat spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableFlesh","CHECKBOX",["Enable Flesh","Allow flesh spawns"],"Viceroy's STALKER ALife - Mutants",false] call CBA_fnc_addSetting;
["VSA_enableBlindDog","CHECKBOX",["Enable Blind Dogs","Allow blind dog spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enablePseudodog","CHECKBOX",["Enable Pseudodogs","Allow pseudodog spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableSnork","CHECKBOX",["Enable Snorks","Allow snork spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableController","CHECKBOX",["Enable Controllers","Allow controller spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enablePseudogiant","CHECKBOX",["Enable Pseudogiants","Allow pseudogiant spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableIzlom","CHECKBOX",["Enable Izlom","Allow izlom spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableCorruptor","CHECKBOX",["Enable Corruptors","Allow corruptor spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableSmasher","CHECKBOX",["Enable Smashers","Allow smasher spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableAcidSmasher","CHECKBOX",["Enable Acid Smashers","Allow acid smasher spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableBehemoth","CHECKBOX",["Enable Behemoths","Allow behemoth spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableParasite","CHECKBOX",["Enable Parasites","Allow parasite spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableJumper","CHECKBOX",["Enable Jumpers","Allow jumper spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableSpitter","CHECKBOX",["Enable Spitters","Allow spitter spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableStalker","CHECKBOX",["Enable Stalkers","Allow stalker mutant spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableBully","CHECKBOX",["Enable Bullies","Allow bully spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableHivemind","CHECKBOX",["Enable Hiveminds","Allow hivemind spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableZombie","CHECKBOX",["Enable Zombies","Allow zombie spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;
["VSA_enableChimera","CHECKBOX",["Enable Chimeras","Allow chimera spawns"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Stalkers
// -----------------------------------------------------------------------------
[
    "VSA_enableAmbientStalkers",
    "CHECKBOX",
    ["Enable Ambient Stalkers", "Toggle roaming stalker groups"],
    "Viceroy's STALKER ALife - Wandering Stalkers",
    true
] call CBA_fnc_addSetting;

[
    "VSA_ambientStalkerGroups",
    "SLIDER",
    ["Stalker Groups per Area", "Number of roaming stalker groups"],
    "Viceroy's STALKER ALife - Wandering Stalkers",
    [0, 20, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_ambientStalkerSize",
    "SLIDER",
    ["Stalker Group Size", "Units per ambient group"],
    "Viceroy's STALKER ALife - Wandering Stalkers",
    [1, 12, 4, 0]
] call CBA_fnc_addSetting;

[
    "VSA_ambientStalkerNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Ambient stalkers spawn only at night"],
    "Viceroy's STALKER ALife - Wandering Stalkers",
    false
] call CBA_fnc_addSetting;

[
    "VSA_enableStalkerCamps",
    "CHECKBOX",
    ["Enable Stalker Camps", "Toggle stalker camp spawning"],
    "Viceroy's STALKER ALife - Stalker Camps",
    true
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampCount",
    "SLIDER",
    ["Stalker Camps per Area", "Number of stalker camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 20, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampSize",
    "SLIDER",
    ["Stalker Camp Size", "Units defending each camp"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [1, 12, 4, 0]
] call CBA_fnc_addSetting;

[
    "VSA_minCampPositions",
    "SLIDER",
    ["Min Building Positions", "Minimum number of positions inside camp buildings"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 20, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampSpacing",
    "SLIDER",
    ["Camp Spacing", "Minimum distance between camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 1000, 300, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampBLUChance",
    "SLIDER",
    ["BLUFOR Camp Chance", "Relative chance for BLUFOR camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 100, 34, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampOPFChance",
    "SLIDER",
    ["OPFOR Camp Chance", "Relative chance for OPFOR camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 100, 33, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stalkerCampINDChance",
    "SLIDER",
    ["Independent Camp Chance", "Relative chance for independent camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 100, 33, 0]
] call CBA_fnc_addSetting;

[
    "VSA_minStalkerCamps",
    "SLIDER",
    ["Min Active Camps", "Minimum number of stalker camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 50, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_maxStalkerCamps",
    "SLIDER",
    ["Max Active Camps", "Maximum number of stalker camps"],
    "Viceroy's STALKER ALife - Stalker Camps",
    [0, 50, 5, 0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Spooks
// -----------------------------------------------------------------------------
[
    "VSA_enableSpooks",
    "CHECKBOX",
    ["Enable Spook Zones", "Toggle paranormal event spawning"],
    "Viceroy's STALKER ALife - Spooks",
    true
] call CBA_fnc_addSetting;

[
    "VSA_spookZoneCount",
    "SLIDER",
    ["Spook Zones per Area", "Number of paranormal zones"],
    "Viceroy's STALKER ALife - Spooks",
    [0, 10, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_spookSpawnWeight",
    "SLIDER",
    ["Spook Spawn Weight", "Relative chance for spook events"],
    "Viceroy's STALKER ALife - Spooks",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
"VSA_spooksNightOnly",
"CHECKBOX",
["Night Time Only", "Spooks are active only at night"],
"Viceroy's STALKER ALife - Spooks",
true
] call CBA_fnc_addSetting;

// Individual spook configuration
[
    "VSA_abominationCount",
    "SLIDER",
    ["Abomination Count", "Units spawned when an Abomination zone appears"],
    "Viceroy's STALKER ALife - Spooks",
    [0, 10, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_abominationSpawnWeight",
    "SLIDER",
    ["Abomination Spawn Weight", "Relative chance to choose an Abomination"],
    "Viceroy's STALKER ALife - Spooks",
    [0, 100, 100, 0]
] call CBA_fnc_addSetting;

[
    "VSA_abominationTime",
    "LIST",
    ["Abomination Active Time", "When Abominations may spawn"],
    "Viceroy's STALKER ALife - Spooks",
    [[0,1,2],["Both","Night Only","Day Only"],1]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Storms
// -----------------------------------------------------------------------------
[
    "VSA_enableStorms",
    "CHECKBOX",
    ["Enable Psy-Storms", "Toggle psy-storm events"],
    "Viceroy's STALKER ALife - Storms",
    true
] call CBA_fnc_addSetting;

[
    "VSA_stormInterval",
    "SLIDER",
    ["Storm Interval (min)", "Minutes between possible storms"],
    "Viceroy's STALKER ALife - Storms",
    [0, 150, 30, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stormSpawnWeight",
    "SLIDER",
    ["Storm Spawn Weight", "Relative chance for a storm to occur"],
    "Viceroy's STALKER ALife - Storms",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_stormsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Storms only trigger at night"],
    "Viceroy's STALKER ALife - Storms",
    false
] call CBA_fnc_addSetting;

["VSA_stormMinDelay","SLIDER",["Min Delay (s)","Minimum seconds between storms"],"Viceroy's STALKER ALife - Storms",[0,7200,1800,0]] call CBA_fnc_addSetting;
["VSA_stormMaxDelay","SLIDER",["Max Delay (s)","Maximum seconds between storms"],"Viceroy's STALKER ALife - Storms",[0,7200,3600,0]] call CBA_fnc_addSetting;
["VSA_stormDuration","SLIDER",["Storm Duration (s)","Length of each psy-storm"],"Viceroy's STALKER ALife - Storms",[30,600,180,0]] call CBA_fnc_addSetting;
["VSA_stormLightningStart","SLIDER",["Lightning Start","Lightning strikes per second at storm start"],"Viceroy's STALKER ALife - Storms",[6,200,6,0]] call CBA_fnc_addSetting;
["VSA_stormLightningEnd","SLIDER",["Lightning End","Lightning strikes per second when storm ends"],"Viceroy's STALKER ALife - Storms",[6,200,12,0]] call CBA_fnc_addSetting;
["VSA_stormDischargeStart","SLIDER",["Discharge Start","Psy discharge occurrences per second at storm start"],"Viceroy's STALKER ALife - Storms",[6,200,6,0]] call CBA_fnc_addSetting;
["VSA_stormDischargeEnd","SLIDER",["Discharge End","Psy discharge occurrences per second when storm ends"],"Viceroy's STALKER ALife - Storms",[6,200,12,0]] call CBA_fnc_addSetting;
["VSA_stormFogEnd","SLIDER",["Fog at Peak","Fog level when the storm peaks"],"Viceroy's STALKER ALife - Storms",[0,1,0.6,2]] call CBA_fnc_addSetting;
["VSA_stormRainEnd","SLIDER",["Rain at Peak","Rain intensity when the storm peaks"],"Viceroy's STALKER ALife - Storms",[0,1,0.8,2]] call CBA_fnc_addSetting;

["VSA_stormRadius","SLIDER",["Storm Radius","Maximum distance from players for storm effects"],"Viceroy's STALKER ALife - Storms",[100,7500,1500,0]] call CBA_fnc_addSetting;

["VSA_stormGasDischarges","CHECKBOX",["Gas Under Discharges","Spawn Nova gas clouds at discharge locations"],"Viceroy's STALKER ALife - Storms",true] call CBA_fnc_addSetting;

// Size of the spawned Nova mist in meters
["VSA_stormGasRadius","SLIDER",["Gas Radius","Nova mist radius at each discharge"],"Viceroy's STALKER ALife - Storms",[0,50,20,0]] call CBA_fnc_addSetting;

// How thick/dense the mist appears
["VSA_stormGasDensity","SLIDER",["Gas Density","Mist thickness at each discharge"],"Viceroy's STALKER ALife - Storms",[1,10,3,0]] call CBA_fnc_addSetting;

// Vertical spread from the ground up or down
["VSA_stormGasVertical","SLIDER",["Gas Vertical Spread","Vertical spread of the mist"],"Viceroy's STALKER ALife - Storms",[-2,2,1,2]] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Blowouts
// -----------------------------------------------------------------------------
[
    "VSA_enableBlowouts",
    "CHECKBOX",
    ["Enable Blowouts", "Toggle emission blowouts"],
    "Viceroy's STALKER ALife - Blowouts",
    true
] call CBA_fnc_addSetting;

["VSA_blowoutMinDelay","SLIDER",["Min Delay (h)","Minimum hours between blowouts"],"Viceroy's STALKER ALife - Blowouts",[0,168,12,0]] call CBA_fnc_addSetting;
["VSA_blowoutMaxDelay","SLIDER",["Max Delay (h)","Maximum hours between blowouts"],"Viceroy's STALKER ALife - Blowouts",[0,168,72,0]] call CBA_fnc_addSetting;
["VSA_blowoutDurationMin","SLIDER",["Min Duration (s)","Shortest blowout length"],"Viceroy's STALKER ALife - Blowouts",[60,3600,300,0]] call CBA_fnc_addSetting;
["VSA_blowoutDurationMax","SLIDER",["Max Duration (s)","Longest blowout length"],"Viceroy's STALKER ALife - Blowouts",[60,3600,900,0]] call CBA_fnc_addSetting;
["VSA_blowoutDirection","SLIDER",["Wave Direction","Approach direction in degrees"],"Viceroy's STALKER ALife - Blowouts",[0,359,0,0]] call CBA_fnc_addSetting;
["VSA_blowoutSpeedMin","SLIDER",["Wave Speed Min","Minimum wave speed"],"Viceroy's STALKER ALife - Blowouts",[50,300,125,0]] call CBA_fnc_addSetting;
["VSA_blowoutSpeedMax","SLIDER",["Wave Speed Max","Maximum wave speed"],"Viceroy's STALKER ALife - Blowouts",[50,300,125,0]] call CBA_fnc_addSetting;

// kill AI units caught outside during a blowout
["VSA_killAIEmission","CHECKBOX",["Kill Unsheltered AI","AI without shelter die during a blowout"],"Viceroy's STALKER ALife - Blowouts",true] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Overcast behaviour
// -----------------------------------------------------------------------------
["VSA_stormOvercast","SLIDER",["Storm Overcast","Cloud coverage during a storm"],"Viceroy's STALKER ALife - Storms",[0,1,1,2]] call CBA_fnc_addSetting;
["VSA_stormOvercastTime","SLIDER",["Overcast Transition (s)","Seconds to reach full overcast"],"Viceroy's STALKER ALife - Storms",[0,300,60,0]] call CBA_fnc_addSetting;


// -----------------------------------------------------------------------------
// Zombification
// -----------------------------------------------------------------------------
[
    "VSA_enableZombification",
    "CHECKBOX",
    ["Enable Zombification", "Toggle NPC zombification mechanics"],
    "Viceroy's STALKER ALife - Zombification",
    true
] call CBA_fnc_addSetting;

[
    "VSA_zombieCount",
    "SLIDER",
    ["Max Zombies", "Maximum zombies spawned from bodies"],
    "Viceroy's STALKER ALife - Zombification",
    [0, 100, 15, 0]
] call CBA_fnc_addSetting;

[
    "VSA_zombieSpawnWeight",
    "SLIDER",
    ["Zombie Spawn Weight", "Relative chance that dead bodies zombify"],
    "Viceroy's STALKER ALife - Zombification",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_zombiesNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Bodies zombify only at night"],
    "Viceroy's STALKER ALife - Zombification",
    false
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Necroplague
// -----------------------------------------------------------------------------
[
    "VSA_enableNecroplague",
    "CHECKBOX",
    ["Enable Necroplague", "Allow periodic zombie hordes"],
    "Viceroy's STALKER ALife - Necroplague",
    true
] call CBA_fnc_addSetting;
[
    "VSA_necroMinDelay",
    "SLIDER",
    ["Min Delay (s)", "Minimum seconds between necroplague events"],
    "Viceroy's STALKER ALife - Necroplague",
    [0,7200,1800,0]
] call CBA_fnc_addSetting;
[
    "VSA_necroMaxDelay",
    "SLIDER",
    ["Max Delay (s)", "Maximum seconds between necroplague events"],
    "Viceroy's STALKER ALife - Necroplague",
    [0,7200,3600,0]
] call CBA_fnc_addSetting;
[
    "VSA_necroHordes",
    "SLIDER",
    ["Hordes per Player", "Number of zombie groups around each player"],
    "Viceroy's STALKER ALife - Necroplague",
    [1,5,2,0]
] call CBA_fnc_addSetting;
[
    "VSA_necroZombies",
    "SLIDER",
    ["Zombies per Horde", "Zombies spawned in each group"],
    "Viceroy's STALKER ALife - Necroplague",
    [1,20,5,0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// AI Behaviour
// -----------------------------------------------------------------------------
[
    "VSA_enableAIBehaviour",
    "CHECKBOX",
    ["Enable AI Behaviour Tweaks", "Toggle custom AI behaviour"],
    "Viceroy's STALKER ALife - AI",
    true
] call CBA_fnc_addSetting;

[
    "VSA_panicThreshold",
    "SLIDER",
    ["AI Panic Threshold", "Chance for AI to panic when threatened"],
    "Viceroy's STALKER ALife - AI",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_aiNightOnly",
    "CHECKBOX",
    ["Night Time Only", "AI tweaks only active at night"],
    "Viceroy's STALKER ALife - AI",
    false
] call CBA_fnc_addSetting;

[
    "VSA_aiAnomalyAvoidChance",
    "SLIDER",
    ["Anomaly Avoid Chance", "Chance AI moves away from nearby anomalies"],
    "Viceroy's STALKER ALife - AI",
    [0, 100, 50, 0]
] call CBA_fnc_addSetting;

[
    "VSA_aiAnomalyAvoidRange",
    "SLIDER",
    ["Anomaly Avoid Range", "Distance to check for anomalies around AI"],
    "Viceroy's STALKER ALife - AI",
    [0, 100, 20, 0]
] call CBA_fnc_addSetting;

[
    "VSA_fieldAvoidEnabled",
    "CHECKBOX",
    ["Avoid Anomaly Fields", "AI will steer clear of anomaly field areas"],
    "Viceroy's STALKER ALife - AI",
    true
] call CBA_fnc_addSetting;


// Hostile mutant spawns
[
    "VSA_mutantGroupCountHostile",
    "SLIDER",
    ["Post-Emission Groups", "Number of mutant groups after an emission"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 25, 1, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantThreat",
    "SLIDER",
    ["Units per Hostile Group", "Units spawned in each hostile group"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 30, 3, 0]
] call CBA_fnc_addSetting;

[
    "VSA_mutantNightOnlyHostile",
    "CHECKBOX",
    ["Night Time Only", "Spawn hostile groups only at night"],
    "Viceroy's STALKER ALife - Mutants",
    false
] call CBA_fnc_addSetting;

// Ambient herds
[
    "VSA_ambientHerdCount",
    "SLIDER",
    ["Roaming Herds", "Number of roaming herds"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 10, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_ambientHerdSize",
    "SLIDER",
    ["Herd Size", "Units per roaming herd"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 50, 4, 0]
] call CBA_fnc_addSetting;

[
    "VSA_ambientNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Spawn herds only at night"],
    "Viceroy's STALKER ALife - Mutants",
    false
] call CBA_fnc_addSetting;

["VSA_predatorAttackChance","SLIDER",["Predator Attack Chance","Chance each check to spawn an ambush"],"Viceroy's STALKER ALife - Mutants",[0, 100, 5, 0]] call CBA_fnc_addSetting;
["VSA_predatorRange","SLIDER",["Predator Range","Distance from players to spawn predators"],"Viceroy's STALKER ALife - Mutants",[0, 7500, 1500, 0]] call CBA_fnc_addSetting;
["VSA_predatorCheckIntervalDay","SLIDER",["Predator Check (Day)","Seconds between predator attack checks during daylight"],"Viceroy's STALKER ALife - Mutants",[60, 900, 600, 0]] call CBA_fnc_addSetting;
["VSA_predatorCheckIntervalNight","SLIDER",["Predator Check (Night)","Seconds between predator attack checks at night"],"Viceroy's STALKER ALife - Mutants",[60, 900, 300, 0]] call CBA_fnc_addSetting;
["VSA_proximityCheckInterval","SLIDER",["Proximity Check Interval","Seconds between player distance checks (0 for constant)"],"Viceroy's STALKER ALife - Mutants",[0, 300, 0, 0]] call CBA_fnc_addSetting;
["VSA_habitatCheckInterval","SLIDER",["Habitat Check Interval","Seconds between habitat updates"],"Viceroy's STALKER ALife - Mutants",[1, 60, 5, 0]] call CBA_fnc_addSetting;

[
    "VSA_maxAmbientHerds",
    "SLIDER",
    ["Max Active Herds", "Maximum number of roaming herds"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 100, 5, 0]
] call CBA_fnc_addSetting;

[
    "VSA_maxHostileGroups",
    "SLIDER",
    ["Max Hostile Groups", "Maximum active hostile mutant groups"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 50, 5, 0]
] call CBA_fnc_addSetting;

[
    "VSA_maxMutantNests",
    "SLIDER",
    ["Max Mutant Nests", "Maximum active bloodsucker nests"],
    "Viceroy's STALKER ALife - Mutants",
    [0, 30, 3, 0]
] call CBA_fnc_addSetting;

[
    "VSA_nestsNightOnly",
    "CHECKBOX",
    ["Night Time Nests", "Generate nests only during night"],
    "Viceroy's STALKER ALife - Mutants",
    true
] call CBA_fnc_addSetting;

["VSA_habitatSize_Bloodsucker","SLIDER",["Bloodsucker Habitat Size","Max bloodsuckers per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 60, 12, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Dog","SLIDER",["Dog Habitat Size","Max dogs per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 250, 50, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Boar","SLIDER",["Boar Habitat Size","Max boars per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 50, 10, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Cat","SLIDER",["Cat Habitat Size","Max cats per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 50, 10, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Flesh","SLIDER",["Flesh Habitat Size","Max flesh per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 50, 10, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Pseudodog","SLIDER",["Pseudodog Habitat Size","Max pseudodogs per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 100, 20, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Controller","SLIDER",["Controller Habitat Size","Max controllers per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 40, 8, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Pseudogiant","SLIDER",["Pseudogiant Habitat Size","Max pseudogiants per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 30, 6, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Izlom","SLIDER",["Izlom Habitat Size","Max izlom per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 50, 10, 0]] call CBA_fnc_addSetting;
["VSA_habitatSize_Snork","SLIDER",["Snork Habitat Size","Max snorks per habitat"],"Viceroy's STALKER ALife - Mutants",[0, 60, 12, 0]] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Ambushes
// -----------------------------------------------------------------------------
["VSA_enableAmbushes","CHECKBOX",["Enable Ambushes","Toggle road ambush spawning"],"Viceroy's STALKER ALife - Ambushes",true] call CBA_fnc_addSetting;
["VSA_ambushCount","SLIDER",["Ambushes per Area","Number of ambush sites generated"],"Viceroy's STALKER ALife - Ambushes",[0,20,3,0]] call CBA_fnc_addSetting;
["VSA_ambushTownDistance","SLIDER",["Outside Town Distance","Distance beyond the town radius for ambush placement"],"Viceroy's STALKER ALife - Ambushes",[50,1000,200,0]] call CBA_fnc_addSetting;
["VSA_ambushMinUnits","SLIDER",["Min Units","Minimum units spawned at an ambush"],"Viceroy's STALKER ALife - Ambushes",[0,20,3,0]] call CBA_fnc_addSetting;
["VSA_ambushMaxUnits","SLIDER",["Max Units","Maximum units spawned at an ambush"],"Viceroy's STALKER ALife - Ambushes",[0,20,6,0]] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Minefields
// -----------------------------------------------------------------------------
[
    "VSA_enableMinefields",
    "CHECKBOX",
    ["Enable Minefields", "Toggle spawning of minefields"],
    "Viceroy's STALKER ALife - Minefields",
    true
] call CBA_fnc_addSetting;

[
    "VSA_minefieldCount",
    "SLIDER",
    ["APERS Fields per Area", "Number of APERS minefields generated"],
    "Viceroy's STALKER ALife - Minefields",
    [0, 400, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_minefieldSize",
    "SLIDER",
    ["APERS Field Radius", "Radius in meters for APERS minefields"],
    "Viceroy's STALKER ALife - Minefields",
    [10, 200, 30, 0]
] call CBA_fnc_addSetting;

[
    "VSA_IEDCount",
    "SLIDER",
    ["IEDs per Area", "Number of IEDs placed on roads"],
    "Viceroy's STALKER ALife - Minefields",
    [0, 20, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_enableBoobyTraps",
    "CHECKBOX",
    ["Enable Booby Traps", "Place tripwires and booby traps in buildings"],
    "Viceroy's STALKER ALife - Minefields",
    true
] call CBA_fnc_addSetting;

[
    "VSA_boobyTrapCount",
    "SLIDER",
    ["Booby Traps per Area", "Number of building traps spawned"],
    "Viceroy's STALKER ALife - Minefields",
    [0, 20, 5, 0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Wrecks
// -----------------------------------------------------------------------------
[
    "VSA_enableWrecks",
    "CHECKBOX",
    ["Enable Abandoned Vehicles", "Spawn damaged vehicles near roads"],
    "Viceroy's STALKER ALife - Wrecks",
    true
] call CBA_fnc_addSetting;

[
    "VSA_wreckCount",
    "SLIDER",
    ["Abandoned Vehicle Count", "Number of vehicles spawned across the map"],
    "Viceroy's STALKER ALife - Wrecks",
    [0, 50, 10, 0]
] call CBA_fnc_addSetting;

// -----------------------------------------------------------------------------
// Antistasi Integration
// -----------------------------------------------------------------------------
[
    "VSA_disableA3UWeather",
    "CHECKBOX",
    ["Disable Antistasi Weather", "Stop Antistasi persistent weather script"],
    "Viceroy's STALKER ALife - Antistasi",
    false
] call CBA_fnc_addSetting;
// -----------------------------------------------------------------------------
// Debug
// -----------------------------------------------------------------------------
[
    "VSA_debugMode",
    "CHECKBOX",
    ["Enable Debug Mode", "Show on-screen logs and enable testing actions"],
    "Viceroy's STALKER ALife - Debug",
    false
] call CBA_fnc_addSetting;
