// CBA settings configuration for Viceroy's STALKER ALife

// Setting to enable or disable AI panic behavior during emission buildup.
[
    "VSA_AIPanicEnabled",
    "CHECKBOX",
    ["Enable AI Emission Panic", "AI units will attempt to find cover indoors or in trenches when an emission is building up."],
    "VSA Emission",
    true
] call CBA_fnc_addSetting;

