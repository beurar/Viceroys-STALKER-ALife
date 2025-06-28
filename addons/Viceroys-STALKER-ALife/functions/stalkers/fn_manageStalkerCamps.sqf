/*
    Activates or deactivates stalker camps based on player proximity.
    STALKER_camps entries: [campfire, group, position, marker, side, faction, active]
*/

// ["manageStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_camps") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

{
    _x params ["_camp", "_grp", "_pos", "_marker", "_side", "_faction",["_active",false]];
    private _newActive = [_pos,_dist,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (isNull _camp) then { _camp = "Campfire_burning_F" createVehicle _pos; };
        if (isNull _grp || { count units _grp == 0 }) then {
            private _class = switch (_side) do {
                case blufor: { "B_Soldier_F" };
                case opfor: { "O_Soldier_F" };
                default { "I_Soldier_F" };
            };
            private _new = createGroup _side;
            for "_i" from 1 to _size do { _new createUnit [_class, _pos, [], 0, "FORM"]; };
            if (local _new) then {
                if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
                    [_new, _pos, 50] call lambs_wp_fnc_taskCamp;
                } else {
                    [_new, _pos] call BIS_fnc_taskDefend;
                };
            } else {
                if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
                    [_new, _pos, 50] remoteExecCall ["lambs_wp_fnc_taskCamp", groupOwner _new];
                } else {
                    [_new, _pos] remoteExecCall ["BIS_fnc_taskDefend", groupOwner _new];
                };
            };
            _grp = _new;
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
        if (!isNull _camp) then { deleteVehicle _camp; _camp = objNull; };
    };
    if (_marker != "") then {
        [_marker, (if (_newActive) then {1} else {0.2})] remoteExec ["setMarkerAlpha", 0];
    };
    STALKER_camps set [_forEachIndex, [_camp, _grp, _pos, _marker, _side, _faction, _newActive]];
} forEach STALKER_camps;

true
