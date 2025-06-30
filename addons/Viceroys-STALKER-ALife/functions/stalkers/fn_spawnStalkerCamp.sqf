/*
    Spawns a single stalker camp at the given position.
    A random faction is selected with a valid side according to the
    configuration below.
    Params:
        0: POSITION - camp position
*/
params ["_pos"];

["spawnStalkerCamp"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (isNil "STALKER_camps") then { STALKER_camps = []; };

private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

// Available factions and their unit classes
// Each entry: [FactionName, [allowed sides], [unit classes]]
private _factionInfo = [
    ["ClearSky",   [blufor,opfor,independent,civilian], [
        "B_CS_Artifact_Seeker_01","B_CS_Exo_01","B_CS_Experienced_01",
        "B_CS_Guardian_01","B_CS_Journeyman_01","B_CS_Nomad_01",
        "B_CS_Pathfinder_01","B_CS_Rookie_01","B_CS_Tracker_01"
    ]],
    ["Mercenaries", [blufor,opfor,independent], [
        "B_Merc_Contractor_01","B_Merc_Exo_Merc_01","B_Merc_Merc_Assassin_01",
        "B_Merc_Merc_Scout_01","B_Merc_Merc_Seva_01","B_Merc_Old_Hand_01",
        "B_Merc_Trained_Merc_01"
    ]],
    ["Freedom",    [blufor,opfor,independent,civilian], [
        "B_FD_Anomaly_Splunker_01","B_FD_Defender_01","B_FD_Exo_01",
        "B_FD_Guardian_01","B_FD_Seedy_01","B_FD_Seedy_Sniper_01",
        "B_FD_Wardog_01"
    ]],
    ["Bandits",    [blufor,opfor,independent,civilian], [
        "O_Bdz_Assaulter_01","O_Bdz_Conman_01","O_Bdz_Criminal_01",
        "O_Bdz_Exo_01","O_Bdz_Raider_01","O_Bdz_Robber_01",
        "O_Bdz_Thug_01","O_Bdz_Waster_01"
    ]],
    ["Duty",       [blufor,opfor], [
        "O_ODty_Artifact_Specialist_01","O_ODty_Duty_Hunter_01","O_ODty_Duty_Patrolman_01",
        "O_ODty_Duty_Officer_01","O_ODty_Duty_Private_01","O_ODty_Duty_Sniper_01",
        "O_ODty_Duty_Specialist_01","O_ODty_Duty_Trooper_01"
    ]],
    ["Monolith",   [opfor], [
        "O_mn_Monolith_Cultist_01","O_mn_Monolith_Disciple_01","O_mn_Monolith_Exo_01",
        "O_mn_Monolith_Fanatic_01","O_mn_Monolith_Preacher_01",
        "O_mn_Monolith_Predecessor_01","O_mn_Monolith_Scientist_01"
    ]],
    ["Military",   [blufor], [
        "I_UA_Military_autorifleman_01","I_UA_Military_Officer_01","I_UA_Military_Private_01",
        "I_UA_Military_Sergeant_01","I_UA_Military_Stalker_01"
    ]],
    ["Spetznaz",   [blufor], [
        "I_UA_Spetznaz_Officer_01","I_UA_Spetznaz_Operator_01",
        "I_UA_Spetznaz_Sergeant_01","I_UA_Spetznaz_Sniper_01"
    ]],
    ["Ecologists", [blufor,opfor,independent,civilian], [
        "I_Eco_Eco_Guard_01","I_Eco_Eco_Stalker_01","I_Eco_Field_Ecologist_01",
        "I_Eco_Lab_Scientist_01","I_Eco_Protector_01"
    ]],
    ["Loners",     [independent], [
        "I_LNR_Artifact_Huner_01","I_LNR_Explorer_01","I_LNR_Loner_01",
        "I_LNR_Loner_Rookie_01","I_LNR_Mutant_Hunter_01",
        "I_LNR_Tourist_01","I_LNR_Veteran_01"
    ]]
];

private _entry = selectRandom _factionInfo;
private _side    = selectRandom (_entry select 1);
private _faction = _entry select 0;
private _class   = selectRandom (_entry select 2);

private _grp = createGroup _side;
for "_i" from 1 to _size do {
    _grp createUnit [_class, _pos, [], 0, "FORM"];
};

// Move the campfire slightly away from the building so it sits
// outside rather than at the building centre
private _firePos = _pos getPos [3 + random 3, random 360];
private _campfire = "Campfire_burning_F" createVehicle _firePos;

// Random loot crate near the camp
private _cratePos = _pos getPos [2, random 360];
private _crate = "Box_NATO_Equip_F" createVehicle _cratePos;
private _weapons = ["arifle_AK12_F","arifle_MX_F","SMG_02_F"];
private _items   = ["FirstAidKit","NVGoggles_INDEP","binocular"];
_crate addItemCargoGlobal [selectRandom _items, 1];
_crate addWeaponCargoGlobal [selectRandom _weapons,1];

// Tripflare perimeter around camp
[_pos, 12, 8] call VIC_fnc_spawnFlareTripwires;

// Some units relax by the fire
private _sitCount = (count units _grp) min 2;
for "_i" from 0 to (_sitCount - 1) do {
    private _unit = (units _grp) select _i;
    private _p = _campfire getPos [1.5 + random 0.5, random 360];
    _unit setPos _p;
    _unit disableAI "PATH";
    _unit playMove "Acts_SittingWounded_loop";
};
if (local _grp) then {
    if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
        [_grp, _pos, 150, [], true, true] call lambs_wp_fnc_taskCamp;
    } else {
        [_grp, _pos] call BIS_fnc_taskDefend;
    };
} else {
    if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
        [_grp, _pos, 150, [], true, true] remoteExecCall ["lambs_wp_fnc_taskCamp", groupOwner _grp];
    } else {
        [_grp, _pos] remoteExecCall ["BIS_fnc_taskDefend", groupOwner _grp];
    };
};

private _marker = "";
if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
    _marker = format ["camp_%1", diag_tickTime];
    private _color = switch (_faction) do {
        case "Bandits": {"ColorOrange"};
        case "ClearSky": {"ColorBlue"};
        case "Ecologists": {"ColorKhaki"};
        case "Military": {"ColorGreen"};
        case "Duty": {"ColorRed"};
        case "Freedom": {"ColorBlue"};
        case "Loners": {"ColorWhite"};
        case "Mercs": {"ColorPink"};
        default {"ColorWhite"};
    };
    [_marker, _pos, "ICON", "mil_box", _color, 0.2, _faction] call VIC_fnc_createGlobalMarker;
};

STALKER_camps pushBack [_campfire, _grp, _pos, _marker, _side, _faction, false];
