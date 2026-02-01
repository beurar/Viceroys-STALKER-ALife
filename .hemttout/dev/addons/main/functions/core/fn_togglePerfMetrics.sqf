/*
    Toggle a client-side thread which periodically requests server metrics
    and prints them to chat.
    Params: none
*/
if (!hasInterface) exitWith { false };

private _active = missionNamespace getVariable ["VIC_perfActive", false];
if (_active) then {
    // stop
    private _id = missionNamespace getVariable ["VIC_perfThread", nil];
    if (!isNil _id) then { deleteVehicle _id };
    missionNamespace setVariable ["VIC_perfActive", false];
    hintSilent "Performance metrics disabled";
} else {
    // start
    private _t = [] spawn {
        while { missionNamespace getVariable ["VIC_perfActive", true] } do {
            private _res = [ { [] call VIC_fnc_getServerMetrics }, [] ] call VIC_fnc_callServer;
            private _tick = _res select 0;
            private _counts = _res select 1;
            // display in chat
            private _msg = format ["[VIC PERF] tick: %1 - %2", _tick, _counts];
            systemChat _msg;
            sleep 5;
        };
    };
    missionNamespace setVariable ["VIC_perfThread", _t];
    missionNamespace setVariable ["VIC_perfActive", true];
    hintSilent "Performance metrics enabled";
};

true
