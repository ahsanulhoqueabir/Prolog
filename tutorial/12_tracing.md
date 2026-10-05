# Chapter 12 — Tracing and Debugging

> When a Prolog program does not do what you expect, the **tracer** is your
> best friend. It shows you every step Prolog takes to prove (or fail to
> prove) a goal.

## The four ports

Every goal goes through four **ports** as Prolog tries to satisfy it:

| Port       | What Prolog is doing                                       |
| ---------- | ---------------------------------------------------------- |
| **Call**   | About to try this goal for the first time.                 |
| **Exit**   | Goal succeeded — bindings are final (until backtracking).  |
| **Redo**   | Going back to find another way to satisfy this goal.       |
| **Fail**   | No more ways to try — goal fails.                          |

When you watch the tracer, you are seeing these four events in order.

## Turning tracing on

Inside the REPL:

```prolog
?- trace.
true.

?- parent(john, X).
   Call: parent(john, _G123)
   Exit: parent(john, mary)
X = mary
   Redo: parent(john, _G123)
   Exit: parent(john, tom)
X = tom ;
   Redo: parent(john, _G123)
   Fail: parent(john, _G123)
false.
```

* `_G123` is a *fresh* (unbound) variable that Prolog invented.
* After each `Exit`, the REPL offers the answer.
* Press `;` to keep going, `.` to stop.

To turn off:

```prolog
?- notrace.
true.
```

## Single-character tracer commands

While the tracer is waiting, you can press a single character
(no Enter needed):

| Key | Action                                          |
| --- | ----------------------------------------------- |
| `c` | **c**reep — single step                         |
| `s` | **s**kip — don't enter this goal                |
| `l` | **l**eap — finish this goal completely          |
| `f` | **f**ail — force this goal to fail              |
| `a` | **a**bort                                       |
| `h` | help                                            |
| `=` | show info                                       |
| `b` | set a breakpoint                                |
| `n` | (some Prologs) nodebug                          |

Strategy:

* Use `s` on big built-ins (don't enter `is/2`).
* Use `l` to skip over recursion you don't care about.
* Use `c` for fine-grained step-by-step on the goal you are debugging.

## The graphical tracer (gtrace)

```prolog
?- gtrace.
true.
```

A new window opens with a tree-view of the search. Click nodes to expand.
This is the easiest way to visualise backtracking.

In VS Code: press `F5` and pick
**"SWI-Prolog: Trace current file (Graphical tracer)"** — it starts
`gtrace` for you.

## Spy points

You don't always want to trace **everything**. **Spy points** break only
on specific predicates.

```prolog
?- spy(parent/2).
true.

?- parent(john, X).
   Call: parent(john, _G123)
   Exit: parent(john, mary)
X = mary
   Redo: parent(john, _G123)
   Exit: parent(john, tom)
X = tom .
   Fail: parent(john, _G123)
false.
```

Other commands:

| Command            | What it does                          |
| ------------------ | ------------------------------------- |
| `spy(P/N).`        | spy on P with arity N                 |
| `nospy(P/N).`      | remove that spy                       |
| `nospyall.`        | remove all spies                      |
| `spy([P/N, Q/M]).` | spy on multiple predicates            |
| `debug.`           | turn the debugger on (uses spy list)  |
| `nodebug.`         | turn off                              |
| `listing(spypoint).` | show current spy list                |

## Breakpoints

In the graphical tracer, you can also set **breakpoints** on specific
lines. Right-click a line in `gtrace` or use the `b` command in the
command-line tracer.

## How to use the tracer to fix bugs

### Bug 1: wrong answer

```prolog
% expecting: [3, 2, 1]
% got: [1, 2, 3]
reverse([], []).
reverse([H|T], R) :- reverse(T, R1), append(R1, T, R).   % bug: should be [H|R1]
```

Run the tracer:

```prolog
?- trace, reverse([1,2,3], R).
```

Watch each `Call` and `Exit` until you see the second argument of
`append` is `T` instead of `[H|R1]`. That's your bug.

### Bug 2: stack overflow

```prolog
% loops forever
ancestor(X, Y) :- ancestor(X, Y).   % no base case!
ancestor(X, Y) :- parent(X, Y).
```

```prolog
?- ancestor(john, X).
   Call: ancestor(john, _G123)
   Call: ancestor(john, _G123)
   ...
ERROR: Out of local stack
```

The tracer shows you the same goal being called recursively with the same
arguments — that is left recursion. Add a base case, or write it as:

```prolog
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

### Bug 3: query returns `false` but should succeed

```prolog
% expecting: true
% got: false
parent(john, mary).
father(X, Y) :- parent(X, Y), male(X).   % male(john) missing
```

```prolog
?- father(john, mary).
```

Trace shows: `parent(john, mary)` exits successfully, then `male(john)`
**fails** (no such fact). The bug is missing data, not code.

## Print debugging

Sometimes the tracer is too noisy. Sprinkle prints:

```prolog
:- use_module(library(format)).

debug_fact(N, F) :-
    format('Calling fact(~w)~n', [N]),
    fact(N, F),
    format('fact(~w) = ~w~n', [N, F]).
```

Or use `assert/1`, `write/1`, and `nl`:

```prolog
trace_call(G) :- call(G), format('SUCCESS: ~w~n', [G]).
trace_call(G) :- \+ call(G), format('FAIL:    ~w~n', [G]).
```

For pure print-debugging, this is often faster than `trace.`.

## Common debugging recipes (cheat sheet)

| Symptom                                  | First thing to try |
| ---------------------------------------- | ------------------ |
| `Out of local stack`                     | Add a base case or check that recursive call has smaller input |
| `false` when you expected `true`         | `trace.` and look for which goal fails |
| Wrong answer                             | Print intermediate values with `format/2` |
| Loop forever                             | `Ctrl+C`, then check the base case |
| "Singleton variable" warning             | Replace with `_` if you don't care |
| "No permission to call"                  | You used a built-in with arguments in the wrong order |
| Answer is `_G123` not a value            | You used an unbound variable where a value was expected |

## Try it yourself

For each lab program (`lab6/p01..p15.pl`):

1. Open the file in VS Code.
2. Press `F5` → Graphical tracer.
3. Run a query.
4. Watch the call tree.
5. Predict the *next* event before it happens. Check yourself.

Do this 5 times and you will be able to read any Prolog program.

## Recap

* `trace.` starts the tracer; `notrace.` stops it.
* `gtrace.` opens the graphical tracer (use `F5` in VS Code).
* `spy(P/N).` traces only `P/N`; `nospyall.` clears.
* Single-character commands: `c` creep, `s` skip, `l` leap, `f` fail.
* The four ports — Call, Exit, Redo, Fail — describe the lifecycle of
  every goal.

You have completed the tutorial. Visit the **[Glossary](99_glossary.md)**
for a one-line definition of every Prolog term you encountered.