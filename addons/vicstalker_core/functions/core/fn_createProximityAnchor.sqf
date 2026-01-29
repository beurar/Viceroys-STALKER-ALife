/*
    Creates a hidden logic object at the supplied position. The object is used
    as an anchor for proximity based systems.

    Params:
        0: POSITION - world position where the logic should be created

    Returns: OBJECT - the created logic object
*/

params ["_pos"];

// 'Logic' has an AI brain so it must be spawned with createAgent
private _anchor = createAgent ["Logic", _pos, [], 0, "CAN_COLLIDE"];
_anchor hideObjectGlobal true;
_anchor enableSimulationGlobal false;

_anchor
