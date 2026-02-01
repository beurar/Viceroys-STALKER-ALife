/*
    Handles ambush activation and cleanup.
    STALKER_ambushes entries: [position, anchor, vehicle, mines, groups, triggered, marker, active]
*/

// ["manageAmbushes"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_ambushes") exitWith {};

private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];
private _minUnits = ["VSA_ambushMinUnits", 3] call VIC_fnc_getSetting;
private _maxUnits = ["VSA_ambushMaxUnits", 6] call VIC_fnc_getSetting;

{
    _x params ["_pos","_anchor","_veh","_mines","_groups","_triggered","_marker",["_active",false]];
    private _newActive = [_anchor,_range,_active] call VIC_fnc_evalSiteProximity;

    if (_newActive) then {
        if (isNull _veh) then {
            _veh = "C_Van_01_transport_F" createVehicle _pos;
            _veh allowDamage false;
        };

        if (_mines isEqualTo []) then {
            private _roadPos = [_pos, 50, 5] call VIC_fnc_findRoadPosition;
            private _dir = 0;
            if (!isNil {_roadPos} && { !(_roadPos isEqualTo []) }) then {
                private _road = roadAt _roadPos;
                if (isNull _road) then {
                    private _roads = _roadPos nearRoads 50;
                    if (_roads isNotEqualTo []) then { _road = _roads select 0; };
                };
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
            if (!isNil {_roadPos} && { !(_roadPos isEqualTo []) }) then {
            private _road = roadAt _roadPos;
            if (isNull _road) then {
                private _roads = _roadPos nearRoads 50;
                if (_roads isNotEqualTo []) then { _road = _roads select 0; };
            };
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
                {
                    if (!isNull _x) then {
                        private _countAlive = count (units _x select { alive _x });
                        _alive = _alive + _countAlive;
                    };
                } forEach _groups;
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
        {
            private _grp = _x;
            if (!isNull _grp) then {
                { deleteVehicle _x } forEach units _grp;
                deleteGroup _grp;
            };
        } forEach _groups;
        _groups = [];
        _triggered = false;
    };

    if (_marker != "") then { _marker setMarkerAlpha ([0.2, 1] select _newActive); };
    STALKER_ambushes set [_forEachIndex, [_pos,_anchor,_veh,_mines,_groups,_triggered,_marker,_newActive]];
} forEach STALKER_ambushes;

true
