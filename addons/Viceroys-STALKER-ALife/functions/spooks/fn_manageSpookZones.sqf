/*
    Manages spawned spook zones by toggling their units based on activity.
    drg_activeSpookZones entries are trigger objects with variables:
        spawnedSpooks - array of spawned units
        zoneMarker    - marker name
        spookClass    - unit class to spawn
        spookCount    - number of units to spawn
*/

// ["manageSpookZones"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "drg_activeSpookZones") exitWith {};

private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    private _zone = _x;
    if (isNull _zone) then { continue };

    private _pos = getPosATL _zone;
    private _active = _zone getVariable ["VIC_active", true];
    private _newActive = [_pos,_range,_active] call VIC_fnc_evalSiteProximity;
    _zone setVariable ["VIC_active", _newActive];

    private _spawned = _zone getVariable ["spawnedSpooks", []];
    private _marker  = _zone getVariable ["zoneMarker", ""];

    if ((_zone getVariable ["spookClass", ""]) isEqualTo "" && {(count _spawned) > 0}) then {
        _zone setVariable ["spookClass", typeOf (_spawned select 0)];
        _zone setVariable ["spookCount", count _spawned];
    };
    private _class = _zone getVariable ["spookClass", ""];
    private _count = _zone getVariable ["spookCount", 0];

    if (_newActive) then {
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
