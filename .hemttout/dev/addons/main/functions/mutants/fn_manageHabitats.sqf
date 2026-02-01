/*
    Manages mutant habitats. Spawns units when players approach and
    replenishes cleared habitats over time.

    STALKER_mutantHabitats entries: [areaMarker, labelMarker, group, position, anchor, type, max, count, near]
*/

// ["manageHabitats"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_mutantHabitats") exitWith {};

private _getClass = {
    params ["_type"];
    switch (_type) do {
        case "Bloodsucker": { selectRandom ["armst_krovosos","armst_krovosos2"] };
        case "Boar": { selectRandom ["armst_boar","armst_boar2"] };
        case "Cat": { "armst_cat" };
        case "Flesh": { selectRandom ["armst_PLOT","armst_PLOT2"] };
        case "Blind Dog": { selectRandom ["armst_blinddog1","armst_blinddog2","armst_blinddog3"] };
        case "Pseudodog": { selectRandom ["armst_pseudodog","armst_pseudodog2"] };
        case "Snork": { "armst_snork" };
        case "Controller": { selectRandom ["armst_controller_new","armst_controller_new2","armst_controller_new3"] };
        case "Pseudogiant": { selectRandom ["armst_giant","armst_giant2"] };
        case "Izlom": { "armst_izlom" };
        case "Corruptor": { "WBK_SpecialZombie_Corrupted_3" };
        case "Smasher": { "WBK_SpecialZombie_Smasher_3" };
        case "Acid Smasher": { "WBK_SpecialZombie_Smasher_Acid_3" };
        case "Behemoth": { "WBK_Goliaph_3" };
        case "Parasite": { "dev_parasite_i" };
        case "Jumper": { "def_asymhuman_stage2_i" };
        case "Spitter": { "dev_toxmut_i" };
        case "Stalker": { "dev_form939_i" };
        case "Bully": { "dev_asymhuman_i" };
        case "Hivemind": { "dev_hivemind_i" };
        case "Zombie": { selectRandom ["WBK_Zombie1","WBK_Zombie2","WBK_Zombie3"] };
        default { "O_ALF_Mutant" };
    };
};


{

    _x params ["_area","_label","_grp","_pos","_anchor","_type","_max","_count","_near"];

    if !( [_type] call VIC_fnc_isMutantEnabled ) then {
        _max = 0; _count = 0;
    };

    if (_near) then {
        if (isNull _grp && {_count > 0}) then {
            private _class = [_type] call _getClass;
            _grp = createGroup east;
            for "_i" from 1 to _count do {
                private _u = _grp createUnit [_class, _pos, [], 0, "FORM"];
                [_u] call VIC_fnc_initMutantUnit;
                _u setVariable ["VSA_habitatIndex", _forEachIndex];
                _u addEventHandler ["Killed", { [_this#0] call VIC_fnc_onMutantKilled }];
            };
            [_grp,_pos] call BIS_fnc_taskDefend;
        };

        private _alive = if (isNull _grp) then {0} else { {alive _x} count units _grp };
        _count = _alive;

        if (_alive == 0 && {!isNull _grp}) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
    } else {
        if (!isNull _grp) then {
            _count = { alive _x } count units _grp;
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };

        if (_count < _max) then {
            _count = _count + 1;
            if (_count > _max) then { _count = _max; };
        };
    };

    _area setMarkerColorLocal ([VIC_colorMutant, VIC_colorMeatRed] select (_count > 0));
    _label setMarkerColorLocal ([VIC_colorMutant, VIC_colorMeatRed] select (_count > 0));
    _label setMarkerTextLocal format ["%1 Habitat: %2/%3", _type, _count, _max];

    private _alpha = [0.2, 1] select _near;
    _area setMarkerAlpha _alpha;
    _label setMarkerAlpha _alpha;

    STALKER_mutantHabitats set [_forEachIndex, [_area,_label,_grp,_pos,_anchor,_type,_max,_count,_near]];
} forEach STALKER_mutantHabitats;

