/*
    Attempts to locate a nearby land position. The search gradually expands
    outwards until a valid spot is found or the maximum radius is reached.

    Params:
        0: POSITION or OBJECT - center position
        1: NUMBER            - initial search radius (default 50)
        2: NUMBER            - attempts per radius step (default 10)
        3: BOOL              - exclude towns from results (default false)
        4: NUMBER            - maximum search radius (default: radius * 1.5)

    Returns:
        ARRAY - ground position AGL or nil if none found
*/

params [
    "_centerPos",
    ["_radius", 50],
    ["_maxTries", 10],
    ["_excludeTowns", false],
    ["_maxRadius", -1]
];

private _base = if (_centerPos isEqualType objNull) then { getPos _centerPos } else { _centerPos };

_radius = _radius max 1;
if (_maxRadius < 0) then {
    _maxRadius = if (_radius < 200) then { _radius * 1.5 } else { _radius };
};

private _townRadius = ["VSA_townRadius", 500] call VIC_fnc_getSetting;
private _worldSize  = worldSize;

private _searchRadius = 0;
private _result = [];

scopeName "findLand";
while { _searchRadius <= _maxRadius && {_result isEqualTo []} } do {
    for "_i" from 0 to (_maxTries - 1) do {
        private _candidate = if (_searchRadius == 0 && {_i == 0}) then {
            _base
        } else {
            [_base, random _searchRadius, random 360] call BIS_fnc_relPos
        };

        if (
            (_candidate select 0 < 0) ||
            { _candidate select 1 < 0 } ||
            { _candidate select 0 > _worldSize } ||
            { _candidate select 1 > _worldSize }
        ) then { continue; };

        private _surf = [_candidate] call VIC_fnc_getLandSurfacePosition;
        if (_surf isEqualTo []) then { continue; };

        if (_excludeTowns) then {
            private _towns = nearestLocations [ASLToAGL _surf, ["NameCity","NameVillage","NameCityCapital","NameLocal"], _townRadius];
            if !(_towns isEqualTo []) then { continue; };
        };

        _result = ASLToAGL _surf;
        breakOut "findLand";
    };
    _searchRadius = _searchRadius + _radius;
};

if (_result isEqualTo []) then { nil } else { _result }
