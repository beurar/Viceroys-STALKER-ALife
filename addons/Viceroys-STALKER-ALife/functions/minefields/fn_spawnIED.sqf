/*
    Spawns a single IED on a road near the given position.
    Params:
        0: POSITION - position to search
    Returns:
        ARRAY - array containing the spawned IED object
*/
params ["_center"];

["spawnIED"] call VIC_fnc_debugLog;

if (!isServer) exitWith { [] };

private _pos = [_center, 200, 20] call VIC_fnc_findRoadPosition;
if (isNil "_pos") exitWith { [] };
private _ied = createMine ["IEDLandSmall_F", _pos, [], 0];

if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    private _marker = format ["ied_%1", diag_tickTime];
    [_marker, _pos, "ICON", "mil_triangle", "ColorRed", 0.2, "IED"] call VIC_fnc_createGlobalMarker;
};

[_ied];
