/*
    Placeholder executed after an emission concludes. Zombification systems
    can process pending conversions here.
*/

["zombification_onEmissionEnd"] call VIC_fnc_debugLog;

[] call VIC_fnc_spawnZombiesFromQueue;

true
