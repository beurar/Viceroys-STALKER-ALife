/*
    Scans the map for wreck objects. Object references are stored in
    STALKER_wrecks for runtime use while their positions are returned and
    cached for persistence.
    Returns: ARRAY of POSITIONs
*/

["findWrecks"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

// gather all objects and filter by class name or model path
private _center = [worldSize / 2, worldSize / 2, 0];
private _objs = nearestObjects [_center, ["AllVehicles","Static"], worldSize];
private _found = _objs select {
    private _type = toLower typeOf _x;
    private _model = toLower ((getModelInfo _x) select 0);
    ("wreck" in _type) || { "wrecks" in _model }
};

if (isNil "STALKER_wrecks") then { STALKER_wrecks = [] };
if (isNil "STALKER_wreckPositions") then { STALKER_wreckPositions = [] };

private _positions = [];
{
    STALKER_wrecks pushBackUnique _x;
    private _pos = getPosATL _x;
    _positions pushBackUnique _pos;
    STALKER_wreckPositions pushBackUnique _pos;
} forEach _found;

[format ["findWrecks: %1 wrecks cached", count _positions]] call VIC_fnc_debugLog;

_positions
