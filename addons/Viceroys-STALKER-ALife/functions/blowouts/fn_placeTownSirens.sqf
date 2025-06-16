/*
    Place siren objects at all towns on the map.
    Params:
        0: STRING - siren class name (default "Land_Siren_F")
*/
params [["_class","Land_Siren_F"]];


["placeTownSirens"] call VIC_fnc_debugLog;

if (!isServer) exitWith {
    ["placeTownSirens exit: not server"] call VIC_fnc_debugLog;
};

if (["VSA_blowoutSirens", true] call VIC_fnc_getSetting isEqualTo false) exitWith {
    ["placeTownSirens exit: disabled"] call VIC_fnc_debugLog;
};

STALKER_blowoutSirens = [];

private _locs = nearestLocations [[worldSize/2,worldSize/2,0],["NameVillage","NameCity","NameCityCapital","NameLocal"],worldSize];
{
    private _pos = locationPosition _x;
    private _obj = _class createVehicle _pos;
    STALKER_blowoutSirens pushBack _obj;
} forEach _locs;

["placeTownSirens completed"] call VIC_fnc_debugLog;
