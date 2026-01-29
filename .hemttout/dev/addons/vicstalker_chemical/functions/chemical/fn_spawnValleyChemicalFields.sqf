/*
    Spawns valley chemical zone clusters across the entire map.
    Each grid cell rolls a chance to spawn a cluster anchored to the
    lowest nearby point and the valley area is marked when debugging.

    Params:
        0: NUMBER - grid step in meters (default 1000)
        1: NUMBER - spawn chance per cell (0-100, default 25)
        2: NUMBER - duration in seconds (optional, -1 = default)
        3: NUMBER - zones per cluster (optional, default 3)
*/
params [["_step",1000],["_chance",25],["_duration",-1],["_clusterSize",3]];

["spawnValleyChemicalFields"] call VIC_fnc_debugLog;

if (["VSA_enableChemicalZones", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["spawnValleyChemicalFields: disabled"] call VIC_fnc_debugLog;
};

if (isNil "STALKER_chemicalZones") then { STALKER_chemicalZones = []; };

private _nightOnly  = ["VSA_chemicalNightOnly", false] call VIC_fnc_getSetting;
private _zoneRadius = ["VSA_chemicalZoneRadius", 50] call VIC_fnc_getSetting;

if (_nightOnly && {dayTime > 5 && dayTime < 20}) exitWith {
    ["spawnValleyChemicalFields: night only"] call VIC_fnc_debugLog;
};

private _half = _step / 2;
private _debug = ["VSA_debugMode", false] call VIC_fnc_getSetting;
if (_debug && {isServer}) then {
    if (isNil "STALKER_valleyFieldMarkers") then { STALKER_valleyFieldMarkers = []; };
    { if (_x != "") then { deleteMarker _x } } forEach STALKER_valleyFieldMarkers;
    STALKER_valleyFieldMarkers = [];
};

for "_gx" from 0 to worldSize step _step do {
    for "_gy" from 0 to worldSize step _step do {
        if (random 100 >= _chance) then { continue; };
        private _base = [_gx + _half, _gy + _half, 0];
        private _anchor = [_base, _half, 10] call VIC_fnc_findValleyPosition;
        if (_anchor isEqualTo []) then { continue; };
        private _valley = [_anchor, 25, 15, (_zoneRadius*4)] call VIC_fnc_expandValley;

        if (_debug && {isServer}) then {
            private _name = format ["valleyField_%1", diag_tickTime + random 1000];
            private _marker = [_name, ASLToAGL _anchor, "ICON", "mil_warning", VIC_colorGasYellow] call VIC_fnc_createGlobalMarker;
            STALKER_valleyFieldMarkers pushBack _marker;
            {
                private _n = format ["valleyPt_%1", diag_tickTime + random 1000];
                private _m = [_n, _x, "ICON", "mil_dot", VIC_colorGasYellow, 0.5, "", [1,1], true] call VIC_fnc_createGlobalMarker;
                STALKER_valleyFieldMarkers pushBack _m;
            } forEach _valley;
        };

        for "_i" from 1 to _clusterSize do {
            private _ang = random 360;
            private _dist = random (_zoneRadius / 2);
            private _pos = [(_anchor select 0) + _dist * sin _ang, (_anchor select 1) + _dist * cos _ang, _anchor select 2];
            _pos = [_pos] call VIC_fnc_findLandPosition;
            if !(isNil {_pos} || {_pos isEqualTo []}) then {
                [_pos, _zoneRadius, _duration] call VIC_fnc_spawnChemicalZone;
            };
        };
    };
};

true
