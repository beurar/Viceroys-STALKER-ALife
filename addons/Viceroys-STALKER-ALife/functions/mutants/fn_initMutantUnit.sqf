/*
    Applies common properties to a newly spawned mutant so that it remains silent.

    Params:
        0: OBJECT - the mutant unit
*/
params ["_unit"];

_unit disableAI "RADIOPROTOCOL";
_unit setSpeaker "NoVoice";
_unit setVariable ["BIS_noCoreConversations", true];

// Disable LAMBS danger AI on mutants if the mod is present
if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then {
    (group _unit) setVariable ["lambs_danger_disablegroupAI", true];
    _unit setVariable ["lambs_danger_disableAI", true];
};

// Log the spawn for troubleshooting
[format ["initMutantUnit: spawned %1 at %2", typeOf _unit, getPosWorld _unit]] call VIC_fnc_debugLog;

true
