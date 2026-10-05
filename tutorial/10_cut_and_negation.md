# Chapter 10 — Cut (!) and Negation (\+)

> Sometimes you want to **stop Prolog from looking for more answers**, or
> say "this should be **false**". That's where `!` and `\+` come in.

## Cut (`!`)

The cut is written as an exclamation mark `!`. It is a goal that **always
succeeds** but **prunes the search tree**: Prolog discards all
backtrack-points to the *left* of the cut.

### The three effects of cut

1. **Commit to this clause**: no other clauses of this predicate will be
   tried.
2. **Forget alternatives in the body**: no earlier goals in this body will
   be retried.
3. **Succeed**: control passes to the next goal.

### Example: minimum that stops searching

Without cut, `min/3` might try to enumerate all solutions:

```prolog
min(X, Y, X) :- X =< Y.
min(X, Y, Y) :- X > Y.
```

```prolog
?- min(3, 5, M).
M = 3 ;
true.                        % there is no second solution but Prolog
                             % checked the second clause anyway
```

With cut, once one clause succeeds, the others are pruned:

```prolog
min(X, Y, X) :- X =< Y, !.
min(X, Y, Y) :- X > Y.
```

```prolog
?- min(3, 5, M).
M = 3 .                      % cleaner answer
```

### When **not** to use cut

Cut removes solutions. If your predicate is supposed to enumerate, do **not**
cut:

```prolog
% BAD — this kills the backtracking enumeration
member(X, [X|_]) :- !.
member(X, [_|T]) :- member(X, T).
```

```prolog
?- member(X, [a, b, c]).
X = a .                      % missing b and c!
```

Keep `member/2` cut-free:

```prolog
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
```

### Green cut vs red cut

* **Green cut**: doesn't change the meaning of the predicate, only makes it
  faster. The min example above is green — min can only have one answer.
* **Red cut**: changes the meaning. Used carefully to encode
  *if-then-else* and *negation*.

### Green cut: `if-then-else`

```prolog
%  Cond -> Then ; Else
sign(X, 'nonneg') :- X >= 0, !.
sign(_, 'neg').
```

```prolog
?- sign(5, S).
S = nonneg .

?- sign(-3, S).
S = neg .
```

### Red cut: control flow

```prolog
% once(Goal)  -- Goal should succeed exactly once
once(Goal) :- Goal, !.
```

## Negation as failure: `\+`

`\+ Goal` succeeds **when** Goal **cannot be proven**. This is **not** true
negation — it is "negation as failure", based on the Closed World
Assumption.

```prolog
?- \+ parent(john, kate).
true.                        % we have no fact parent(john, kate)
```

Compare to:

```prolog
?- parent(john, kate).
false.                       % same idea, different style
```

### Common idiom

```prolog
adult(X) :- age(X, A), A >= 18.
minor(X) :- person(X), \+ adult(X).
```

If we cannot prove X is adult, we conclude X is minor.

### `\+` cannot bind variables

```prolog
?- \+ member(X, [a, b, c]).
true.                        % there IS a member, so we get... wait
?- member(X, [a, b, c]).
X = a .
?- \+ member(X, [a, b, c]).
% Prolog tries to prove member(X, [a,b,c]) for SOME X — succeeds with X=a
% so \+ fails
false.
```

To use it correctly, ensure variables are bound **before** `\+`:

```prolog
?- X = a, \+ member(X, [b, c, d]).
X = a .                      % a is not in [b,c,d] → true

?- X = a, \+ member(X, [a, b, c]).
false.                       % a IS in [a,b,c] → fails
```

This is a classic beginner gotcha.

## Disjunction with `;`

You can express OR directly:

```prolog
fruit_color(pink, F) :- F = grapefruit ; F = dragonfruit.
```

Or use multiple clauses:

```prolog
fruit_color(pink, grapefruit).
fruit_color(pink, dragonfruit).
```

## Decision: cut vs. multiple clauses vs. recursion

| Pattern | Use when |
| ------- | -------- |
| Multiple clauses of the same predicate | Different cases that should each be tried (enumeration) |
| One clause with `!` after a guard | Only one case can possibly apply; cut is **green** |
| `\+ Goal` | "No proof exists for Goal" |
| `Goal1 -> Goal2 ; Goal3` | if-then-else, exactly one branch |

## Try it yourself

Write these without looking:

1. `min3(A, B, C, Min)` — Min is the smallest of three numbers, with
   exactly one solution.
2. `unique_member(X, [L|Ms])` — X is the only occurrence of `X` in the
   list. (Hint: count occurrences.)
3. `positive(X) :- X > 0, !.`  and `positive(_).` — try the queries
   `positive(-3)`, `positive(0)`, `positive(5)`. What's the result and why?

## Recap

* `!` (cut) is a goal that succeeds and prunes the search tree to its
  left.
* Use it as a **green cut** when you know only one answer can exist; avoid
  it when you want enumeration.
* `\+ Goal` is "negation as failure" — succeeds iff Goal cannot be proven.
* `\+` does not bind variables.
* `->` and `;` give you if-then-else.

Next: **[Backtracking](11_backtracking.md)** — the engine under everything.