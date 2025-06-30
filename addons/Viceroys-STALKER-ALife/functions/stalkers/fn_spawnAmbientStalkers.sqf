/*
    Spawns roaming stalker groups that patrol random areas of the map.
    Settings via CBA:
      - VSA_enableAmbientStalkers: enable spawning
      - VSA_ambientStalkerGroups:  number of groups
      - VSA_ambientStalkerSize:    units per group
      - VSA_ambientStalkerNightOnly: spawn only at night
*/

["spawnAmbientStalkers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};

if (["VSA_enableAmbientStalkers", true] call VIC_fnc_getSetting isEqualTo false) exitWith {};

if (isNil "STALKER_stalkerGroups") then { STALKER_stalkerGroups = []; };
if (isNil "STALKER_wanderers") then { STALKER_wanderers = []; };

private _groupCount = ["VSA_ambientStalkerGroups", 2] call VIC_fnc_getSetting;
private _groupSize  = ["VSA_ambientStalkerSize", 4] call VIC_fnc_getSetting;
private _nightOnly  = ["VSA_ambientStalkerNightOnly", false] call VIC_fnc_getSetting;

if (_nightOnly && {daytime > 5 && daytime < 20}) exitWith {};

private _players = allPlayers select { alive _x && {!isNull _x} };
if (_players isEqualTo []) exitWith {};

for "_i" from 1 to _groupCount do {
    private _center = selectRandom _players;
    private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
    private _pos = _center getPos [ random (_dist * 0.75), random 360 ];
    _pos = [_pos] call VIC_fnc_findLandPosition;
    if (isNil {_pos} || {_pos isEqualTo []}) then { continue };
    if (!([_pos, _dist] call VIC_fnc_hasPlayersNearby)) then { continue };

    // Random faction and side for this wanderer group
    // Format: [name, [allowed sides], unit classes]
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
    private _class   = selectRandom (_entry select 2);

    private _grp = createGroup _side;
    for "_j" from 1 to _groupSize do {
        _grp createUnit [_class, _pos, [], 0, "FORM"];
    };
    [_grp, _pos] call BIS_fnc_taskPatrol;

    private _marker = "";
    if (["VSA_debugMode", false] call VIC_fnc_getSetting) then {
        _marker = format ["stk_%1_%2", count STALKER_stalkerGroups, diag_tickTime];
        [_marker, _pos, "ICON", "mil_dot", "ColorGreen", 0.2] call VIC_fnc_createGlobalMarker;
    };

    STALKER_stalkerGroups pushBack [_grp, _marker];
    STALKER_wanderers pushBack [_grp, _pos, _marker, true];
}; 
