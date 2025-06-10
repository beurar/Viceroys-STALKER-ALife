// CBA settings configuration for Viceroy's STALKER ALife

// -----------------------------------------------------------------------------
// Emission
// -----------------------------------------------------------------------------
[
    "VSA_AIPanicEnabled",
    "CHECKBOX",
    ["Enable AI Emission Panic", "AI units will attempt to find cover indoors or in trenches when an emission is building up."],
    "VSA - Emission",
    true
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
    "VSA - Anomalies",
    true
] call cba_settings_fnc_init;

[
    "VSA_anomalyFieldCount",
    "SLIDER",
    ["Anomaly Fields per Area", "Number of fields spawned per area"],
    "VSA - Anomalies",
    [3, 0, 10, 0]
] call cba_settings_fnc_init;

[
    "VSA_anomalySpawnWeight",
    "SLIDER",
    ["Anomaly Spawn Weight", "Relative spawn chance of anomaly types"],
    "VSA - Anomalies",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_anomalyNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Anomalies only spawn at night"],
    "VSA - Anomalies",
    false
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// Radiation
// -----------------------------------------------------------------------------
[
    "VSA_enableRadiation",
    "CHECKBOX",
    ["Enable Radiation Zones", "Toggle radiation zone spawning"],
    "VSA - Radiation",
    true
] call cba_settings_fnc_init;

[
    "VSA_radiationZoneCount",
    "SLIDER",
    ["Radiation Zones per Area", "Number of radiation zones created"],
    "VSA - Radiation",
    [2, 0, 10, 0]
] call cba_settings_fnc_init;

[
    "VSA_radiationSpawnWeight",
    "SLIDER",
    ["Radiation Spawn Weight", "Relative chance for radiation zone creation"],
    "VSA - Radiation",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_radiationNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Radiation zones only appear at night"],
    "VSA - Radiation",
    false
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// Mutants
// -----------------------------------------------------------------------------
[
    "VSA_enableMutants",
    "CHECKBOX",
    ["Enable Mutants", "Toggle mutant spawning"],
    "VSA - Mutants",
    true
] call cba_settings_fnc_init;

[
    "VSA_mutantGroupCount",
    "SLIDER",
    ["Mutant Groups per Area", "Number of mutant groups"],
    "VSA - Mutants",
    [3, 0, 20, 0]
] call cba_settings_fnc_init;

[
    "VSA_mutantSpawnWeight",
    "SLIDER",
    ["Mutant Spawn Weight", "Relative chance for mutant spawns"],
    "VSA - Mutants",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_mutantsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Mutants only spawn at night"],
    "VSA - Mutants",
    false
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// Spooks
// -----------------------------------------------------------------------------
[
    "VSA_enableSpooks",
    "CHECKBOX",
    ["Enable Spook Zones", "Toggle paranormal event spawning"],
    "VSA - Spooks",
    true
] call cba_settings_fnc_init;

[
    "VSA_spookZoneCount",
    "SLIDER",
    ["Spook Zones per Area", "Number of paranormal zones"],
    "VSA - Spooks",
    [1, 0, 10, 0]
] call cba_settings_fnc_init;

[
    "VSA_spookSpawnWeight",
    "SLIDER",
    ["Spook Spawn Weight", "Relative chance for spook events"],
    "VSA - Spooks",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_spooksNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Spooks are active only at night"],
    "VSA - Spooks",
    true
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// Storms
// -----------------------------------------------------------------------------
[
    "VSA_enableStorms",
    "CHECKBOX",
    ["Enable Psy-Storms", "Toggle psy-storm events"],
    "VSA - Storms",
    true
] call cba_settings_fnc_init;

[
    "VSA_stormInterval",
    "SLIDER",
    ["Storm Interval (min)", "Minutes between possible storms"],
    "VSA - Storms",
    [30, 5, 120, 0]
] call cba_settings_fnc_init;

[
    "VSA_stormSpawnWeight",
    "SLIDER",
    ["Storm Spawn Weight", "Relative chance for a storm to occur"],
    "VSA - Storms",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_stormsNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Storms only trigger at night"],
    "VSA - Storms",
    false
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// Zombification
// -----------------------------------------------------------------------------
[
    "VSA_enableZombification",
    "CHECKBOX",
    ["Enable Zombification", "Toggle NPC zombification mechanics"],
    "VSA - Zombification",
    true
] call cba_settings_fnc_init;

[
    "VSA_zombieCount",
    "SLIDER",
    ["Max Zombies", "Maximum zombies spawned from bodies"],
    "VSA - Zombification",
    [15, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_zombieSpawnWeight",
    "SLIDER",
    ["Zombie Spawn Weight", "Relative chance that dead bodies zombify"],
    "VSA - Zombification",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_zombiesNightOnly",
    "CHECKBOX",
    ["Night Time Only", "Bodies zombify only at night"],
    "VSA - Zombification",
    false
] call cba_settings_fnc_init;

// -----------------------------------------------------------------------------
// AI Behaviour
// -----------------------------------------------------------------------------
[
    "VSA_enableAIBehaviour",
    "CHECKBOX",
    ["Enable AI Behaviour Tweaks", "Toggle custom AI behaviour"],
    "VSA - AI",
    true
] call cba_settings_fnc_init;

[
    "VSA_panicThreshold",
    "SLIDER",
    ["AI Panic Threshold", "Chance for AI to panic when threatened"],
    "VSA - AI",
    [50, 0, 100, 0]
] call cba_settings_fnc_init;

[
    "VSA_aiNightOnly",
    "CHECKBOX",
    ["Night Time Only", "AI tweaks only active at night"],
    "VSA - AI",
    false
] call cba_settings_fnc_init;


// Hostile mutant spawns
["VSA_mutantGroupCountHostile", "SLIDER", [1, 5, 1], 1, "Number of mutant groups after an emission"] call CBA_fnc_addSetting;
["VSA_mutantThreat", "SLIDER", [1, 10, 1], 3, "Units per hostile group"] call CBA_fnc_addSetting;
["VSA_mutantNightOnlyHostile", "CHECKBOX", false, "Spawn hostile groups only at night"] call CBA_fnc_addSetting;

// Ambient herds
["VSA_ambientHerdCount", "SLIDER", [0, 5, 1], 2, "Number of roaming herds"] call CBA_fnc_addSetting;
["VSA_ambientHerdSize", "SLIDER", [1, 8, 1], 4, "Units per roaming herd"] call CBA_fnc_addSetting;
["VSA_ambientNightOnly", "CHECKBOX", false, "Spawn herds only at night"] call CBA_fnc_addSetting;
