// initServer.sqf
// Launch master initialization on the server
// Works for both dedicated and locally hosted games


if (!isServer) exitWith {};

if !( ["VSA_autoInit", false] call VIC_fnc_getSetting ) exitWith {
    ["initServer: auto init disabled"] call VIC_fnc_debugLog;
    false
};

// Spook zone configuration
STALKER_MinSpookFields = 2;      	// minimum zones spawned per emission
STALKER_MaxSpookFields = 5;      	// maximum zones spawned per emission
STALKER_SpookDuration  = 15;     	// minutes zones remain active
STALKER_AnomalyFieldDuration = 30; 	// minutes anomaly fields persist

drg_activeSpookZones = [];
STALKER_activeSpooks = [];

// Global tracking arrays for spawned groups
STALKER_activeHerds = [];
STALKER_activeHostiles = [];
STALKER_activePredators = [];
STALKER_mutantNests = [];
STALKER_anomalyFields = [];
STALKER_minefields = [];
STALKER_boobyTraps = [];
STALKER_iedSites = [];
STALKER_panicGroups = [];
STALKER_wanderers = [];

// Prepare spook zone locations via debug action when needed
//[] call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_setupSpookZones.sqf";

// Anomaly fields, chemical zones and wrecks are now spawned through debug
// actions rather than during startup to speed up initialization.

// Minefields can be spawned via the debug action
// for "_i" from 1 to 50 do {
//     private _pos = [random worldSize, random worldSize, 0];
//     [_pos, 1000] call VIC_fnc_spawnMinefields;
// };

// Generate wrecks via debug action instead of automatically
// private _wreckCount = ["VSA_wreckCount", 10] call VIC_fnc_getSetting;
// [_wreckCount] call VIC_fnc_spawnAbandonedVehicles;


// Ambushes can be spawned via the debug action
// for "_i" from 1 to 20 do {
//     private _pos = [random worldSize, random worldSize, 0];
//     [_pos, 1000] call VIC_fnc_spawnAmbushes;
// };

// Automatically initialize map caches and spawn core sites
[] call VIC_fnc_initMap;
[] spawn VIC_fnc_spawnWorker;

private _center = [worldSize / 2, worldSize / 2, 0];
[_center, worldSize] call VIC_fnc_spawnMinefields;
[_center, worldSize] call VIC_fnc_spawnIEDSites;

[_center, worldSize] call VIC_fnc_spawnBoobyTraps;
[format ["initServer: %1 traps placed", count STALKER_boobyTraps]] call VIC_fnc_debugLog;

private _wreckCount = ["VSA_wreckCount", 10] call VIC_fnc_getSetting;
[_wreckCount] call VIC_fnc_spawnAbandonedVehicles;

// Automatically place anomaly fields across the map
[_center, worldSize, 1] call VIC_fnc_spawnAllAnomalyFields;
[1] call VIC_fnc_spawnBridgeAnomalyFields;

[] call VIC_fnc_initManagers;
