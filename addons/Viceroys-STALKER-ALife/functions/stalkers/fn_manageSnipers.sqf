/*
    Handles spawned sniper units. Snipers are removed when their
    grid cell becomes inactive and respawned when players return.
    STALKER_snipers entries: [group, position, marker]
*/

["manageSnipers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_snipers") exitWith {};

private _cellSize = missionNamespace getVariable ["STALKER_activityGridSize", 500];

{
    _x params ["_grp","_pos","_marker"];

    private _gx = floor ((_pos select 0) / _cellSize);
    private _gy = floor ((_pos select 1) / _cellSize);
    private _key = format ["%1_%2", _gx, _gy];
    private _active = false;
    if (!isNil "STALKER_activityGrid") then {
        {
            _x params ["_cell","_state"];
            if (_cell == _key) exitWith { _active = _state; };
        } forEach STALKER_activityGrid;
    };

    if (_active) then {
        if (isNull _grp || { count units _grp == 0 }) then {
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

    STALKER_snipers set [_forEachIndex, [_grp, _pos, _marker]];
} forEach STALKER_snipers;

true
