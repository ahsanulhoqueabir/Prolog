# Chapter 6 — Recursion

> Prolog has no `for` loop, no `while`, no iterators. **Recursion** is the
> only way to repeat.

## The pattern

Almost every recursive Prolog predicate has two clauses:

```prolog
my_predicate(...) :- base_case(...).              % base case
my_predicate(...) :- recursive_case(...).         % recursive case
```

* **Base case**: stops the recursion. Usually a fact.
* **Recursive case**: does one piece of work, then calls itself with a
  *smaller* problem.

## Example: factorial

`N! = N × (N-1) × ... × 2 × 1` — and `0! = 1`.

```prolog
fact(0, 1).
fact(N, F) :- N > 0, N1 is N - 1, fact(N1, F1), F is N * F1.
```

Read it aloud:*

* `fact(0, 1)` — factorial of 0 is 1. **Base case.**
* `fact(N, F) :- ...` — factorial of N is F, *if* N is positive, then
  factorial of `N-1` is `F1`, and `F` is `N * F1`. **Recursive case.**

Try:

```prolog
?- fact(5, X).
X = 120 .
```

## Tracing by hand: `fact(3, X)`

1. Try the base case: `fact(0, 1).` — `3 = 0`? No, fail.
2. Try the recursive case:
     * `N = 3`, `N > 0` ✓
     * `N1 = 2`
     * recursive call `fact(2, F1)`:
       * base fails (`2 \= 0`)
       * recursive: `N1 = 1`, `fact(1, F1a)`
         * base fails (`1 \= 0`)
         * recursive: `N1 = 0`, `fact(0, F1b)` → `F1b = 1`
         * `F1a = 1 * 1 = 1`
       * `F1 = 2 * 1 = 2`
     * `F = 3 * 2 = 6`
3. Answer: `X = 6`.

Notice: the recursion is **unwound at the end**, not the beginning — values
flow *back up*. Prolog is depth-first.

## Example: length of a list

We'll cover lists properly in the next chapter, but this shows the shape:

```prolog
length([], 0).
length([_|T], N) :- length(T, N1), N is N1 + 1.
```

* Base: empty list has length 0.
* Recursive: the length of `[H|T]` is one more than the length of `T`.

```prolog
?- length([a, b, c], X).
X = 3 .
```

## The order of clauses matters

```prolog
% wrong order
fact(N, F) :- N > 0, ..., fact(N1, F1), F is N * F1.
fact(0, 1).
```

This **might** still work but the base case must be tried first to actually
finish — and Prolog will, in fact, try the recursive clause first. When the
recursive case's call recurses again with `N = 0`, then the base case fires
correctly… but only because we have the recursive case's guard `N > 0`.

In general, **put the base case first** unless you have a guard. This is a
habit worth forming.

## Tail-recursive version

The factorial above is **not** tail-recursive: after the recursive call
`fact(N1, F1)`, there is still work to do (`F is N * F1`). Prolog has to
remember the multiplications to do on the way back up.

A tail-recursive version uses an **accumulator**:

```prolog
fact(N, F) :- fact_acc(N, 1, F).
fact_acc(0, Acc, Acc).
fact_acc(N, Acc, F) :- N > 0, NewAcc is Acc * N, N1 is N - 1, fact_acc(N1, NewAcc, F).
```

```prolog
?- fact(5, X).
X = 120 .
```

The recursive call is the **last** goal in the body, so Prolog can reuse
the same stack frame. Modern SWI-Prolog optimises this automatically
("last call optimisation"), but writing it tail-recursive is a good habit.

## Example: ancestor (revisited)

```prolog
ancestor(X, Y) :- parent(X, Y).                          % base
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).          % recurse through Z
```

```prolog
parent(john, mary).
parent(mary, ann).
parent(ann, kate).

?- ancestor(john, X).
X = mary ;
X = ann ;
X = kate .
```

This is one of the most beautiful Prolog idioms: "X is an ancestor of Y if
X is a parent of Y **or** X is a parent of someone who is an ancestor of Y."

## Common recursion mistakes

| Mistake | Symptom |
| ------- | ------- |
| Forgetting the base case | Stack overflow / `ERROR: Out of local stack` |
| Base case that can never match | Same — recursion never terminates |
| Recursive call not smaller | Same — infinite loop |
| Wrong order of recursive terms | Wrong answer or infinite loop |

## Try it yourself

Without looking back, write:

1. `sum_to(N, S)` — `sum_to(5, 15)` because `1+2+3+4+5 = 15`.
2. `pow(X, N, R)` — X to the power N is R. (Hint: base `pow(_, 0, 1)`.)
3. `count_down(N) :- N > 0, format('~w~n', [N]), N1 is N - 1, count_down(N1).`

Run each in the REPL. If you get `Out of local stack`, you missed the base case.

## Recap

* Recursion is the only looping construct in Prolog.
* Always have a **base case** and a **recursive case**.
* Put the base case **first**.
* Tail-recursive predicates (accumulator pattern) are more efficient.
* "Recursive case uses a strictly smaller input" is the key invariant.

Next: **[Lists](07_lists.md)** — the data structure you'll use everywhere.