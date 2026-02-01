/*
    Activates or deactivates IED sites and handles cleanup.
    STALKER_iedSites entries: [position, object, marker, active]
*/
// ["manageIEDSites"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_iedSites") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_pos","_obj","_marker",["_active",false]];
    private _newActive = [_pos,_dist,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (isNull _obj) then {
            _obj = createMine [selectRandom ["IEDUrbanBig_F", "IEDLandBig_F", "IEDUrbanSmall_F", "IEDLandSmall_F"], _pos, [], 0];
            _obj setVariable ["VIC_iedIndex", _forEachIndex];
            _obj addEventHandler ["Deleted", {
                params ["_mine"];
                private _idx = _mine getVariable ["VIC_iedIndex", -1];
                if (_idx > -1 && {!isNil "STALKER_iedSites"}) then { STALKER_iedSites deleteAt _idx; };
            }];
            _obj addEventHandler ["Explosion", {
                params ["_mine"];
                private _idx = _mine getVariable ["VIC_iedIndex", -1];
                if (_idx > -1 && {!isNil "STALKER_iedSites"}) then { STALKER_iedSites deleteAt _idx; };
            }];
            [_obj] spawn {
                params ["_mine"];
                while {alive _mine} do {
                    private _near = allPlayers select { _x distance _mine < 10 };
                    if (_near isNotEqualTo [] && { !(_mine getVariable ["VIC_detonating",false]) }) then {
                        _mine setVariable ["VIC_detonating", true];
                        _mine say3D ["AlarmCar",50];
                        sleep 5;
                        if (alive _mine) then { _mine setDamage 1; };
                    };
                    sleep 0.5;
                };
            };
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (!isNull _obj) then { deleteVehicle _obj; _obj = objNull; };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };
    STALKER_iedSites set [_forEachIndex, [_pos,_obj,_marker,_newActive]];
} forEach STALKER_iedSites;

// Maintain site count
private _target = ["VSA_IEDSiteCount",10] call VIC_fnc_getSetting;
while { count STALKER_iedSites < _target } do {
    [ [worldSize/2, worldSize/2, 0], worldSize, 1 ] call VIC_fnc_spawnIEDSites;
};

true
