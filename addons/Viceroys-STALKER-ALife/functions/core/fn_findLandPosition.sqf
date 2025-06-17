/*
    Casts vertical rays around a point to locate nearby land.
    Params:
        0: ARRAY or OBJECT - center position
        1: NUMBER - search radius (default 50)
        2: NUMBER - maximum attempts (default 10)
        3: BOOL   - exclude towns from results (default false)
        4: NUMBER - maximum search radius (optional)
    Returns:
        ARRAY - ground position or [] if none found
*/
params ["_center", ["_radius",50], ["_attempts",10], ["_excludeTowns", false], ["_maxRadius", -1]];

// fail fast on invalid input
if (_center isEqualTo [] && { !(_center isEqualType objNull) }) exitWith { [] };

private _base = if (_center isEqualType objNull) then { getPos _center } else { _center };
if !(_base isEqualType []) exitWith { [] };

// debug marker setup
private _debug = ["VSA_debugMode", false] call VIC_fnc_getSetting;
if (_debug && {isServer}) then {
    if (isNil "STALKER_findLandMarkers") then { STALKER_findLandMarkers = [] };
    { if (_x != "") then { deleteMarker _x } } forEach STALKER_findLandMarkers;
    STALKER_findLandMarkers = [];
};

private _townHysteresis = ["VSA_townHysteresis", 200] call VIC_fnc_getSetting;
private _townRadius = ["VSA_townRadius", 500] call VIC_fnc_getSetting;
private _worldSize = worldSize;

// ensure we have a 3D position and sane defaults
_base params [["_bx",0],["_by",0],["_bz",0]];
_base = [_bx,_by,_bz];

// ensure radius is always positive so the search covers an area
_radius = _radius max 1;
if (_maxRadius < 0) then {
    _maxRadius = if (_radius < 200) then { _radius * 1.5 } else { _radius };
};

private _step = _radius max 1;
private _searchRadius = 0;

while {_searchRadius <= _maxRadius} do {
    for "_i" from 0 to _attempts do {
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

        if (_debug && {isServer}) then {
            private _towns = nearestLocations [_candidate, ["NameCity","NameVillage","NameCityCapital","NameLocal"], _townRadius + _townHysteresis];
            private _dist = if (_towns isEqualTo []) then { 1e9 } else { _candidate distance (locationPosition (_towns select 0)) };
            private _color = "ColorRed";
            if (_dist <= _townRadius) then {
                _color = "ColorBlue";
            } else {
                if (_dist <= (_townRadius + _townHysteresis)) then { _color = "ColorOrange"; };
            };
            private _name = format ["land_%1", diag_tickTime + random 1000];
            private _marker = [_name, _candidate, "ICON", "mil_dot", _color, 0.2] call VIC_fnc_createGlobalMarker;
            STALKER_findLandMarkers pushBack _marker;
        };

        private _from = AGLToASL (_candidate vectorAdd [0,0,1000]);
        private _to   = AGLToASL (_candidate vectorAdd [0,0,-1000]);
        private _hit  = lineIntersectsSurfaces [_from, _to, objNull, objNull, true, 1, "GEOM", "NONE"];
        if (!(_hit isEqualTo [])) then {
            private _surf = (_hit select 0) select 0;
            if (!((ASLToAGL _surf) call VIC_fnc_isWaterPosition)) then {
                if (!_excludeTowns || {(nearestLocations [ASLToAGL _surf,["NameCity","NameVillage","NameCityCapital","NameLocal"],_townRadius]) isEqualTo []}) exitWith {
                    if (_debug && {isServer}) then {
                        private _name = format ["land_result_%1", diag_tickTime + random 1000];
                        private _marker = [_name, ASLToAGL _surf, "ICON", "mil_box", "ColorGreen", 1, "Land"] call VIC_fnc_createGlobalMarker;
                        STALKER_findLandMarkers pushBack _marker;
                    };
                    ASLToAGL _surf
                };
            };
        };
    };
    _searchRadius = _searchRadius + _step;
};

[format ["findLandPosition: failed search around %1 up to %2m", _base, _maxRadius]] call VIC_fnc_debugLog;
[]
