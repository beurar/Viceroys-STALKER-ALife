/*
    Scans the map for wreck objects and stores them in STALKER_wrecks
    for use by other functions.
    Returns: ARRAY of wreck objects found
*/

["findWrecks"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

// gather all objects and filter by class name
private _center = [worldSize / 2, worldSize / 2, 0];
private _objs = nearestObjects [_center, ["AllVehicles","Static"], worldSize];
private _found = _objs select { toLower typeOf _x find "wreck" > -1 };

if (isNil "STALKER_wrecks") then { STALKER_wrecks = [] };
{ if !(_x in STALKER_wrecks) then { STALKER_wrecks pushBack _x } } forEach _found;

[] call VIC_fnc_markWrecks;

[format ["findWrecks: %1 wrecks cached", count _found]] call VIC_fnc_debugLog;

_found
