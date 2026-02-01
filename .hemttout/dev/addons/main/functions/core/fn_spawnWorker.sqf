if (!isServer) exitWith {};

while {true} do {
    if (!isNil "STALKER_spawnQueue" && {count STALKER_spawnQueue > 0}) then {

        private _job = STALKER_spawnQueue deleteAt 0;
        _job params ["_type", "_positions"];

        {
            createMine [_type, _x, [], 0];
            uiSleep 0.01;
        } forEach _positions;
    };

    uiSleep 0.05;
};
