/*
    Manages abandoned vehicles. Vehicles are deleted when their grid cell
    becomes inactive and their markers cleaned up. If a vehicle has moved more
    than 200m from its original site the entry is removed but the vehicle is
    left intact so players can keep using it.
    STALKER_wrecks entries: vehicle objects with a `VIC_wreckSite` variable
    storing the spawn position. Debug markers are optional and tracked in
    STALKER_wreckMarkers using the same index.
*/

// ["manageWrecks"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_wrecks") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];

for [{_i = (count STALKER_wrecks) - 1}, {_i >= 0}, {_i = _i - 1}] do {
    private _veh = STALKER_wrecks select _i;
    if (isNull _veh) then {
        if (!isNil "STALKER_wreckMarkers") then {
            private _m = STALKER_wreckMarkers param [_i, ""];
            if (_m != "") then { deleteMarker _m; };
            STALKER_wreckMarkers deleteAt _i;
        };
        STALKER_wrecks deleteAt _i;
        continue;
    };

    private _site = _veh getVariable ["VIC_wreckSite", getPosATL _veh];
    _veh setVariable ["VIC_wreckSite", _site];
    private _anchor = _veh getVariable ["VIC_anchor", objNull];
    if (isNull _anchor) then {
        _anchor = [_site] call VIC_fnc_createProximityAnchor;
        _veh setVariable ["VIC_anchor", _anchor];
    };

    if (_veh distance2D _site > 200) then {
        if (!isNil "STALKER_wreckMarkers") then {
            private _m = STALKER_wreckMarkers param [_i, ""];
            if (_m != "") then { deleteMarker _m; };
            STALKER_wreckMarkers deleteAt _i;
        };
        STALKER_wrecks deleteAt _i;
        continue;
    };

    private _near = [_anchor, _dist] call VIC_fnc_hasPlayersNearby;
    if (!_near) then {
        deleteVehicle _veh;
        if (!isNil "STALKER_wreckMarkers") then {
            private _m = STALKER_wreckMarkers param [_i, ""];
            if (_m != "") then { deleteMarker _m; };
            STALKER_wreckMarkers deleteAt _i;
        };
        STALKER_wrecks deleteAt _i;
    };
};

true
