## SQF Syntax

The SQF language is intentionally minimal and relies heavily on built-in
operators. An operator can be **nular** (no arguments), **unary** (one argument)
or **binary** (two arguments). Understanding how these operators consume their
arguments helps prevent subtle bugs.

### Terminating an Expression

Each statement must end with a semicolon (`;`) or a comma. Semicolons are the
common convention and make intent clear.

```sqf
_num = 10;
_num = _num + 20; systemChat str _num;
```

The above code contains three expressions separated by semicolons even though
two share the same line.

### Brackets

* `()` override the default order of precedence or simply aid readability.
* `[]` create arrays.
* `{}` enclose code blocks and are used in control structures.

### Whitespaces and Blank Lines

Leading or trailing spaces and tabs are ignored by the engine. Lines containing
only whitespace are skipped entirely.

### Comments

`//` starts a single-line comment while `/* */` encloses a block comment.
Comments are removed during preprocessing and must not appear inside strings.
Avoid using the legacy `comment` unary operator as it still executes without any
benefit.

### Operator Types

**Nular operators** recompute a value each time they are accessed:

```sqf
_unitsArray = allUnits;
systemChat str count _unitsArray;
group player createUnit ["B_RangeMaster_F", getPosATL player, [], 0, "NONE"];
systemChat str count _unitsArray;
systemChat str count allUnits;
```

This prints `5`, `5`, then `6` because `allUnits` generates a fresh array on
every call while `_unitsArray` stores a snapshot.

**Unary operators** consume the expression on their right. Parentheses are often
required when combining them with other operators:

```sqf
_arr = [[1,2,3,4,5],[1,2,3,4],[1,2]];
count (_arr select 2); // evaluates to 2
```

**Binary operators** take a left and right argument and follow their precedence
from left to right. Complex expressions benefit from parentheses for clarity:

```sqf
_arr = [[[[[1]]]]];
_arr select 0 select 1 - 1 select 15 / 3 - 5 select 0 select 10 * 10 + 4 * 0 - 100;
```

Adding brackets to the above expression reveals the actual order of evaluation.

### exitWith Usage

In SQF, exitWith must be followed by a single expression that returns a value.

A block enclosed in `{}` is valid only if it is treated as a single expression,
like an array, a function call, or a single value.

But writing `exitWith { statement1; statement2; }` is not valid if those
statements are not themselves returning a final value.

### Loop Breakouts

When breaking out of a loop, always pass a **string label** to `breakOut`.
Using a numeric level is deprecated and may cause unexpected behavior. An
example pattern is:

```sqf
"mainLoop" call {
    while {true} do {
        if (shouldExit) then {
            breakOut "mainLoop";
        };
    };
};
```

Avoid forms like `breakOut 1` or `breakTo 1` as they rely on legacy numeric
levels. Named labels make the intent clear and prevent accidental exits from
unrelated loops.
