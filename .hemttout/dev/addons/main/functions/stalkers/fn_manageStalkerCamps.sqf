/*
    Activates or deactivates stalker camps based on player proximity.
    STALKER_camps entries: [campfire, group, position, anchor, marker, side, faction, active]
*/

// ["manageStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_camps") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

for "_i" from ((count STALKER_camps) - 1) to 0 step -1 do {
    STALKER_camps select _i params ["_camp", "_grp", "_pos", "_anchor", "_marker", "_side", "_faction", ["_active", false]];
    private _newActive = [_anchor, _dist, _active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (isNull _camp) then {
            // Spawn the campfire a few meters away from the building
            private _firePos = _pos getPos [3 + random 3, random 360];
            _camp = "Campfire_burning_F" createVehicle _firePos;
        };
        if (isNull _grp || { units _grp isEqualTo [] }) then {
            private _class = switch (_faction) do {
                case "ClearSky": {
                    selectRandom [
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
                    ]
                };
                case "Mercenaries": {
                    selectRandom [
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
                    ]
                };
                case "Freedom": {
                    selectRandom [
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
                    ]
                };
                case "Bandits": {
                    selectRandom [
                        "O_Bdz_Assaulter_01","O_Bdz_Conman_01","O_Bdz_Criminal_01",
                        "O_Bdz_Exo_01","O_Bdz_Raider_01","O_Bdz_Robber_01",
                        "O_Bdz_Thug_01","O_Bdz_Waster_01",
                        "O_sin_Apprentice_01","O_sin_Disciple_01","O_sin_Executor_01",
                        "O_sin_Healer_01","O_sin_High_Prosecutor_01","O_sin_Novice_01",
                        "O_sin_Sin_Enforcer_01",
                        "SIL_STALKER_Bandit_Autorifleman_F","SIL_STALKER_Bandit_Rifleman_1_F",
                        "SIL_STALKER_Bandit_Rifleman_2_F","SIL_STALKER_Bandit_Rifleman_Light_F",
                        "SIL_STALKER_Bandit_Sharpshooter_F"
                    ]
                };
                case "Duty": {
                    selectRandom [
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
                    ]
                };
                case "Monolith": {
                    selectRandom [
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
                    ]
                };
                case "Military": {
                    selectRandom [
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
                    ]
                };
                case "Spetznaz": {
                    selectRandom [
                        "I_UA_Spetznaz_Officer_01","I_UA_Spetznaz_Operator_01",
                        "I_UA_Spetznaz_Sergeant_01","I_UA_Spetznaz_Sniper_01"
                    ]
                };
                case "Ecologists": {
                    selectRandom [
                        "I_Eco_Eco_Guard_01","I_Eco_Eco_Stalker_01","I_Eco_Field_Ecologist_01",
                        "I_Eco_Lab_Scientist_01","I_Eco_Protector_01",
                        "SIL_STALKER_Ecologist_Scientist_1_F","SIL_STALKER_Ecologist_Scientist_2_F"
                    ]
                };
                case "Loners": {
                    selectRandom [
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
                    ]
                };
                case "Ward": {
                    selectRandom [
                        "SIL_STALKER_Ward_Engineer_F","SIL_STALKER_Ward_Medic_F",
                        "SIL_STALKER_Ward_Rifleman_1_F","SIL_STALKER_Ward_Rifleman_2_F",
                        "SIL_STALKER_Ward_Rifleman_Light_F"
                    ]
                };
                case "IPSF": {
                    selectRandom [
                        "SIL_STALKER_IPSF_Medic_F","SIL_STALKER_IPSF_Rifleman_1_F",
                        "SIL_STALKER_IPSF_Rifleman_2_F","SIL_STALKER_IPSF_Rifleman_Light_F",
                        "SIL_STALKER_IPSF_Sharpshooter_F"
                    ]
                };
                default {
                    "I_Soldier_F"
                };
            };
            private _new = createGroup _side;
            for "_i" from 1 to _size do { _new createUnit [_class, _pos, [], 0, "FORM"]; };
            if (local _new) then {
                if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
                    [_new, _pos, 150, [], true, true] call lambs_wp_fnc_taskCamp;
                } else {
                    [_new, _pos] call BIS_fnc_taskDefend;
                };
            } else {
                if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
                    [_new, _pos, 150, [], true, true] remoteExecCall ["lambs_wp_fnc_taskCamp", groupOwner _new];
                } else {
                    [_new, _pos] remoteExecCall ["BIS_fnc_taskDefend", groupOwner _new];
                };
            };
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
    if (_marker != "") then {
        [_marker, [0.2, 1] select _newActive] remoteExec ["setMarkerAlpha", 0];
    };

    if (!_newActive && { isNull _grp && { isNull _camp } }) then {
        if (_marker != "") then { [_marker] remoteExec ["deleteMarker", 0]; };
        STALKER_camps deleteAt _i;
    } else {
        STALKER_camps set [_i, [_camp, _grp, _pos, _anchor, _marker, _side, _faction, _newActive]];
    };
};

true
