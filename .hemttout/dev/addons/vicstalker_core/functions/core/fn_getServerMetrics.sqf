/*
    Server-side: return simple performance metrics and counts for debug display.
    Returns: ARRAY - [tickTime, countsHash]
*/
if (!isServer) exitWith { [] };

private _counts = format ["anomalies:%1;minefields:%2;booby:%3;ieds:%4;herds:%5;nests:%6;wrecks:%7",
    (if (isNil "STALKER_anomalyFields") then {0} else { count STALKER_anomalyFields }),
    (if (isNil "STALKER_minefields") then {0} else { count STALKER_minefields }),
    (if (isNil "STALKER_boobyTraps") then {0} else { count STALKER_boobyTraps }),
    (if (isNil "STALKER_iedSites") then {0} else { count STALKER_iedSites }),
    (if (isNil "STALKER_activeHerds") then {0} else { count STALKER_activeHerds }),
    (if (isNil "STALKER_mutantNests") then {0} else { count STALKER_mutantNests }),
    (if (isNil "STALKER_wreckPositions") then {0} else { count STALKER_wreckPositions })
];

[
    diag_tickTime,
    _counts
]
