/*
    Handles ambush activation and cleanup.
    STALKER_ambushes entries: [position, vehicle, mines, groups, triggered, marker]
*/

["manageAmbushes"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_ambushes") exitWith {};

private _range = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
private _minUnits = ["VSA_ambushMinUnits", 3] call VIC_fnc_getSetting;
private _maxUnits = ["VSA_ambushMaxUnits", 6] call VIC_fnc_getSetting;

{
    _x params ["_pos","_veh","_mines","_groups","_triggered","_marker"];
    private _near = [_pos,_range] call VIC_fnc_hasPlayersNearby;

    if (_near) then {
        if (isNull _veh) then {
            _veh = "C_Van_01_transport_F" createVehicle _pos;
            _veh allowDamage false;
        };

        if (_mines isEqualTo []) then {
            private _roadPos = [_pos, 50, 5] call VIC_fnc_findRoadPosition;
            private _dir = 0;
            if (!isNil "_roadPos") then {
                private _road = roadAt _roadPos;
                if (isNull _road) then { _road = nearestRoad _roadPos; };
                if (!isNull _road) then { _dir = getDir _road; };
            };
            for "_i" from -8 to 8 step 3 do {
                private _cPos = _pos getPos [_i, _dir];
                private _left = _cPos getPos [2, _dir + 90];
                private _right = _cPos getPos [2, _dir - 90];
                _mines pushBack (createMine ["APERSMine", _left, [], 0]);
                _mines pushBack (createMine ["APERSMine", _right, [], 0]);
            };
        };

        if (!_triggered && {[_pos,20] call VIC_fnc_hasPlayersNearby}) then {
            private _grp1 = createGroup east;
            private _grp2 = createGroup east;
            private _count = floor(random (_maxUnits - _minUnits + 1)) + _minUnits;
            private _half = ceil(_count / 2);
            private _roadPos = [_pos, 50, 5] call VIC_fnc_findRoadPosition;
            private _dir = 0;
            if (!isNil "_roadPos") then {
                private _road = roadAt _roadPos;
                if (isNull _road) then { _road = nearestRoad _roadPos; };
                if (!isNull _road) then { _dir = getDir _road; };
            };
            for "_i" from 1 to _half do {
                private _p = _pos getPos [10 + random 5, _dir + 90];
                private _u = _grp1 createUnit ["B_Spotter_F", _p, [], 0, "FORM"];
                _u setUnitPos "DOWN";
            };
            for "_i" from 1 to (_count - _half) do {
                private _p = _pos getPos [10 + random 5, _dir - 90];
                private _u = _grp2 createUnit ["B_Spotter_F", _p, [], 0, "FORM"];
                _u setUnitPos "DOWN";
            };
            _groups = [_grp1,_grp2];
            _triggered = true;
        } else {
            if (_triggered) then {
                private _alive = 0;
                { if (!isNull _x) then { _alive = _alive + ({alive _y} count units _x); }; } forEach _groups;
                if (_alive == 0) then {
                    { if (!isNull _x) then { deleteGroup _x; } } forEach _groups;
                    _groups = [];
                    _triggered = false;
                };
            };
        };
    } else {
        if (!isNull _veh) then { deleteVehicle _veh; _veh = objNull; };
        { if (!isNull _x) then { deleteVehicle _x; } } forEach _mines; _mines = [];
        { if (!isNull _x) then { { deleteVehicle _y } forEach units _x; deleteGroup _x; } } forEach _groups; _groups = [];
        _triggered = false;
    };

    if (_marker != "") then { _marker setMarkerAlpha (if (_near) then {1} else {0.2}); };
    STALKER_ambushes set [_forEachIndex, [_pos,_veh,_mines,_groups,_triggered,_marker]];
} forEach STALKER_ambushes;

true
