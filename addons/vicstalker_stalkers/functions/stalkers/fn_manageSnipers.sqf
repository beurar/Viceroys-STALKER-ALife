/*
    Handles spawned sniper units. Snipers are removed when their
    spawns when players are nearby and despawns when they leave.
    STALKER_snipers entries: [group, position, anchor, marker, active]
*/

// ["manageSnipers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_snipers") exitWith {};

private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_grp","_pos","_anchor","_marker","_active"];

    private _newActive = [_anchor,_range,_active] call VIC_fnc_evalSiteProximity;

    if (_newActive) then {
        if (isNull _grp || { units _grp isEqualTo [] }) then {
            _grp = createGroup east;
            _grp createUnit ["O_sniper_F", _pos, [], 0, "FORM"];
            [_grp, _pos, 100, [], true, true, 0, true] call lambs_wp_fnc_taskGarrison;
            [_pos, 6, 0, 4] call VIC_fnc_spawnTripwirePerimeter;
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };

    STALKER_snipers set [_forEachIndex, [_grp, _pos, _anchor, _marker, _newActive]];
} forEach STALKER_snipers;

true
