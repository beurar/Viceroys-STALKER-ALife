/*
    Handles ambient stalker wanderer groups. Groups are removed when their
    patrol grid cell becomes inactive and respawned when the cell is active.
    STALKER_wanderers entries: [group, position, marker, active]
*/

// ["manageWanderers"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_wanderers") exitWith {};

private _groupSize = ["VSA_ambientStalkerSize", 4] call VIC_fnc_getSetting;
private _range = missionNamespace getVariable ["STALKER_activityRadius", 1500];

{
    _x params ["_grp","_pos","_marker","_active"];

    private _newActive = [_pos,_range,_active] call VIC_fnc_evalSiteProximity;

    if (_newActive) then {
        if (isNull _grp || { count units _grp == 0 }) then {
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

            _grp = createGroup _side;
            for "_i" from 1 to _groupSize do {
                _grp createUnit [_class, _pos, [], 0, "FORM"];
            };
            [_grp, _pos] call BIS_fnc_taskPatrol;
        };
        if (_marker != "") then { _marker setMarkerAlpha 1; };
    } else {
        if (!isNull _grp) then {
            { deleteVehicle _x } forEach units _grp;
            deleteGroup _grp;
            _grp = grpNull;
        };
        if (_marker != "") then { _marker setMarkerAlpha 0.2; };
    };

    STALKER_wanderers set [_forEachIndex, [_grp, _pos, _marker, _newActive]];
} forEach STALKER_wanderers;

true
