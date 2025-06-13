/*
    Activates or deactivates stalker camps based on player proximity.
    STALKER_camps entries: [campfire, group, position, marker, side]
*/

["manageStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_camps") exitWith {};

private _dist = ["VSA_playerNearbyRange", 1500] call VIC_fnc_getSetting;
private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

{
    _x params ["_camp", "_grp", "_pos", "_marker", "_side"];
    private _near = [_pos, _dist] call VIC_fnc_hasPlayersNearby;
    if (_near) then {
        if (isNull _camp) then { _camp = "Campfire_burning_F" createVehicle _pos; };
        if (isNull _grp || { count units _grp == 0 }) then {
            private _class = switch (_side) do {
                case blufor: { "B_Soldier_F" };
                case opfor: { "O_Soldier_F" };
                default { "I_Soldier_F" };
            };
            private _new = createGroup _side;
            for "_i" from 1 to _size do { _new createUnit [_class, _pos, [], 0, "FORM"]; };
            [_new, _pos] call BIS_fnc_taskDefend;
            _grp = _new;
        };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
        if (!isNull _camp) then { deleteVehicle _camp; _camp = objNull; };
    };
    if (_marker != "") then { _marker setMarkerAlpha (if (_near) then {1} else {0.2}); };
    STALKER_camps set [_forEachIndex, [_camp, _grp, _pos, _marker, _side]];
} forEach STALKER_camps;

true
