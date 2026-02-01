/*
    Generates a thematic name for an anomaly field marker based on type.
    Params:
        0: STRING  - anomaly type (burner, electra, fruitpunch, etc.)
        1: ARRAY   - position for nearby town lookup
    Returns:
        STRING - generated name
*/
params ["_type", ["_pos", [0,0,0]]];

["generateFieldName"] call VIC_fnc_debugLog;

private _stalkers = [
    "Flynn","Artyom","Kolya","Strelok","Vasya","Boris","Petya","Fang","Ghost","Viktor",
    "Sidorovich","Yuri","Ivchenko","The Hermit","Kostya","Molokov","Tarkov","Zhenya","Dmitri","The Monk",
    "Anya","Valentina","Sasha","Mikhail","Grigor","Leonid","Vano","Scar","Yakov","Pavel",
    "Gennady","Taras","Oleg","Bogdan","Radik","Roman","Konstantin","Maxim","Alexei","Ivan",
    "Fyodor","Gosha","Kirill","Nikita","Denis","Ruslan","Zhora","Tarik","Illya","Ostap",
    "Miron","Sergey","Volodya","Anton","Egor","Vitaly","Stas","Rostik","Pavlo","Foma",
    "Rodion","Yaroslav","Klim","Nazar","Makar","Kuzma","Grom","Leshy","Wolfhound","Hunter",
    "Fox","Bear","Hawk","Bruise","Boroda","Doc","Red","Golem","Butcher","Bison",
    "Old Timer","Rasputin","Yegor","Valeriy","Sanya","Misha","Stepka","Lera","Yana","Vitya",
    "Slavik","Arsen","Nikifor","Oles","Dima","Gena","Pasha","Maksim","Stryker","Big Bear"
];

private _places = [];
if (_pos isNotEqualTo []) then {
    private _locs = nearestLocations [_pos, ["NameVillage","NameCity","NameCityCapital","NameLocal"], 3000];
    if (_locs isNotEqualTo []) then {
        _places = _locs apply { text _x };
    } else {
        private _feature = "";
        if (_pos call VIC_fnc_isWaterPosition) then {
            _feature = "Coast";
        } else {
            private _road = roadAt _pos;
            if (isNull _road) then {
                private _roads = _pos nearRoads 50;
                if (_roads isNotEqualTo []) then { _road = _roads select 0; };
            };
            private _nearRoad = false;
            if (!isNull _road) then { _nearRoad = _pos distance (getPos _road) < 50; };
            if (_nearRoad) then {
                _feature = "Road";
            };
            if (_feature isEqualTo "") then {
                private _trees = nearestTerrainObjects [_pos, ["TREE","SMALL TREE","BUSH"], 40, false];
                if ((count _trees) > 8) then { _feature = "Forest"; };
            };
            if (_feature isEqualTo "") then {
                private _slope = abs ((surfaceNormal _pos) select 2);
                if (_slope > 0.2) then { _feature = "Hill"; } else { _feature = "Fields"; };
            };
        };
        _places = [_feature];
    };
};

// Vocabulary dictionary
private _vocab = [
    ["burner", [
        ["Inferno","Pyre","Cinderfield","Flamewalk","Ashwell","Furnace","Smokestep","Firecrawl","Burning Verge","Charveil"],
        ["Ashen","Scorched","Charred","Blazing","Smouldering","Ignited","Searing","Redhot","Kindled"],
        ["Furnace","Cinders","Pyre","Ash","Embers","Burn","Flame","Torch","Scald"]
    ]],
    ["electra", [
        ["Storm","Sparknest","Voltagrave","Arc Spires","Shockreach","Static Nest","Discharge Crown","Tesla Wake","Brightline"],
        ["Crackling","Charged","Arcing","Ionic","Strobing","Buzzing","Luminous","Fractured","Oscillating"],
        ["Surge","Bolt","Discharge","Current","Conduit","Lightning","Flash","Jolt","Fuse"]
    ]],
    ["fruitpunch", [
        ["Rot Sprawl","Toxin Mire","Acid Slough","Blight Pool","Flesh Melt","Corrosion Nest","Sludge Grove","Vilepit","The Wasting Fold"],
        ["Putrid","Vile","Sludgy","Corrosive","Festering","Bubbling","Boiling","Malignant","Foul"],
        ["Mire","Slough","Acid","Decay","Poison","Stain","Pustule","Slick","Spill"]
    ]],
    ["springboard", [
        ["Vaultline","Spring Nest","Catapult Hollows","Leap Spiral","Kicker's Field","The Jolt Zone","Bounce Ridge","Skyhook Flats"],
        ["Boundless","Kinetic","Vaulting","Elastic","Rebounding","Tense","Sudden","Snapping"],
        ["Bounce","Toss","Launch","Vault","Spring","Recoil","Lift","Eject"]
    ]],
    ["gravi", [
        ["Crushpit","Weight Hollow","Gravi Coil","Sink Nest","Massfield","The Pressure Bend","Dense Pocket","Corewell","Gravehold"],
        ["Crushing","Sinking","Heavy","Gravitic","Dense","Compacted","Dragging","Coiled","Weighted"],
        ["Well","Weight","Mass","Collapse","Core","Pull","Sink","Anchor"]
    ]],
    ["meatgrinder", [
        ["Bone Spiral","Fleshmill","Grind Nest","The Maw","Carver's Hollow","Shredline","The Biting Coil","Viscera Yard","Rend Veil"],
        ["Gory","Shredded","Butchered","Torn","Mangled","Ragged","Gashed","Splintered"],
        ["Gore","Grinder","Flesh","Bone","Blades","Rend","Viscera","Teeth","Carcass"]
    ]],
    ["whirligig", [
        ["Spin Nest","Cyclone Path","Gyreline","Whirlpit","The Winding Field","Spiral Verge","Suction Hollow","Coil Bloom"],
        ["Swirling","Twisting","Cyclonic","Whipping","Winding","Orbiting","Whorled","Sucking","Turbulent"],
        ["Gyre","Vortex","Coil","Whirl","Spiral","Loop","Twine","Spindle"]
    ]],
    ["clicker", [
        ["Snap Reach","Death Step","Trigger Field","Clicker's Vale","Sudden Nest","The Ticker Fold","Rattle Den","Burstline"],
        ["Sudden","Ticking","Snapping","Clattering","Unseen","Hidden","Staccato","Clicking","Popping"],
        ["Click","Trigger","Surprise","Snap","Step","Jerk","Knock","Beat"]
    ]],
    ["launchpad", [
        ["Throwfield","Eject Zone","Skytrail","Jumper's Veil","Toss Nest","Updraft Hollow","Skydash Fold","Flungpath"],
        ["Chaotic","Launched","Spinning","Thrown","Flinging","Jolted","Tossed","Drifting"],
        ["Pad","Hurl","Launch","Lift","Ejection","Airwell","Glide","Burst"]
    ]],
    ["leech", [
        ["Whisper Cradle","Fading Hollow","Lull Nest","Wane Field","The Quiet Vale","Children's Steps","Weeping Fold","Echo Latch"],
        ["Haunted","Whispering","Draining","Weeping","Ghostly","Faint","Weary","Sorrowful","Pale"],
        ["Lull","Fade","Haunt","Wane","Sorrow","Weep","Whisper","Drain","Chill"]
    ]],
    ["trapdoor", [
        ["Vanisher's Gate","The Flicker Field","Slip Hollow","Rift Nest","Folded Space","Wink Spiral","Voidstep","Phantom Rift"],
        ["Flickering","Vanished","Phasing","Blinking","Shifting","Folding","Slipping","Displaced"],
        ["Rift","Trap","Gate","Step","Fold","Slip","Exit","Vanishing"]
    ]],
    ["zapper", [
        ["Shock Nest","Strike Fold","Thunder Hollow","Boltline","Burstpath","Jolt Cradle","Storm Veil","Crisping Zone"],
        ["Arcing","Blinding","Crackling","Sparking","Lancing","Charged","Seizing","Flaring"],
        ["Zapper","Charge","Spark","Bolt","Thunder","Strike","Flash","Arc"]
    ]]
];

// Fallback values
private _desc = ["Zone"];
private _adjs = ["Unstable"];
private _nouns = ["Field"];

// Assign vocab if type matches
private _set = [];
{
    if ((_x select 0) isEqualTo (toLower _type)) exitWith { _set = _x select 1; };
} forEach _vocab;
if ((count _set) > 0) then {
    _desc = _set select 0;
    _adjs = _set select 1;
    _nouns = _set select 2;
};

// Expanded naming patterns
private _patterns = [
    format ["%1 %2", selectRandom _adjs, selectRandom _nouns],
    format ["The %1 %2", selectRandom _adjs, selectRandom _nouns],
    format ["%1's %2", selectRandom _stalkers, selectRandom _nouns],
    format ["%1 of %2", selectRandom _nouns, selectRandom _places],
    format ["The %1 of %2", selectRandom _nouns, selectRandom _stalkers],
    format ["%1's %2 of %3", selectRandom _stalkers, selectRandom _nouns, selectRandom _places],
    format ["The %1 %2 of %3", selectRandom _adjs, selectRandom _nouns, selectRandom _places],
    format ["%1 %2 Nest", selectRandom _adjs, selectRandom _nouns],
    format ["%1's %2 Cradle", selectRandom _stalkers, selectRandom _nouns],
    format ["The %1 of the %2", selectRandom _nouns, selectRandom _places],
    format ["The %1's %2", selectRandom _places, selectRandom _nouns],
    format ["%1's %2 Gate", selectRandom _stalkers, selectRandom _nouns],
    format ["%1 Fold", selectRandom _desc],
    format ["%1 Spiral", selectRandom _desc],
    format ["%1 Bloom", selectRandom _desc],
    format ["The %1 Verge", selectRandom _desc],
    format ["The %1's Coil", selectRandom _places],
    format ["%1 Cradle", selectRandom _desc],
    format ["%1 Wound", selectRandom _desc],
    format ["The %1 Reach", selectRandom _desc],
    format ["%1 of the %2", selectRandom _desc, selectRandom _places]
];

private _name = selectRandom _patterns;
["generateFieldName result"] call VIC_fnc_debugLog;
_name
