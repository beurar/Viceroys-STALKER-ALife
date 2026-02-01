/*
    Starts the stalker camp management loop. Debug use only.
    Periodically manages STALKER_camps, removing excess camps
    and spawning new ones if below the configured minimum.
*/
["startCampManager"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (missionNamespace getVariable ["VIC_campManagerRunning", false]) exitWith {};
missionNamespace setVariable ["VIC_campManagerRunning", true];

[] spawn {
    missionNamespace setVariable ["VIC_lastCampSpawnAttempt", 0];
    while { missionNamespace getVariable ["VIC_campManagerRunning", false] } do {
        // Update existing camps based on player proximity
        [] call VIC_fnc_manageStalkerCamps;

        if (isNil "STALKER_camps") then { STALKER_camps = []; };
        private _min = ["VSA_minStalkerCamps", 1] call VIC_fnc_getSetting;
        private _max = ["VSA_maxStalkerCamps", 5] call VIC_fnc_getSetting;

        private _count = count STALKER_camps;

        if (_count > _max) then {
            for "_i" from 1 to (_count - _max) do {
                if (STALKER_camps isEqualTo []) exitWith {};
                private _idx = floor random (count STALKER_camps);
                private _camp = STALKER_camps select _idx;
                _camp params ["_fire","_grp","_pos","_anchor","_marker"];
                if (!isNull _grp) then { { deleteVehicle _x } forEach units _grp; deleteGroup _grp; };
                if (!isNull _fire) then { deleteVehicle _fire; };
                if (_marker != "") then { deleteMarker _marker; };
                STALKER_camps deleteAt _idx;
            };
        };

        private _last = missionNamespace getVariable ["VIC_lastCampSpawnAttempt", 0];
        if (diag_tickTime - _last > 120) then {
            if ((count STALKER_camps) < _min) then {
                private _needed = _min - (count STALKER_camps);
                for "_i" from 1 to _needed do {
                    private _building = [] call VIC_fnc_findCampBuilding;
                    if (isNull _building) exitWith {};
                    private _pos = getPosATL _building;
                    [_pos] call VIC_fnc_spawnStalkerCamp;
                };
            };
            missionNamespace setVariable ["VIC_lastCampSpawnAttempt", diag_tickTime];
        };

        sleep 6;
    };
};

true
