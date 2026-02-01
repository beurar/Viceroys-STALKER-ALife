/*
    Updates habitat or herd populations when a mutant dies.
*/
["onMutantKilled"] call VIC_fnc_debugLog;

params ["_unit"];

if (!isServer) exitWith {};

// Herd members
private _herdIndex = _unit getVariable ["VSA_herdIndex", -1];
if (_herdIndex > -1 && {!isNil "STALKER_activeHerds"}) then {
    private _entry = STALKER_activeHerds select _herdIndex;
    _entry params ["_leader","_grp","_max","_count","_near","_marker"];
    _count = _count - 1;
    if (_count < 0) then {_count = 0;};
    STALKER_activeHerds set [_herdIndex, [_leader,_grp,_max,_count,_near,_marker]];
};

// Habitat members
private _habIndex = _unit getVariable ["VSA_habitatIndex", -1];
if (_habIndex > -1 && {!isNil "STALKER_mutantHabitats"}) then {
    private _entry = STALKER_mutantHabitats select _habIndex;
    _entry params ["_area","_label","_grp","_pos","_anchor","_type","_max","_count","_near"];
    _count = _count - 1;
    if (_count < 0) then {_count = 0;};
    _area setMarkerColorLocal ([VIC_colorMutant, VIC_colorMeatRed] select (_count > 0));
    _label setMarkerColorLocal ([VIC_colorMutant, VIC_colorMeatRed] select (_count > 0));
    _label setMarkerText format ["%1 Habitat: %2/%3", _type, _count, _max];
    STALKER_mutantHabitats set [_habIndex, [_area,_label,_grp,_pos,_anchor,_type,_max,_count,_near]];
};

if (missionNamespace getVariable ["STALKER_mutantHunt_active", false]) then {
    private _entry = missionNamespace getVariable ["STALKER_mutantHunt", [0,0,0]];
    _entry params ["_kills","_reward","_end"];
    _kills = _kills + 1;
    missionNamespace setVariable ["STALKER_mutantHunt", [_kills,_reward,_end]];
    if (!isNil "A3U_fnc_addMoney") then { [_reward] call A3U_fnc_addMoney; };
};

true
