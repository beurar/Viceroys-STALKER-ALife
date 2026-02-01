/*
    Starts an artefact retrieval mission using an existing anomaly field.

    Params:
        0: NUMBER - cash reward when the artefact is collected (default 100)

    Returns:
        BOOL - true when the mission starts
*/
params [["_reward",100]];

if !(call VIC_fnc_isAntistasiUltimate) exitWith {false};
if (!isServer) exitWith {false};
if (isNil "STALKER_anomalyFields" || {STALKER_anomalyFields isEqualTo []}) exitWith {false};

private _entry = selectRandom STALKER_anomalyFields;
_entry params ["_center","_radius","_fn","_count","_objs","_marker","_site"];
private _pos = [_site, _center] select (_site isEqualTo []);

private _artifact = createVehicle ["GroundWeaponHolder_Single_F", _pos, [], 0, "CAN_COLLIDE"];
_artifact addItemCargoGlobal ["ss_artifact_dummy",1];

missionNamespace setVariable ["STALKER_artifactTarget", _artifact];
missionNamespace setVariable ["STALKER_artifactReward", _reward];

[_artifact, ["Take Artefact", { deleteVehicle (_this select 0); [] call VIC_fnc_completeArtefactHunt; }]] remoteExec ["addAction", 0, _artifact];

if (!isNil "A3U_fnc_createTask") then {
    ["VIC_ArtefactHunt","Artefact Hunt","Retrieve the artefact from the anomaly.",_pos] call A3U_fnc_createTask;
};

true
