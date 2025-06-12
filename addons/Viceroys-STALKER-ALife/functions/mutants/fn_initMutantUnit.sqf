/*
    Applies common properties to a newly spawned mutant so that it remains silent.

    Params:
        0: OBJECT - the mutant unit
*/
params ["_unit"];

_unit disableAI "RADIOPROTOCOL";
_unit setSpeaker "NoVoice";
_unit setVariable ["BIS_noCoreConversations", true];

true
