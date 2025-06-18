/*
    Scans the map for wreck objects and stores them in STALKER_wrecks
    for use by other functions.
    Returns: ARRAY of wreck objects found
*/

["findWrecks"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

// gather all objects and filter by class name or model path
private _center = [worldSize / 2, worldSize / 2, 0];
private _objs = nearestObjects [_center, ["AllVehicles","Static"], worldSize];
private _found = _objs select {
    private _type = toLower typeOf _x;
    private _model = toLower ((getModelInfo _x) select 0);
    (_type find "wreck" > -1) || { _model find "wrecks" > -1 }
};

if (isNil "STALKER_wrecks") then { STALKER_wrecks = [] };
{ STALKER_wrecks pushBackUnique _x } forEach _found;

[format ["findWrecks: %1 wrecks cached", count _found]] call VIC_fnc_debugLog;

_found
