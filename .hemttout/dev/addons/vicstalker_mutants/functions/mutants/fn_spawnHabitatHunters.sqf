/*
    Spawns mutant hunting parties from the nearest five habitats to the player.
    Params:
        0: OBJECT - player to hunt
*/
params ["_player"];

["spawnHabitatHunters"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_mutantHabitats") exitWith {};

    private _habitats = STALKER_mutantHabitats apply {
        _x params ["_area","_label","_grp","_pos","_anchor","_type","_max","_count","_near"];
        [_player distance2D _pos, _pos, _type]
    };
    _habitats sort true;
    _habitats = _habitats select { ([_x#2] call VIC_fnc_isMutantEnabled) };
    _habitats = _habitats select [0,5];

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
    _x params ["_dist","_pos","_type"];
    private _grp = createGroup east;
    for "_i" from 1 to 3 do {
        private _u = _grp createUnit [ [_type] call _getClass, _pos, [], 0, "FORM" ];
        [_u] call VIC_fnc_initMutantUnit;
    };
    [_grp, _player] call BIS_fnc_taskAttack;
} forEach _habitats;

true
