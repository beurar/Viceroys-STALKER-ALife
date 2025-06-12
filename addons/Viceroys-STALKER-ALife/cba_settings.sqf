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
["VSA_stormDuration","SLIDER",["Storm Duration (s)","Length of each psy-storm"],"Viceroy's STALKER ALife - Storms",[5,300,60,0]] call CBA_fnc_addSetting;
["VSA_stormStrikeIntensity","SLIDER",["Strike Intensity","Psy discharges spawned per second"],"Viceroy's STALKER ALife - Storms",[1,20,3,0]] call CBA_fnc_addSetting;

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
["VSA_predatorCheckInterval","SLIDER",["Predator Check Interval","Seconds between predator attack checks"],"Viceroy's STALKER ALife - Mutants",[60, 900, 300, 0]] call CBA_fnc_addSetting;
["VSA_proximityCheckInterval","SLIDER",["Proximity Check Interval","Seconds between player distance checks"],"Viceroy's STALKER ALife - Mutants",[10, 300, 30, 0]] call CBA_fnc_addSetting;
["VSA_predatorNightOnly","CHECKBOX",["Night Time Attacks","Predators only attack at night"],"Viceroy's STALKER ALife - Mutants",true] call CBA_fnc_addSetting;

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
    [0, 20, 2, 0]
] call CBA_fnc_addSetting;

[
    "VSA_minefieldSize",
    "SLIDER",
    ["APERS Field Size", "Side length in meters for APERS minefields"],
    "Viceroy's STALKER ALife - Minefields",
    [10, 100, 30, 0]
] call CBA_fnc_addSetting;

[
    "VSA_IEDCount",
    "SLIDER",
    ["IEDs per Area", "Number of IEDs placed on roads"],
    "Viceroy's STALKER ALife - Minefields",
    [0, 20, 2, 0]
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
