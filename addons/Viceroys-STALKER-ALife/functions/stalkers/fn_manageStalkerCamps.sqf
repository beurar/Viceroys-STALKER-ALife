/*
    Activates or deactivates stalker camps based on player proximity.
    STALKER_camps entries: [campfire, group, position, marker, side, faction, active]
*/

// ["manageStalkerCamps"] call VIC_fnc_debugLog;

if (!isServer) exitWith {};
if (isNil "STALKER_camps") exitWith {};

private _dist = missionNamespace getVariable ["STALKER_activityRadius", 1500];
private _size = ["VSA_stalkerCampSize", 4] call VIC_fnc_getSetting;

{
    _x params ["_camp", "_grp", "_pos", "_marker", "_side", "_faction",["_active",false]];
    private _newActive = [_pos,_dist,_active] call VIC_fnc_evalSiteProximity;
    if (_newActive) then {
        if (isNull _camp) then {
            // Spawn the campfire a few meters away from the building
            private _firePos = _pos getPos [3 + random 3, random 360];
            _camp = "Campfire_burning_F" createVehicle _firePos;
        };
        if (isNull _grp || { count units _grp == 0 }) then {
            private _class = switch (_faction) do {
                case "ClearSky": {
                    selectRandom [
                        "B_CS_Artifact_Seeker_01","B_CS_Exo_01","B_CS_Experienced_01",
                        "B_CS_Guardian_01","B_CS_Journeyman_01","B_CS_Nomad_01",
                        "B_CS_Pathfinder_01","B_CS_Rookie_01","B_CS_Tracker_01"
                    ]
                };
                case "Mercenaries": {
                    selectRandom [
                        "B_Merc_Contractor_01","B_Merc_Exo_Merc_01","B_Merc_Merc_Assassin_01",
                        "B_Merc_Merc_Scout_01","B_Merc_Merc_Seva_01","B_Merc_Old_Hand_01",
                        "B_Merc_Trained_Merc_01"
                    ]
                };
                case "Freedom": {
                    selectRandom [
                        "B_FD_Anomaly_Splunker_01","B_FD_Defender_01","B_FD_Exo_01",
                        "B_FD_Guardian_01","B_FD_Seedy_01","B_FD_Seedy_Sniper_01",
                        "B_FD_Wardog_01"
                    ]
                };
                case "Bandits": {
                    selectRandom [
                        "O_Bdz_Assaulter_01","O_Bdz_Conman_01","O_Bdz_Criminal_01",
                        "O_Bdz_Exo_01","O_Bdz_Raider_01","O_Bdz_Robber_01",
                        "O_Bdz_Thug_01","O_Bdz_Waster_01"
                    ]
                };
                case "Duty": {
                    selectRandom [
                        "O_ODty_Artifact_Specialist_01","O_ODty_Duty_Hunter_01","O_ODty_Duty_Patrolman_01",
                        "O_ODty_Duty_Officer_01","O_ODty_Duty_Private_01","O_ODty_Duty_Sniper_01",
                        "O_ODty_Duty_Specialist_01","O_ODty_Duty_Trooper_01"
                    ]
                };
                case "Monolith": {
                    selectRandom [
                        "O_mn_Monolith_Cultist_01","O_mn_Monolith_Disciple_01","O_mn_Monolith_Exo_01",
                        "O_mn_Monolith_Fanatic_01","O_mn_Monolith_Preacher_01",
                        "O_mn_Monolith_Predecessor_01","O_mn_Monolith_Scientist_01"
                    ]
                };
                case "Military": {
                    selectRandom [
                        "I_UA_Military_autorifleman_01","I_UA_Military_Officer_01","I_UA_Military_Private_01",
                        "I_UA_Military_Sergeant_01","I_UA_Military_Stalker_01"
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
                        "I_Eco_Lab_Scientist_01","I_Eco_Protector_01"
                    ]
                };
                case "Loners": {
                    selectRandom [
                        "I_LNR_Artifact_Huner_01","I_LNR_Explorer_01","I_LNR_Loner_01",
                        "I_LNR_Loner_Rookie_01","I_LNR_Mutant_Hunter_01",
                        "I_LNR_Tourist_01","I_LNR_Veteran_01"
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
        [_marker, (if (_newActive) then {1} else {0.2})] remoteExec ["setMarkerAlpha", 0];
    };
    STALKER_camps set [_forEachIndex, [_camp, _grp, _pos, _marker, _side, _faction, _newActive]];
} forEach STALKER_camps;

true
