# Chapter 4 — Variables

> A variable is a **placeholder for a value Prolog will figure out**.

## Two simple rules

1. Anything starting with a **capital letter** (or `_`) is a variable.
2. Anything starting with a **lower-case letter** is an **atom** (a literal
   symbol).

```prolog
?- parent(john, Who).
```

Here `john` is an atom (literal value). `Who` is a variable (something to
be solved for).

## Variables get bound, not assigned

In most programming languages you assign a value to a variable:

```python
x = 5        # Python assigns 5 to x
```

Prolog **binds** them. When Prolog proves a goal, the variable gets "filled
in" with whatever value made the goal succeed.

```prolog
?- parent(john, X).
X = mary ;        % X is now bound to mary
X = tom .         % X is now bound to tom
```

A variable can only be bound **once** within a clause's execution. If Prolog
needs a different value, it has to **backtrack** (see chapter 11) and
re-bind.

## Anonymous variables: `_`

Sometimes you don't care about a value. Use `_` (underscore):

```prolog
?- parent(_, _).
true.                              % some parent exists

?- parent(john, _).
true.                              % john is a parent
```

Each `_` is a **different** variable — Prolog does not unify them.

> **Tip:** `_Name` (e.g. `_X`) is also a variable, but `Name` does not
> count toward singleton-variable warnings.

## Variables must match the same name

In a clause, the *same name means the same variable*:

```prolog
same(X, X).                  % two arguments must be the SAME value
notsame(X, Y) :- X \= Y.     % two arguments must be DIFFERENT values
```

```prolog
?- same(food, food).
true.

?- same(food, wine).
false.

?- same(X, food).
X = food .                   % both X's get unified
```

## Singleton variables

If a variable appears only **once** in a clause, Prolog warns you:

```
Warning: singleton variables in [...]
```

Either:

* you made a typo (e.g. `X` in one place, `Y` in another),
* you forgot to use the variable,
* you really do want an anonymous variable — use `_`.

```prolog
male(X).              % OK — uses X once but X IS used
                      % (Prolog would warn here actually)
male(X) :- human(X).  % X used twice, no warning
male(_).              % OK — anonymous, no warning
```

To silence warnings without changing meaning, prefix with `_`:

```prolog
male(_X).             % use _X — same as _ but no warning
```

## Variables flow across goals

```prolog
?- parent(john, X), parent(X, Y).
X = mary,    Y = ann ;
X = tom,     Y = lily .
```

1. `parent(john, X)` finds `X = mary`.
2. `parent(X, Y)` is now `parent(mary, Y)` — it searches again, using the
   already-bound `X`.
3. `parent(mary, ann)` succeeds → `Y = ann`.
4. Press `;` and Prolog backtracks to find more.

This is the most important Prolog pattern: a variable **flowing through a
chain of goals**.

## Common mistakes

| Mistake                                | What happens                        |
| -------------------------------------- | ----------------------------------- |
| `parent(john, x).`                     | `x` is an atom, not a variable.     |
| `parent(john, x_var).`                 | Same.                               |
| `Parent = john, parent(Parent, X).`    | First line uses `=` to *test*, then `Parent` flows into the next goal. |
| Reassigning: `X = a, X = b.`           | The second `=` fails — `X` is already bound to `a`. |

## Try it yourself

Given:

```prolog
likes(mary, food).
likes(mary, wine).
likes(john, wine).
likes(john, mary).
```

Predict the answer to each, then check:

1. `?- likes(mary, X).`
2. `?- likes(Who, wine).`
3. `?- likes(Who1, Who2).`
4. `?- likes(mary, X), likes(john, X).`
5. `?- likes(X, Y), likes(X, Z), Y \= Z.`

For #5, you have discovered the "jealous" pattern from the README!

## Recap

* **Variables** start with a capital letter or `_`.
* Prolog **binds** them as it goes.
* A variable can only be bound once per proof attempt.
* `_` is the **anonymous variable** — use it when you don't care.
* Variables in the same clause with the same name refer to the same value.
* The most useful pattern: a variable flowing across multiple goals.

Next: **[Unification](05_unification.md)** — what `=` actually does.