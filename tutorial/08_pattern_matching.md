# Chapter 8 — Pattern Matching

> Pattern matching is unification applied to **terms with structure**.

## What is pattern matching?

When Prolog tries to prove `goal(arg1, arg2, ...)` and a clause head has
the **same predicate and arity**, it **unifies** the goal and the head. The
unification is what we call "matching".

```prolog
father(john, mary).               % a clause head
?- father(john, Who).              % a query
```

Prolog tries to unify `father(john, Who)` with `father(john, mary)` →
succeeds with `Who = mary`.

## Matching with lists

Pattern matching is the way you "destructure" a list head:

```prolog
first([H|_], H).                  % first element
rest([_|T], T).                   % everything except first
```

```prolog
?- first([1,2,3], X).
X = 1 .

?- rest([1,2,3], X).
X = [2, 3] .
```

You can match more than one element:

```prolog
first_two([A,B|_], A, B).
```

```prolog
?- first_two([1,2,3], X, Y).
X = 1, Y = 2 .
```

## Multiple patterns = multiple clauses

The same predicate often has multiple clauses for **different patterns**:

```prolog
% empty list
process([], done).

% single-element list
process([X], [X]).

% list whose first element is 0
process([0|T], X) :- process(T, X).

% any other list
process([H|T], [H|R]) :- process(T, R).
```

When you ask `?- process(L, R).`, Prolog tries each head in order until
one matches.

## Decision trees with patterns

Patterns let you write decision logic very naturally:

```prolog
% classify a list
classify([],    'empty').
classify([_],   'singleton').
classify([_,_], 'pair').
classify([_,_,_|_], 'longer').
```

```prolog
?- classify([1,2,3], X).
X = longer .
```

## Matching compound terms

```prolog
% A date is date(Year, Month, Day)
summer(date(_, 7, _)).        % any July date
summer(date(_, 8, _)).        % any August date
winter(date(_, 12, _)).
winter(date(_, 1, _)).
winter(date(_, 2, _)).
```

`_` matches anything in that position.

## Matching inside the body

You can match inside the body too, with `=`:

```prolog
date_to_list(date(Y,M,D), [Y, M, D]).
```

Used:

```prolog
?- date_to_list(date(2026, 6, 15), X).
X = [2026, 6, 15] .
```

## Don't confuse `=` with pattern matching!

* `=` is the unification operator — it tries to unify two terms and
  succeeds or fails.
* **Pattern matching** is what unification does when you put a structured
  term on one side and variables on the other.

```prolog
?- [H|T] = [a, b, c].
H = a, T = [b, c] .

?- [H] = [a].
H = a .
```

## Pattern matching is reversible

The same predicate can be used to **build**, **take apart**, or **check**
a term:

```prolog
point(X, Y, point(X, Y)).    % build: point(1, 2, P) → P = point(1, 2)
                             % take apart: point(X, Y, point(1, 2)) → X=1, Y=2
                             % verify: point(1, 2, point(1, 2)) → true
```

This is why Prolog predicates are so compact.

## When matching fails

```prolog
?- [a, b] = [H, X].
false.     % wrong arity for the tail; only one H here

?- [a | [b, c]] = [H, T].
false.     % H = a, T = [b, c] matches [a, b, c], but the goal is [H, T]
                       % which would need [a, T] = [a, b, c] → T = [b, c] ✓
                       % actually wait — [H, T] = [a, b, c] → H=a, T=c? Let me redo
?- [a, T] = [a, b, c].
false.     % left has 2 elements, right has 3 — wrong arity
```

## Try it yourself

Write predicates that match the following:

1. `init([1,2,3], X).` — `init` returns the list minus its last element.
2. `swap(pair(A, B), pair(B, A)).` — swap arguments of a `pair/2` term.
3. `is_sorted([]).` and `is_sorted([_]).` — base cases for a sorted check.
4. `nth(0, [H|_], R) :- R = H.` — return the 0th element. Add the
   recursive case for `nth(N, [_|T], R) :- N > 0, N1 is N - 1, nth(N1, T, R).`

## Recap

* **Pattern matching** is unification applied to structured terms.
* It is how Prolog chooses **which clause** to try.
* The same clause can build, take apart, or verify a term — depending on
  which arguments are bound.
* Use `_` to ignore parts you don't care about.

Next: **[Arithmetic](09_arithmetic.md)** — numbers and comparisons.