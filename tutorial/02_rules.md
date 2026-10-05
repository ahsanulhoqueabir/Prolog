# Chapter 2 — Rules

> A **rule** says: "this is true **if** that is true."

## From facts to rules

In [chapter 1](01_facts.md) we wrote facts like:

```prolog
parent(john, mary).
male(john).
```

Now suppose you want to know who is a **father**. We could write a fact for
each father:

```prolog
father(john, mary).
father(john, tom).
```

…but that is tedious and easy to forget. Instead, we *define* what it means
to be a father:

```prolog
father(X, Y) :- parent(X, Y), male(X).
```

Read it as:* **"X is the father of Y *if* X is a parent of Y *and* X is male."*

## Anatomy of a rule

```
father(X, Y) :- parent(X, Y), male(X).
^^^^^^^^^^^   ^^  ^^^^^^^^^^^^^^  ^^^^^^
   head      neck  body / goals (conjunction)
```

* **Head** — the thing we are defining. Same form as a fact, but with
  variables (`X`, `Y`).
* **`:-`** — pronounced "if". The neck of the rule.
* **Body** — the goals that must be proved for the head to be true.
  Goals are joined by commas (`,`) meaning *AND* — all must succeed.

A rule with an empty body (`head.`) is a fact.

## Variables in rules

`X` and `Y` are **uppercase** — that means they are **variables**. They
don't have values yet; they are *placeholders* that get bound (filled in)
when Prolog tries to prove the rule.

When you ask Prolog: *"`father(john, Who)`?"*, it tries to find a value of
`Who` for which `father(john, Who)` is true. It plugs `X = john` into the
rule, then tries to prove both goals:

```
parent(john, Who)        % need this to be true
male(john)              % and this
```

If both succeed, then `Who` is the answer.

## Example: full family file

```prolog
% facts
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(tom, lily).

male(john).
male(tom).
female(mary).
female(ann).
female(lily).

% rules
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

% two ways to be a sibling
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.
```

Try in the REPL:

```prolog
?- [family].
true.

?- father(john, Who).
Who = mary ;
Who = tom .

?- grandparent(john, Who).
Who = ann ;
Who = lily .
```

The `;` (semicolon) asks for the next solution. Press `.` (period) or
`Enter` to stop.

## Multiple rules = multiple ways

The same predicate can be defined by **more than one rule**. Prolog tries
them in order; the first that succeeds is the answer.

```prolog
ancestor(X, Y) :- parent(X, Y).                  % base case
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).  % recursive case
```

Here, `ancestor/2` is true if `X` is a parent of `Y` **OR** if `X` is a
parent of someone `Z` who is an ancestor of `Y`. That is how we define
"any number of generations" without writing a fact for each.

## Order of rules matters

```prolog
adult(X) :- age(X, A), A >= 18.   % A is unknown — Prolog fails here
adult(X) :- age(X, A), A > 17.    % same problem
```

Because A is "unknown" until proven, `>=` and `>` need `A` to be **already
bound to a number** (see [Arithmetic](09_arithmetic.md)). The order of
rules is fine here — both have the same problem. Order matters more in
recursive rules: the **base case should come first** so Prolog doesn't
loop forever.

## Common mistakes

| Mistake | Symptom |
| ------- | ------- |
| Forgetting the dot          | Next line silently becomes part of the rule body |
| Using `=` instead of `:-` | Prolog asks if you mean `:-` and refuses to compile |
| `:-` at the start (no head) | Syntax error — every rule needs a head |
| Comma in the wrong place  | Comma separates **goals**, not arguments |

## Try it yourself

1. Add a rule `happy(X) :- X = mary.` — does it work? Why does Prolog
   accept the equals sign?
2. Write a rule `cousin(X, Y)` for the family above. *Hint: two people are
   cousins if their parents are siblings.*
3. Use `listing.` in the REPL to see all predicates currently in memory.

## Recap

* A **rule** is a way to define new predicates from existing ones.
* Format: `head :- body1, body2, ...`.
* `,` means AND (all goals must succeed).
* A predicate can have **many rules**; Prolog tries each in turn.
* Variables start with a capital letter.

Next: **[Queries](03_queries.md)** — asking Prolog questions.