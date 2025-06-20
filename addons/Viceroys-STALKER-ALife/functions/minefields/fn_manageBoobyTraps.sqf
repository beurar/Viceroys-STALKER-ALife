/*
    Activates or deactivates booby traps based on player proximity.
    STALKER_boobyTraps entries: [position, objects, marker]
*/
["manageBoobyTraps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_boobyTraps") exitWith {};

private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;

{
    _x params ["_pos","_objs","_marker"];
    private _near = [_pos,_dist] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (_objs isEqualTo []) then {
            private _type = selectRandom ["APERSTripMine_Wire","IEDUrbanSmall_F"];
            private _mine = createMine [_type, _pos, [], 0];
            _objs = [_mine];
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if ((count _objs) > 0) then {
            { if (!isNull _x) then { deleteVehicle _x; } } forEach _objs;
            _objs = [];
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_boobyTraps set [_forEachIndex, [_pos,_objs,_marker]];
} forEach STALKER_boobyTraps;

true
