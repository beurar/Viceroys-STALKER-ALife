/*
    Despawns sniper units when their location's grid cell is inactive and
    respawns them when players return to the area.
    STALKER_snipers entries: [group, position, marker]
*/

["manageSnipers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_snipers") exitWith {};

private _gridSize = missionNamespace getVariable ["STALKER_activityGridSize", 500];

{
    _x params ["_grp","_pos","_marker"];
    private _gx = floor ((_pos select 0) / _gridSize);
    private _gy = floor ((_pos select 1) / _gridSize);
    private _key = format ["%1_%2", _gx, _gy];
    private _active = false;
    if (!isNil "STALKER_activityGrid") then {
        {
            if ((_x select 0) == _key) exitWith { _active = (_x select 1); };
        } forEach STALKER_activityGrid;
    } else {
        private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
        _active = [_pos, _range] call VIC_fnc_hasPlayersNearby;
    };

    if (!_active) then {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
        if (_marker != "") then { [_marker, 0.2] remoteExec ["setMarkerAlpha", 0]; };
    } else {
        if (isNull _grp || { count units _grp == 0 }) then {
            private _new = createGroup east;
            _new createUnit ["O_sniper_F", _pos, [], 0, "FORM"];
            [_new, _pos, 100, [], true, true, 0, true] call lambs_wp_fnc_taskGarrison;
            [_pos, 25, 6] call VIC_fnc_spawnTripwirePerimeter;
            if (_marker == "" && { ["VSA_debugMode", false] call VIC_fnc_getSetting }) then {
                _marker = format ["snp_%1", diag_tickTime];
                [_marker, _pos, "ICON", "mil_triangle", "ColorRed", 0.6, "Sniper"] call VIC_fnc_createGlobalMarker;
            };
            _grp = _new;
        };
        if (_marker != "") then { [_marker, 1] remoteExec ["setMarkerAlpha", 0]; };
    };

    STALKER_snipers set [_forEachIndex, [_grp, _pos, _marker]];
} forEach STALKER_snipers;

true
