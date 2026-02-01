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
    "C_Van_01_transport_F",
    "d3s_BRDM_2",
    "d3s_luaz969m",
    "d3s_lusaz969m_2",
    "d3s_uaz_2206",
    "d3s_uaz_2315",
    "d3s_uaz_2315D",
    "d3s_uaz_2746",
    "d3s_uaz_29232",
    "d3s_uaz_3303",
    "d3s_uaz_3741",
    "d3s_uaz_3741_ars",
    "d3s_uaz_432",
    "d3s_zaz968m",
    "d3s_gaz66_AC",
    "d3s_gaz66_KUNG",
    "d3s_gaz66",
    "d3s_gaz66_TENT",
    "d3s_maz_6317_cistern",
    "d3s_maz_6317",
    "d3s_maz_6317_tent",
    "d3s_maz_7429",
    "d3s_maz_7429_cistern",
    "d3s_zil_130_01",
    "d3s_zil_130_02",
    "d3s_zil_130_03",
    "d3s_zil_130",
    "d3s_zil_130_04",
    "d3s_zil_130_05",
    "d3s_zil_130_06",
    "d3s_zil_130_07",
    "d3s_zil_131",
    "d3s_zil_131_4",
    "d3s_zil_131_5",
    "d3s_zil_131_3",
    "d3s_zil_131_2"
];

for "_i" from 1 to _count do {
    private _roadPos = [] call VIC_fnc_getRandomRoad;
    private _pos = _roadPos getPos [2 + random 3, random 360];
    _pos = [_pos] call VIC_fnc_getLandSurfacePosition;
    if !(_pos isEqualTo []) then {
        private _type = selectRandom _classes;
        private _typeName = getText (configFile / "CfgVehicles" / _type / "displayName");
        private _veh = createVehicle [_type, ASLtoATL _pos, [], 0, "CAN_COLLIDE"];
        _veh setPosATL (ASLtoATL _pos);
        _veh setVectorUp surfaceNormal (ASLtoATL _pos);
        _veh setDamage (0.3 + random 0.7);
        _veh setFuel 0;
        _veh lock 2;
        _veh setVariable ["VIC_wreckSite", ASLtoATL _pos];
        private _anchor = [ASLtoATL _pos] call VIC_fnc_createProximityAnchor;
        _veh setVariable ["VIC_anchor", _anchor];
        STALKER_wrecks = STALKER_wrecks + [_veh];
    };
}
