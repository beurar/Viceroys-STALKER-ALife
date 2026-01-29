/*
    Spawns a single sniper at one of the nearest cached sniper spots.
    The unit garrisons that position using lambs_wp_fnc_taskGarrison.

    Params:
        0: POSITION - center position to search from (default: position of the caller)
*/

params [["_center", [0,0,0]]];

["spawnSniper"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_snipers") then { STALKER_snipers = [] };

if (isNil "STALKER_sniperSpots" || {STALKER_sniperSpots isEqualTo []}) exitWith {
    ["spawnSniper: no cached sniper spots"] call VIC_fnc_debugLog;
};

private _sorted = STALKER_sniperSpots apply { [_center distance2D _x, _x] };
_sorted sort true;
private _candidates = [];
{
    _candidates pushBack (_x select 1);
    if (count _candidates >= 5) exitWith {};
} forEach _sorted;

private _spot = selectRandom _candidates;
if (isNil {_spot}) exitWith {
    ["spawnSniper: unable to select position"] call VIC_fnc_debugLog;
};

private _spotAGL = ASLToAGL _spot;

private _grp = createGroup east;
_grp createUnit ["O_sniper_F", _spotAGL, [], 0, "FORM"];
// Increase search radius and prioritize high vantage points
[_grp, _spotAGL, 100, [], true, true, 0, true] call lambs_wp_fnc_taskGarrison;
[_spotAGL, 6, 0, 4] call VIC_fnc_spawnTripwirePerimeter;

private _anchor = [_spotAGL] call VIC_fnc_createProximityAnchor;

private _marker = "";
if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    _marker = format ["snp_%1", diag_tickTime];
    [_marker, _spotAGL, "ICON", "mil_ambush", "#(1,0,0,1)", 0.6, "Sniper"] call VIC_fnc_createGlobalMarker;
};

STALKER_snipers pushBack [_grp, _spotAGL, _anchor, _marker, true];

