/*
    Pre-populates the activity grid with cells covering the map.

    Returns: BOOL
*/

["initActivityGrid"] call VIC_fnc_debugLog;

if (!isServer) exitWith {false};

STALKER_activityGrid = [];
if (isNil "STALKER_activityMarkers") then { STALKER_activityMarkers = [] };

private _size = missionNamespace getVariable ["STALKER_activityGridSize", 500];
private _max = floor (worldSize / _size);

for "_gx" from 0 to _max do {
    for "_gy" from 0 to _max do {
        private _key = format ["%1_%2", _gx, _gy];
        STALKER_activityGrid pushBack [_key, false];
    };
};

// Draw initial grid markers in debug mode
[] call VIC_fnc_updateActivityGrid;

true
