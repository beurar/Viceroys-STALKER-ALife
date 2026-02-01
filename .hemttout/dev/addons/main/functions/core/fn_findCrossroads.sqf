/*
    Identifies road positions that connect to three or more other road segments.

    Params:
        0: ARRAY - List of road positions. If empty, uses VIC_fnc_findRoads.

    Returns:
        ARRAY of positions on crossroads in AGL coordinates
*/
params [["_roads", []]];

if (_roads isEqualTo []) then {
    _roads = [] call VIC_fnc_findRoads;
};

[format ["findCrossroads scanning %1 points", count _roads]] call VIC_fnc_debugLog;

private _crossroads = [];

{
    private _roadObj = roadAt _x;
    if (isNull _roadObj) then {
        private _near = _x nearRoads 5;
        if (_near isNotEqualTo []) then { _roadObj = _near select 0; };
    };
    if (!isNull _roadObj) then {
        private _connections = roadsConnectedTo _roadObj;
            if ((count _connections) >= 3) then {
            private _pos = getPosATL _roadObj;
            if ((_crossroads select { _x distance _pos < 5 }) isEqualTo []) then {
                _crossroads pushBack _pos;
            };
        };
    };
} forEach _roads;

[format ["findCrossroads found %1 crossroads", count _crossroads]] call VIC_fnc_debugLog;

// Cache results for later use
if (isNil "STALKER_crossroads") then { STALKER_crossroads = [] };
{ STALKER_crossroads pushBackUnique _x } forEach _crossroads;

[format ["findCrossroads: %1 cached", count STALKER_crossroads]] call VIC_fnc_debugLog;

_crossroads

