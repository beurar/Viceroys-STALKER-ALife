/*
    Handles ambient stalker wanderer groups. Groups are removed when their
    patrol grid cell becomes inactive and respawned when the cell is active.
    STALKER_wanderers entries: [group, position, marker, active]
*/

// ["manageWanderers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_wanderers") exitWith {};

private _groupSize = ["VSA_ambientStalkerSize", 4] call VIC_fnc_getSetting;
private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_grp","_pos","_marker","_active"];

    private _newActive = [_pos,_range,_active] call VIC_fnc_evalSiteProximity;

    if (_newActive) then {
        if (isNull _grp || { count units _grp == 0 }) then {
            _grp = createGroup independent;
            for "_i" from 1 to _groupSize do {
                _grp createUnit ["I_Soldier_F", _pos, [], 0, "FORM"];
            };
            [_grp, _pos] call BIS_fnc_taskPatrol;
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

    STALKER_wanderers set [_forEachIndex, [_grp, _pos, _marker, _newActive]];
} forEach STALKER_wanderers;

true
