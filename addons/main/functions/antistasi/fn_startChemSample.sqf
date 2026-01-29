/*
    Starts a chemical sample mission that requires staying inside a zone.

    Params:
        0: NUMBER - duration in seconds to remain in the zone (default 90)
        1: NUMBER - reward upon completion (default 100)

    Returns:
        BOOL - true when the mission starts
*/
params [["_duration",90],["_reward",100]];

if !(call VIC_fnc_isAntistasiUltimate) exitWith {false};
if (!isServer) exitWith {false};
if (isNil "STALKER_chemicalZones" || {STALKER_chemicalZones isEqualTo []}) exitWith {false};

private _entry = selectRandom STALKER_chemicalZones;
_entry params ["_pos","_radius","_active","_marker","_exp"];

missionNamespace setVariable ["STALKER_chemSample_active", true];

[_pos,_radius,_duration,_reward] spawn {
    params ["_pos","_rad","_dur","_reward"];
    private _time = 0;
    while {missionNamespace getVariable ["STALKER_chemSample_active",false] && {_time < _dur}} do {
        if ([_pos,_rad] call VIC_fnc_hasPlayersNearby) then { _time = _time + 1; };
        sleep 1;
    };
    if (_time >= _dur) then { [_reward] call VIC_fnc_completeChemSample; };
    missionNamespace setVariable ["STALKER_chemSample_active", false];
};

if (!isNil "A3U_fnc_createTask") then {
    ["VIC_ChemSample","Chemical Sample","Hold inside the chemical zone.",_pos] call A3U_fnc_createTask;
};

true
