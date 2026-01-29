/*
    Spawns a single stalker camp at the given position.
    A random faction is selected with a valid side according to the
    configuration below.
    Params:
        0: POSITION - camp position
*/
params ["_pos"];

["spawnStalkerCamp"] call VIC_fnc_debugLog;

if (isNil "STALKER_campCooldowns") then { STALKER_campCooldowns = [] };
// Remove expired cooldown entries (5 minute window)
STALKER_campCooldowns = STALKER_campCooldowns select { diag_tickTime - (_x select 1) < 300 };

private _anchor = [_pos] call VIC_fnc_createProximityAnchor;

if (!isServer) exitWith {};

if (isNil "STALKER_camps") then { STALKER_camps = []; };

private _spacing = ["VSA_stalkerCampSpacing", 300] call VIC_fnc_getSetting;
private _tooClose = false;
{
    if (_pos distance (_x select 2) < _spacing) exitWith { _tooClose = true; };
} forEach STALKER_camps;
if (_tooClose) exitWith {
    // Silently skip spawning if too close to another camp
};

private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

// Available factions and their unit classes
// Each entry: [FactionName, [allowed sides], [unit classes]]
private _factionInfo = [
    ["ClearSky",   [blufor,opfor,independent,civilian], [
        "B_CS_Artifact_Seeker_01","B_CS_Exo_01","B_CS_Experienced_01",
        "B_CS_Guardian_01","B_CS_Journeyman_01","B_CS_Nomad_01",
        "B_CS_Pathfinder_01","B_CS_Rookie_01","B_CS_Tracker_01",
        "SIL_STALKER_ClearSky_Medic_F","SIL_STALKER_ClearSky_Rifleman_1_F",
        "SIL_STALKER_ClearSky_Rifleman_2_F","SIL_STALKER_ClearSky_Rifleman_Light_F",
        "SIL_STALKER_ClearSky_Sharpshooter_F","SIL_STALKER_ClearSky_SEVA_Medic_F",
        "SIL_STALKER_ClearSky_SEVA_Rifleman_1_F","SIL_STALKER_ClearSky_SEVA_Rifleman_2_F",
        "SIL_STALKER_ClearSky_SEVA_Rifleman_Light_F","SIL_STALKER_ClearSky_SEVA_Sharpshooter_F",
        "SIL_STALKER_ClearSky_NoPPE_Medic_F","SIL_STALKER_ClearSky_NoPPE_Rifleman_1_F",
        "SIL_STALKER_ClearSky_NoPPE_Rifleman_2_F","SIL_STALKER_ClearSky_NoPPE_Rifleman_Light_F",
        "SIL_STALKER_ClearSky_NoPPE_Sharpshooter_F"
    ]],
    ["Mercenaries", [blufor,opfor,independent], [
        "B_Merc_Contractor_01","B_Merc_Exo_Merc_01","B_Merc_Merc_Assassin_01",
        "B_Merc_Merc_Scout_01","B_Merc_Merc_Seva_01","B_Merc_Old_Hand_01",
        "B_Merc_Trained_Merc_01",
        "SIL_STALKER_Merc_Autorifleman_F","SIL_STALKER_Merc_Medic_F",
        "SIL_STALKER_Merc_Rifleman_1_F","SIL_STALKER_Merc_Rifleman_2_F",
        "SIL_STALKER_Merc_Rifleman_Light_F","SIL_STALKER_Merc_Sharpshooter_F",
        "SIL_STALKER_Merc_Night_Medic_F","SIL_STALKER_Merc_Night_Rifleman_1_F",
        "SIL_STALKER_Merc_Night_Rifleman_2_F","SIL_STALKER_Merc_Night_Rifleman_Light_F",
        "SIL_STALKER_Merc_Night_Sharpshooter_F","SIL_STALKER_Merc_NoPPE_Autorifleman_F",
        "SIL_STALKER_Merc_NoPPE_Medic_F","SIL_STALKER_Merc_NoPPE_Rifleman_1_F",
        "SIL_STALKER_Merc_NoPPE_Rifleman_2_F","SIL_STALKER_Merc_NoPPE_Rifleman_Light_F",
        "SIL_STALKER_Merc_NoPPE_Sharpshooter_F"
    ]],
    ["Freedom",    [blufor,opfor,independent,civilian], [
        "B_FD_Anomaly_Splunker_01","B_FD_Defender_01","B_FD_Exo_01",
        "B_FD_Guardian_01","B_FD_Seedy_01","B_FD_Seedy_Sniper_01",
        "B_FD_Wardog_01",
        "SIL_STALKER_Freedom_Engineer_F","SIL_STALKER_Freedom_Medic_F",
        "SIL_STALKER_Freedom_Rifleman_1_F","SIL_STALKER_Freedom_Rifleman_2_F",
        "SIL_STALKER_Freedom_Rifleman_Light_F","SIL_STALKER_Freedom_Sharpshooter_F",
        "SIL_STALKER_Freedom_Exo_Rifleman_1_F","SIL_STALKER_Freedom_Exo_Rifleman_2_F",
        "SIL_STALKER_Freedom_NoPPE_Engineer_F","SIL_STALKER_Freedom_NoPPE_Medic_F",
        "SIL_STALKER_Freedom_NoPPE_Rifleman_1_F","SIL_STALKER_Freedom_NoPPE_Rifleman_2_F",
        "SIL_STALKER_Freedom_NoPPE_Rifleman_Light_F","SIL_STALKER_Freedom_NoPPE_Sharpshooter_F",
        "SIL_STALKER_Freedom_SEVA_Medic_F","SIL_STALKER_Freedom_SEVA_Rifleman_1_F",
        "SIL_STALKER_Freedom_SEVA_Rifleman_2_F","SIL_STALKER_Freedom_SEVA_Rifleman_Light_F"
    ]],
    ["Bandits",    [blufor,opfor,independent,civilian], [
        "O_Bdz_Assaulter_01","O_Bdz_Conman_01","O_Bdz_Criminal_01",
        "O_Bdz_Exo_01","O_Bdz_Raider_01","O_Bdz_Robber_01",
        "O_Bdz_Thug_01","O_Bdz_Waster_01",
        "O_sin_Apprentice_01","O_sin_Disciple_01","O_sin_Executor_01",
        "O_sin_Healer_01","O_sin_High_Prosecutor_01","O_sin_Novice_01",
        "O_sin_Sin_Enforcer_01",
        "SIL_STALKER_Bandit_Autorifleman_F","SIL_STALKER_Bandit_Rifleman_1_F",
        "SIL_STALKER_Bandit_Rifleman_2_F","SIL_STALKER_Bandit_Rifleman_Light_F",
        "SIL_STALKER_Bandit_Sharpshooter_F"
    ]],
    ["Duty",       [blufor,opfor], [
        "O_ODty_Artifact_Specialist_01","O_ODty_Duty_Hunter_01","O_ODty_Duty_Patrolman_01",
        "O_ODty_Duty_Officer_01","O_ODty_Duty_Private_01","O_ODty_Duty_Sniper_01",
        "O_ODty_Duty_Specialist_01","O_ODty_Duty_Trooper_01",
        "SIL_STALKER_Duty_Autorifleman_F","SIL_STALKER_Duty_Engineer_F",
        "SIL_STALKER_Duty_Medic_F","SIL_STALKER_Duty_Rifleman_1_F",
        "SIL_STALKER_Duty_Rifleman_2_F","SIL_STALKER_Duty_Rifleman_Light_F",
        "SIL_STALKER_Duty_Sharpshooter_F","SIL_STALKER_Duty_Exo_Rifleman_1_F",
        "SIL_STALKER_Duty_Exo_Rifleman_2_F","SIL_STALKER_Duty_SEVA_Medic_F",
        "SIL_STALKER_Duty_SEVA_Rifleman_1_F","SIL_STALKER_Duty_SEVA_Rifleman_2_F",
        "SIL_STALKER_Duty_SEVA_Rifleman_Light_F"
    ]],
    ["Monolith",   [opfor], [
        "O_mn_Monolith_Cultist_01","O_mn_Monolith_Disciple_01","O_mn_Monolith_Exo_01",
        "O_mn_Monolith_Fanatic_01","O_mn_Monolith_Preacher_01",
        "O_mn_Monolith_Predecessor_01","O_mn_Monolith_Scientist_01",
        "SIL_STALKER_Monolith_Autorifleman_F","SIL_STALKER_Monolith_Engineer_F",
        "SIL_STALKER_Monolith_Medic_F","SIL_STALKER_Monolith_Rifleman_1_F",
        "SIL_STALKER_Monolith_Rifleman_2_F","SIL_STALKER_Monolith_Rifleman_Light_F",
        "SIL_STALKER_Monolith_Sharpshooter_F","SIL_STALKER_Monolith_Exo_Rifleman_1_F",
        "SIL_STALKER_Monolith_Exo_Rifleman_2_F","SIL_STALKER_Monolith_SEVA_Engineer_F",
        "SIL_STALKER_Monolith_SEVA_Medic_F","SIL_STALKER_Monolith_SEVA_Rifleman_1_F",
        "SIL_STALKER_Monolith_SEVA_Rifleman_2_F","SIL_STALKER_Monolith_SEVA_Rifleman_Light_F"
    ]],
    ["Military",   [blufor], [
        "I_UA_Military_autorifleman_01","I_UA_Military_Officer_01","I_UA_Military_Private_01",
        "I_UA_Military_Sergeant_01","I_UA_Military_Stalker_01",
        "SIL_STALKER_Military_Autorifleman_F","SIL_STALKER_Military_Engineer_F",
        "SIL_STALKER_Military_Medic_F","SIL_STALKER_Military_Rifleman_1_F",
        "SIL_STALKER_Military_Rifleman_2_F","SIL_STALKER_Military_Rifleman_Light_F",
        "SIL_STALKER_Military_Sharpshooter_F","SIL_STALKER_Military_NoPPE_Engineer_F",
        "SIL_STALKER_Military_NoPPE_Medic_F","SIL_STALKER_Military_NoPPE_Rifleman_1_F",
        "SIL_STALKER_Military_NoPPE_Rifleman_2_F","SIL_STALKER_Military_NoPPE_Rifleman_Light_F",
        "SIL_STALKER_Military_NoPPE_Sharpshooter_F","SIL_STALKER_Military_SEVA_Engineer_F",
        "SIL_STALKER_Military_SEVA_Medic_F","SIL_STALKER_Military_SEVA_Rifleman_1_F",
        "SIL_STALKER_Military_SEVA_Rifleman_2_F","SIL_STALKER_Military_SEVA_Rifleman_Light_F",
        "SIL_STALKER_Military_SEVA_Sharpshooter_F"
    ]],
    ["Spetznaz",   [blufor], [
        "I_UA_Spetznaz_Officer_01","I_UA_Spetznaz_Operator_01",
        "I_UA_Spetznaz_Sergeant_01","I_UA_Spetznaz_Sniper_01"
    ]],
    ["Ecologists", [blufor,opfor,independent,civilian], [
        "I_Eco_Eco_Guard_01","I_Eco_Eco_Stalker_01","I_Eco_Field_Ecologist_01",
        "I_Eco_Lab_Scientist_01","I_Eco_Protector_01",
        "SIL_STALKER_Ecologist_Scientist_1_F","SIL_STALKER_Ecologist_Scientist_2_F"
    ]],
    ["Loners",     [independent], [
        "I_LNR_Artifact_Huner_01","I_LNR_Explorer_01","I_LNR_Loner_01",
        "I_LNR_Loner_Rookie_01","I_LNR_Mutant_Hunter_01",
        "I_LNR_Tourist_01","I_LNR_Veteran_01",
        "SIL_STALKER_Loner_Autorifleman_F","SIL_STALKER_Loner_Engineer_F",
        "SIL_STALKER_Loner_Medic_F","SIL_STALKER_Loner_Rifleman_1_F",
        "SIL_STALKER_Loner_Rifleman_2_F","SIL_STALKER_Loner_Rifleman_Light_F",
        "SIL_STALKER_Loner_Sharpshooter_F","SIL_STALKER_Loner_NoPPE_Autorifleman_F",
        "SIL_STALKER_Loner_NoPPE_Medic_F","SIL_STALKER_Loner_NoPPE_Rifleman_1_F",
        "SIL_STALKER_Loner_NoPPE_Rifleman_2_F","SIL_STALKER_Loner_NoPPE_Rifleman_Light_F",
        "SIL_STALKER_Loner_NoPPE_Sharpshooter_F","SIL_STALKER_Loner_SEVA_Suit_Medic_F",
        "SIL_STALKER_Loner_SEVA_Suit_Rifleman_1_F","SIL_STALKER_Loner_SEVA_Suit_Rifleman_2_F",
        "SIL_STALKER_Loner_SEVA_Suit_Rifleman_Light_F"
    ]],
    ["Ward", [blufor], [
        "SIL_STALKER_Ward_Engineer_F","SIL_STALKER_Ward_Medic_F",
        "SIL_STALKER_Ward_Rifleman_1_F","SIL_STALKER_Ward_Rifleman_2_F",
        "SIL_STALKER_Ward_Rifleman_Light_F"
    ]],
    ["IPSF", [blufor], [
        "SIL_STALKER_IPSF_Medic_F","SIL_STALKER_IPSF_Rifleman_1_F",
        "SIL_STALKER_IPSF_Rifleman_2_F","SIL_STALKER_IPSF_Rifleman_Light_F",
        "SIL_STALKER_IPSF_Sharpshooter_F"
    ]]
];

private _entry = selectRandom _factionInfo;
private _side    = selectRandom (_entry select 1);
private _faction = _entry select 0;
private _classes = _entry select 2;

private _grp = createGroup _side;
for "_i" from 1 to _size do {
    private _cls = selectRandom _classes;
    _grp createUnit [_cls, _pos, [], 0, "FORM"];
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
        case "Bandits": {VIC_colorBandits};
        case "ClearSky": {VIC_colorClearSky};
        case "Ecologists": {VIC_colorEcologists};
        case "Military": {VIC_colorMilitary};
        case "Duty": {VIC_colorDuty};
        case "Freedom": {VIC_colorFreedom};
        case "Loners": {VIC_colorLoners};
        case "Mercs": {VIC_colorMercs};
        case "Ward": {VIC_colorWard};
        case "IPSF": {VIC_colorIPSF};
        case "Monolith": {VIC_colorMonolith};
        default {"#(1,1,1,1)"};
    };
    [_marker, _pos, "ICON", "mil_box", _color, 0.2, _faction, [1,1], true] call VIC_fnc_createGlobalMarker;
};

STALKER_camps pushBack [_campfire, _grp, _pos, _anchor, _marker, _side, _faction, false];

// Record camp position for cooldown tracking
STALKER_campCooldowns pushBack [_pos, diag_tickTime];
