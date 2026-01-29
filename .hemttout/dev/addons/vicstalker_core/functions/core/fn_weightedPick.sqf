/*
    Selects a random item from a weighted list.
    Params:
        0: ARRAY - list of [item, weight] entries
    Returns:
        ANY - randomly chosen item
*/
params ["_list"];

private _sum = 0;
{ _sum = _sum + (_x#1) } forEach _list;

private _r = random _sum;
private _acc = 0;
private _sel = _list#0#0;
{
    _acc = _acc + (_x#1);
    if (_r <= _acc) exitWith { _sel = _x#0 };
} forEach _list;
_sel
