/*
    Author: STALKER ALife Script
    Description:
        Finds potential positions for Drongo's spook zones near buildings such as
        graveyards, churches and ruins.

    Returns:
        ARRAY - list of positions suitable for spook zones.
*/

["setupSpookZones"] call VIC_fnc_debugLog;

private _candidates = [];

{
    private _type = toLower (typeOf _x);
    if (
        {_type find _x > -1} count ["church","chapel","grave","cemetery","ruin"] > 0
    ) then {
        _candidates pushBack (getPosATL _x);
    };
} forEach (allMissionObjects "building");

drg_spook_zone_positions = _candidates;
_candidates
