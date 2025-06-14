/*
    Activates or deactivates minefields based on player proximity.
    STALKER_minefields entries: [center, type, size, objects, marker]
*/
["manageMinefields"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_minefields") exitWith {};

private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;

{
    _x params ["_center","_type","_size","_objs","_marker"];
    private _near = [_center,_dist] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (_objs isEqualTo []) then {
            _objs = switch (_type) do {
                case "APERS": { [_center,_size] call VIC_fnc_spawnAPERSField };
                case "IED": { [_center] call VIC_fnc_spawnIED };
            };
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if ((count _objs) > 0) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_minefields set [_forEachIndex, [_center,_type,_size,_objs,_marker]];
} forEach STALKER_minefields;

true

