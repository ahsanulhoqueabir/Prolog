# Chapter 11 — Backtracking

> Backtracking is what makes Prolog find **every** answer to a query.

## What is backtracking?

When Prolog tries a goal and the goal **fails** (or you press `;`), Prolog
**goes back to the most recent goal that still has untried alternatives**,
and tries the next one.

This is called **chronological backtracking with depth-first search**.

## A toy example

```prolog
parent(john, mary).
parent(john, tom).
parent(mary, ann).

?- parent(john, X).
```

Step by step:

1. Prolog tries `parent(john, X) = parent(john, mary).` → succeeds, `X = mary`.
2. REPL prints `X = mary ;`. The `;` says "give me another answer."
3. Prolog **backtracks** to the parent goal and tries the next fact.
4. `parent(john, X) = parent(john, tom).` → succeeds, `X = tom`.
5. Press `.` to finish. Or `;` again to keep looking — but there are no more
   `parent(john, ...)` facts, so Prolog prints `false.`.

## Backtracking in rule bodies

```prolog
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
```

Ask: `?- grandparent(john, Who).`

1. Try `parent(X, Y)`:
   * `X = john, Y = mary` (fact 1)
   * `X = john, Y = tom` (fact 2 — after backtracking)
   * `X = mary, Y = ann` (fact 3 — backtracking again, but X is now `mary`)
   * exhausted.
2. For each binding of `X` and `Y`, try `parent(Y, Z)`:
   * With `X=john, Y=mary`: `parent(mary, ann)` succeeds → `Who = ann`.
   * With `X=john, Y=tom`: `parent(tom, _)` fails (no fact for tom as parent).
   * With `X=mary, Y=ann`: `parent(ann, _)` fails.
3. Press `;` → exhausted → `false`.

```prolog
?- grandparent(john, Who).
Who = ann .
```

(`ann` is the only grandchild of `john` in this database.)

## Using `;` to find all answers

```prolog
?- parent(john, X), parent(X, Y).
X = mary, Y = ann ;
false.
```

Two solutions were considered:
* `parent(john, mary), parent(mary, ann)` → succeeds.
* `parent(john, tom),  parent(tom, _)`   → fails on the second goal.

The whole conjunction is **true** if any combination works.

## `findall/3` to gather solutions

When you want every answer at once:

```prolog
?- findall(Who, parent(john, Who), L).
L = [mary, tom] .
```

Signature: `findall(Template, Goal, List)`.

* `Template` — what each answer should look like.
* `Goal` — the goal that produces answers.
* `List` — bound to the list of all templates.

Variants:

| Built-in          | Behaviour |
| ----------------- | --------- |
| `findall/3`       | All solutions, in order. |
| `bagof/3`         | Like findall but groups by free variables. |
| `setof/3`         | Like bagof but sorted and deduped. |
| `forall/2`        | Forall: succeeds if Goal holds for every Cond. |

```prolog
?- findall(Who, parent(_, Who), L).
L = [mary, tom, ann] .
```

## `fail/0` — force backtracking

`fail` is a goal that **always fails**. Used to force Prolog to enumerate
all solutions:

```prolog
?- parent(john, Who), format('John is parent of ~w~n', [Who]), fail.
John is parent of mary
John is parent of tom
false.
```

The final `false.` is what you want — Prolog has nothing more to say after
all failures.

## `\+ Goal` and backtracking

```prolog
?- X = a, \+ member(X, [b, c, d]).
X = a .                              % succeeds, no backtracking
```

If Prolog tries to backtrack past `\`, the negation can succeed differently,
but for our purposes `\+` is "closed" once it has decided.

## Left recursion (infinite loop!)

```prolog
bad(X) :- bad(X).
bad(0).
```

Asking `?- bad(X).` would loop forever because the first clause calls
itself recursively with the same arguments. Prolog has no idea to try the
second clause — it goes into infinite recursion.

This is **left recursion** — a recursive call that does not reduce the
size of the problem. Always make sure your recursive call has **smaller
arguments**.

## Try it yourself

1. Add three grandparent facts to the family and write `?- findall(L, grandparent(john, L), Ls).`
2. Predict the trace order of `?- parent(john, X), parent(X, Y), parent(Y, Z).`.
3. Add `fail` to a print loop:

   ```prolog
   :- initialization(main).
   main :- parent(john, Who), format('John is parent of ~w~n', [Who]), fail.
   ```

4. Using `setof`, write a query that returns the sorted, unique list of
   every child in your family.

## Recap

* Prolog uses **depth-first backtracking** to find every solution.
* Press `;` to ask for the next solution, `.` to stop.
* `findall/3`, `bagof/3`, `setof/3` gather all solutions.
* `fail/0` forces backtracking for side-effect-only goals.
* Beware **left recursion** — always shrink the input.

Next: **[Tracing](12_tracing.md)** — watching the engine live.