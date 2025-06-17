/*
    Generates anomaly fields across the map using the same logic as mutant habitats.
    This runs on the server during initialization.
*/

["setupAnomalyFields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_anomalyFields") then { STALKER_anomalyFields = []; };
if (isNil "STALKER_anomalyMarkers") then { STALKER_anomalyMarkers = []; };

private _createField = {
    params ["_fn", "_pos"];

    // Skip this location if it overlaps an existing field
    private _overlap = false;
    {
        if (_pos distance2D (_x#6) < 300) exitWith { _overlap = true };
    } forEach STALKER_anomalyFields;
    if (_overlap) exitWith { false };

    private _spawned = [_pos, 75] call _fn;
    if (_spawned isEqualTo []) exitWith { false };

    private _marker = (_spawned select 0) getVariable ["zoneMarker", ""];
    if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    private _dur = missionNamespace getVariable ["STALKER_AnomalyFieldDuration", 30];
    private _exp = diag_tickTime + (_dur * 60);

    STALKER_anomalyFields pushBack [_pos,75,_fn,count _spawned,_spawned,_marker,_pos,_exp,true];
    true
};

private _types = [
    VIC_fnc_createField_burner,
    VIC_fnc_createField_clicker,
    VIC_fnc_createField_electra,
    VIC_fnc_createField_fruitpunch,
    VIC_fnc_createField_gravi,
    VIC_fnc_createField_meatgrinder,
    VIC_fnc_createField_springboard,
    VIC_fnc_createField_whirligig,
    VIC_fnc_createField_comet,
    VIC_fnc_createField_launchpad,
    VIC_fnc_createField_leech,
    VIC_fnc_createField_trapdoor,
    VIC_fnc_createField_zapper,
    VIC_fnc_createField_bridgeElectra
];

private _center = [worldSize/2, worldSize/2, 0];
private _locations = nearestLocations [_center, [], worldSize];
private _buildings = nearestObjects [_center, ["House"], worldSize];
_buildings append (allMissionObjects "building");
_buildings = _buildings arrayIntersect _buildings; // remove duplicates

{
    private _pos = locationPosition _x;
    _pos = [_pos, 0, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (random 1 > 0.5) then {
        if (!(_pos call VIC_fnc_isWaterPosition)) then {
            private _fn = selectRandom _types;
            [_fn, _pos] call _createField;
        };
    };
} forEach _locations;

for "_i" from 1 to 20 do {
    if (_buildings isEqualTo []) exitWith {};
    private _b = selectRandom _buildings;
    private _pos = getPosATL _b;
    _pos = [_pos, 0, 25, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = selectRandom _types;
        [_fn, _pos] call _createField;
    };
};

private _forestSites = selectBestPlaces [_center, worldSize, "forest", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = selectRandom _types;
        [_fn, _pos] call _createField;
    };
} forEach (_forestSites select [0,10]);

private _swampSites = selectBestPlaces [_center, worldSize, "meadow", 1, 50];
{
    private _pos = (_x select 0);
    _pos = [_pos, 0, 75, 5, 0, 0, 0] call BIS_fnc_findSafePos;
    if (!(_pos call VIC_fnc_isWaterPosition)) then {
        private _fn = selectRandom _types;
        [_fn, _pos] call _createField;
    };
} forEach (_swampSites select [0,10]);

true
