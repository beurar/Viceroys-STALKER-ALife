// initServer.sqf
// Launch master initialization on the dedicated server
[] execVM "\Viceroys-STALKER-ALife\functions\core\fn_masterInit.sqf";
// Server initialization for STALKER ALife

// Spook zone configuration
STALKER_MinSpookFields = 2;      // minimum zones spawned per emission
STALKER_MaxSpookFields = 5;      // maximum zones spawned per emission
STALKER_SpookDuration  = 15;     // minutes zones remain active

drg_activeSpookZones = [];

// Prepare spook zone locations
[] call compile preprocessFileLineNumbers "\Viceroys-STALKER-ALife\functions\spooks\fn_setupSpookZones.sqf";

