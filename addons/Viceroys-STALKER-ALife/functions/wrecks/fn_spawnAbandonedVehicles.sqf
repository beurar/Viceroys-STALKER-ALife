/*
    Spawns damaged vehicles at random road locations.
    Params:
        0: NUMBER - number of vehicles to spawn (default 10)
*/
params [["_count", 10]];

["spawnAbandonedVehicles"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (["VSA_enableWrecks", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_wrecks") then { STALKER_wrecks = []; };

private _classes = [
    "C_Offroad_01_F",
    "C_Hatchback_01_F",
    "C_SUV_01_F",
    "C_Van_01_transport_F"
];

for "_i" from 1 to _count do {
    private _base = [random worldSize, random worldSize, 0];
    private _road = roadAt _base;
    if (isNull _road) then {
        _road = nearestRoad _base;
    };

    if (!isNull _road) then {
        private _pos = getPos _road;
        _pos = _pos getPos [2 + random 3, random 360];
        _pos = [_pos] call VIC_fnc_getLandSurfacePosition;
        if !(_pos isEqualTo []) then {
            private _veh = createVehicle [selectRandom _classes, ASLtoATL _pos, [], 0, "CAN_COLLIDE"];
            _veh setPosATL (ASLtoATL _pos);
            _veh setVectorUp surfaceNormal (ASLtoATL _pos);
            _veh setDamage (0.3 + random 0.7);
            _veh setFuel 0;
            _veh lock 2;
            STALKER_wrecks pushBack _veh;
        };
    };
};
