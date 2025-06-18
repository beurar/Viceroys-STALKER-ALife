/*
    Spawns a single sniper at the nearest detected sniper spot to a position.
    The unit garrisons that position using lambs_wp_fnc_taskGarrison.

    Params:
        0: POSITION - center position to search from (default: position of the caller)
*/

params [["_center", [0,0,0]]];

["spawnSniper"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_snipers") then { STALKER_snipers = [] };

private _spots = [] call VIC_fnc_findSniperSpots;
if (_spots isEqualTo []) exitWith {
    ["spawnSniper: no sniper spots found"] call VIC_fnc_debugLog;
};

private _spot = [_spots, _center] call BIS_fnc_nearestPosition;
if (isNil {_spot}) exitWith {
    ["spawnSniper: unable to select position"] call VIC_fnc_debugLog;
};

private _grp = createGroup east;
_grp createUnit ["O_sniper_F", _spot, [], 0, "FORM"];
// Increase search radius and prioritize high vantage points
[_grp, _spot, 100, [], true, true, 0, true] call lambs_wp_fnc_taskGarrison;
[_spot, 25, 6] call VIC_fnc_spawnTripwirePerimeter;

private _marker = "";
if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    _marker = format ["snp_%1", diag_tickTime];
    [_marker, _spot, "ICON", "mil_triangle", "ColorRed", 0.6, "Sniper"] call VIC_fnc_createGlobalMarker;
};

STALKER_snipers pushBack [_grp, _spot, _marker];

