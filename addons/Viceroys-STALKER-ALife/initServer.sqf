// initServer.sqf
// Launch master initialization on the dedicated server
// Server initialization for STALKER ALife

// Spook zone configuration
STALKER_MinSpookFields = 2;      // minimum zones spawned per emission
STALKER_MaxSpookFields = 5;      // maximum zones spawned per emission
STALKER_SpookDuration  = 15;     // minutes zones remain active
STALKER_AnomalyFieldDuration = 30; // minutes anomaly fields persist

drg_activeSpookZones = [];
STALKER_activeSpooks = [];

// Global tracking arrays for spawned groups
STALKER_activeHerds = [];
STALKER_activeHostiles = [];
STALKER_activePredators = [];
STALKER_mutantNests = [];
STALKER_anomalyFields = [];
STALKER_minefields = [];

// Prepare spook zone locations
[] call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_setupSpookZones.sqf";

// Generate anomaly fields across the map
for "_i" from 1 to 100 do {
    private _pos = [random worldSize, random worldSize, 0];
    [_pos, 1000] call VIC_fnc_spawnAllAnomalyFields;
};

// Generate minefields across the map
for "_i" from 1 to 50 do {
    private _pos = [random worldSize, random worldSize, 0];
    [_pos, 1000] call VIC_fnc_spawnMinefields;
};

// Generate ambushes across the map
for "_i" from 1 to 20 do {
    private _pos = [random worldSize, random worldSize, 0];
    [_pos, 1000] call VIC_fnc_spawnAmbushes;
};

