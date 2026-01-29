/*
    Selects a building based on weighted keyword categories.
    Params:
        0: ARRAY - [ [keywords ARRAY, weight NUMBER, condition CODE (optional)] , ... ]
    Returns:
        OBJECT - chosen building or objNull if none found
*/
params ["_categories"];

private _all = allMissionObjects "building";
private _options = [];
{
    _x params ["_words","_weight",["_cond",{true}]];
    private _subset = _all select {
        private _building = _x;
        private _type = toLower (typeOf _building);
        ({ _type find _x > -1 } count _words > 0) && { [_building] call _cond };
    };
    if (!(_subset isEqualTo [])) then {
        _options pushBack [_subset,_weight];
    };
} forEach _categories;
if (_options isEqualTo []) exitWith { objNull };
private _subset = [_options] call VIC_fnc_weightedPick;
selectRandom _subset
