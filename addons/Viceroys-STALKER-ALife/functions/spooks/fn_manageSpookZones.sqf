/*
    Manages spawned spook zones by toggling their units based on activity.
    drg_activeSpookZones entries are trigger objects with variables:
        spawnedSpooks - array of spawned units
        zoneMarker    - marker name
        spookClass    - unit class to spawn
        spookCount    - number of units to spawn
*/

["manageSpookZones"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "drg_activeSpookZones") exitWith {};

private _cellSize = missionNamespace getVariable ["STALKER_activityGridSize", 500];

{
    private _zone = _x;
    if (isNull _zone) then { continue };

    private _pos = getPosATL _zone;
    private _gx = floor ((_pos select 0) / _cellSize);
    private _gy = floor ((_pos select 1) / _cellSize);
    private _key = format ["%1_%2", _gx, _gy];
    private _active = false;
    if (!isNil "STALKER_activityGrid") then {
        {
            _x params ["_cell","_state"];
            if (_cell == _key) exitWith { _active = _state }; 
        } forEach STALKER_activityGrid;
    };

    private _spawned = _zone getVariable ["spawnedSpooks", []];
    private _marker  = _zone getVariable ["zoneMarker", ""];

    if ((_zone getVariable ["spookClass", ""]) isEqualTo "" && {(count _spawned) > 0}) then {
        _zone setVariable ["spookClass", typeOf (_spawned select 0)];
        _zone setVariable ["spookCount", count _spawned];
    };
    private _class = _zone getVariable ["spookClass", ""];
    private _count = _zone getVariable ["spookCount", 0];

    if (_active) then {
        private _alive = false;
        { if (!isNull _x) exitWith { _alive = true }; } forEach _spawned;
        if (!_alive && {_class != "" && _count > 0}) then {
            _spawned = [];
            for "_i" from 1 to _count do {
                private _s = createVehicle [_class, _pos, [], 0, "NONE"];
                _spawned pushBack _s;
                STALKER_activeSpooks pushBack _s;
            };
            _zone setVariable ["spawnedSpooks", _spawned];
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if ((count _spawned) > 0) then {
            {
                if (!isNull _x) then {
                    deleteVehicle _x;
                    STALKER_activeSpooks = STALKER_activeSpooks - [_x];
                };
            } forEach _spawned;
            _spawned = [];
            _zone setVariable ["spawnedSpooks", _spawned];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
} forEach drg_activeSpookZones;

true
