# Chapter 5 — Unification

> **Unification** is the heart of Prolog. It is how Prolog decides whether
> two terms are "the same" and, if so, fills in the variables to make them so.

## What `=` really means

In most languages `=` is **assignment**. In Prolog `=` is **unification**.

```prolog
?- X = food.
X = food.

?- food = food.
true.

?- food = wine.
false.

?- X = Y, Y = food.
X = Y, Y = food.            % both bound to food
```

Unification tries to make both sides look identical. Variables get bound
to whatever value is needed to make that happen.

## The unification algorithm

Given two terms `A` and `B`:

1. If both are **atoms** (or numbers): succeed if identical, fail otherwise.
2. If one is a **variable** and the other is anything: bind the variable
   to the other term, succeed.
3. If both are **compound terms** (like `parent(X, Y)`):
   * succeed if both have the same functor and arity,
   * unify their arguments one by one.

## Worked examples

### Example 1: atom vs variable

```prolog
?- food = X.
X = food.
```

`X` (variable) is bound to `food` (atom). Trivial.

### Example 2: same atom

```prolog
?- food = food.
true.
```

Both are atoms, equal → success.

### Example 3: different atoms

```prolog
?- food = wine.
false.
```

Both atoms but not equal → fail.

### Example 4: variable vs variable

```prolog
?- X = Y.
X = Y.
```

Neither is bound. Prolog binds them **together** — they share a single
value. If one later gets bound, the other inherits it.

### Example 5: compound terms

```prolog
?- parent(john, mary) = parent(john, Who).
X = j... wait — let me redo
?- parent(john, mary) = parent(john, Who).
Who = mary.
```

Both have functor `parent/2`. Arguments unify one by one:
`john = john` ✓, then `mary = Who` binds `Who = mary`.

### Example 6: nested

```prolog
?- loves(mary, food) = loves(mary, X).
X = food.

?- loves(X, X) = loves(mary, food).
false.                      % first X = mary, second X = food — conflict
```

In the last one, both `X`s would need to be the same, but `mary` ≠ `food`.

## Unification vs equality

| `=` (unification)  | `==` (strict equality)         |
| ------------------ | ------------------------------ |
| Binds variables    | Both must already be bound    |
| `?- X = food.` succeeds | `?- X == food.` fails (`X` unbound) |
| `?- 5 = 5.` succeeds    | `?- 5 == 5.` succeeds          |
| `?- X = Y, X = 1, Y == 1.` succeeds |   |

`\=` is the negation of `=`. `\==` is the negation of `==`.

## The "occurs check"

Prolog does **not** do the occurs check by default. This means it can
unify a variable with a term that contains itself:

```prolog
?- X = f(X).
X = f(X).                   % "infinite term" — legal but dangerous
```

In practice this rarely bites beginners — but if you ever see weird
behaviour with infinite recursion, this is why. Use `unify_with_occurs_check/2`
if you need safety:

```prolog
?- unify_with_occurs_check(X, f(X)).
false.                      % rejected
```

## Common pattern: matching the head of a rule

Unification is also how Prolog decides **which rule to try**:

```prolog
parent(john, mary).
parent(john, tom).

?- parent(john, X).
```

Prolog unifies `parent(john, X)` with each fact's head until one succeeds:
* Try `parent(john, X) = parent(john, mary).` → `X = mary` ✓ (success)
* If you press `;`, Prolog tries `parent(john, X) = parent(john, tom).` →
  `X = tom`.

You are using unification for understanding.

## Unification in the body of rules

```prolog
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).
```

When you ask `?- grandfather(john, Who).`:

1. `parent(john, Y)` is unified with each fact, binding `Y = mary`, then
   `Y = tom` (after `;`).
2. The `Y` that flows into the next goal is what unifies there.
3. Inside the body, Prolog unifies everything together.

## Try it yourself

Given:

```prolog
parent(john, mary).
parent(mary, ann).
```

Predict:

1. `?- parent(john, X) = parent(Y, Z).` — what bindings?
2. `?- X = parent(john, Y), Y = mary.`
3. `?- parent(X, Y) = parent(A, B), X = A.` — what does this mean?
4. `?- loves(X, X) = loves(a, b).`
5. `?- loves(X, Y) = loves(a, b), X = Y.`

## Recap

* `=` is **unification**, not assignment.
* `==` is strict equality (both sides already bound, same value).
* Unification binds variables to make both sides identical.
* Compound terms must match in functor/arity, then unify arguments.
* Prolog uses unification **constantly** — head matching, body goals, `=`
  goals.
* Beware: no occurs check by default — `X = f(X)` succeeds.

Next: **[Recursion](06_recursion.md)** — Prolog's only loop.