# Chapter 3 — Queries

> A **query** is a question you ask the Prolog interpreter.

## What is a query?

A query is just a **goal** you type at the `?-` prompt. Prolog's job is to
find values of the variables (if any) that make the goal true. The REPL
prints those values, or `true` (if there are no variables), or `false`
(if no solution exists).

## Three kinds of queries

### 1. Yes/no query

```prolog
?- parent(john, mary).
true.
```

Is "john is the parent of mary" true? Prolog scans the database of facts
and rules and reports back.

### 2. Value-producing query (one variable)

```prolog
?- parent(john, Who).
Who = mary ;
Who = tom .
```

"Find me a `Who` such that `parent(john, Who)` is true."

Prolog found *two* solutions. The `;` tells Prolog to look for the next
one. Type `.` to stop.

### 3. Value-producing query (many variables)

```prolog
?- parent(Parent, Child).
Parent = john, Child = mary ;
Parent = john, Child = tom ;
Parent = mary, Child = ann ;
Parent = tom,  Child = lily .
```

Two variables are filled in for each solution.

## Conjunctive queries

You can ask multiple questions in one go, joined by `,` (AND) or `;` (OR):

```prolog
?- parent(john, mary), parent(tom, lily).     % both must hold
true.

?- parent(john, X) ; parent(tom, X).           % either must hold
X = mary ;
X = tom ;
X = lily .
```

The full operator table:

| Operator | Meaning in queries          |
| -------- | --------------------------- |
| `,`      | AND (conjunction)           |
| `;`      | OR (disjunction)            |
| `\=`     | not equal                   |
| `=`      | unifiable with              |
| `\+`     | negation as failure (NOT)   |
| `->`     | if-then                     |

(Each of these gets its own chapter later.)

## Useful top-level commands

While in the REPL, you can also type commands that are not "goals" per se:

| Command        | What it does                                 |
| -------------- | -------------------------------------------- |
| `listing.`     | show every predicate currently in memory     |
| `help.`        | open the built-in help browser               |
| `halt.`        | exit SWI-Prolog                              |
| `trace.`       | turn on the tracer (see [chapter 12](12_tracing.md)) |
| `notrace.`     | turn tracing off                             |
| `[file].`      | load a file (same as `consult(file)`)        |
| `make.`        | re-load any changed files                    |

## Anatomy of a query session

```
?- [family].                % load file
true.

?- parent(john, X).         % ask a question
X = mary ;                  % solution 1
X = tom .                   % solution 2 (`.` stops)

?- listing(parent).
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(tom, lily).

true.
```

## Where to put a query

You can put a query **in a file** too, as a directive:

```prolog
:- initialization(main).
main :-
    parent(john, Who),
    format('John is parent of ~w~n', [Who]),
    fail.                    % force backtracking to print all
```

Or even simpler with `?-` at the top of a file:

```prolog
?- parent(john, X), write(X), nl.
```

A query at the top of a file is run when the file is consulted.

## Common errors when querying

| What you type         | What happens |
| -------------------- | ------------ |
| `?` (no dash)        | Syntax error — it must be `?-` |
| `parent(john, who).` | `who` is an atom, not a variable. Variables **start with capital letter**. |
| `parent(john X).`    | Comma missing between args. |
| Missing `.` at end   | Prolog waits for more input (cursor on a new line). Type `.` then Enter. |

## Try it yourself

For the `family.pl` file from the previous chapters, try these queries and
predict the answer **before** you type them:

1. `?- male(john).`
2. `?- female(tom).`
3. `?- parent(Who, lily).`
4. `?- mother(mary, ann).`
5. `?- grandparent(tom, Who).`
6. `?- father(Who, ann), father(Who2, lily).`

For #6, what does the comma mean? Did the answer match your intuition?

## Recap

* A **query** is a goal asked at the `?-` prompt.
* Prolog returns `true` / `false` or one or more variable bindings.
* `;` (semicolon) asks for the next solution; `.` stops.
* Top-level commands like `listing.`, `trace.`, `halt.` are typed as
  queries but are not really "questions".
* You can put queries in a file using `?-` or `:- initialization`.

Next: **[Variables](04_variables.md)** — what those uppercase letters
actually mean.