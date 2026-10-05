# Chapter 1 — Facts

> The smallest, simplest Prolog program is just a list of **facts**.

## What is a fact?

A **fact** is a statement that something is true. In Prolog, a fact is
written as:

```
predicate(argument1, argument2, ...).
```

* It must end with a **dot** (`.`).
* The thing before the parentheses is called the **predicate name** (a
  function name, if you like Python).
* The things inside the parentheses are the **arguments**.

The number of arguments is called the **arity**. `parent(john, mary)` has
arity 2. Prolog calls this `parent/2`.

## Example: a tiny family tree

```prolog
% parent(Parent, Child)
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(tom, lily).
```

Each line says: "X is the parent of Y". That's it.

## Atoms vs numbers

The arguments you see (`john`, `mary`, `tom`, `ann`, `lily`) are
**atoms** — names that start with a *lower-case* letter. Atoms are like
string literals in other languages: immutable symbols.

You can also use **numbers**:

```prolog
age(john, 42).
age(mary, 38).
height(john, 1.85).      % decimals work too
```

And **strings** (between double quotes):

```prolog
country("India").
country("Japan").
```

(Strings are usually used for output. Use atoms for symbolic data.)

## Reading a fact

> `parent(john, mary).`

Read aloud: **"John is the parent of mary."** Or: *"*parent* of john and mary
is a thing that exists."* Prolog does not care about English order — but it
is on you to pick an order and **stay consistent**. In `parent/2` I picked
*first argument = parent, second = child*. Once you pick, don't mix.

## Adding a few more facts

```prolog
male(john).
male(tom).
female(mary).
female(ann).
female(lily).
```

These are facts about a *one-argument* predicate. `male/1`, `female/1`.

## Running the example

Save the file as `family.pl`, then in the REPL:

```prolog
?- [family].
true.

?- parent(john, mary).
true.

?- parent(mary, john).
false.
```

The second query is `false` because we only asserted that **john is the
parent of mary**, not the reverse.

## Things that are NOT facts

| Try to write…     | Why it fails                                |
| ---------------- | ------------------------------------------ |
| `Parent(john).`  | `Parent` is a variable, not a predicate. Variables are placeholders, not facts. |
| `parent(john).`  | Wrong arity — `parent/1` was never defined. |
| `parent(john,mary)` (no dot) | Prolog reads the next line as part of this fact. |
| `parent(john mary).` | Comma/space missing between arguments.  |

## Comments

Comments start with `%` and run to the end of the line. They are for
humans only — Prolog ignores them.

```prolog
% this is a comment
parent(john, mary).    % inline comment after a fact is fine
```

For block comments use `/* ... */`:

```prolog
/*
   Family tree:
     john  -> mary -> ann
     john  -> tom  -> lily
*/
```

## Try it yourself

1. Make a new file called `pets.pl`.
2. Write 5 facts about pets, e.g.

   ```prolog
   pet(cat, luna).
   pet(dog, rex).
   ...
   ```

3. In the REPL, type `[pets].` to load it.
4. Ask `?- pet(cat, X).` — what do you get?

If `X` is printed as `_G123` instead of the name, you probably typed a
capital letter where you meant lower case. Re-read the
[Variables chapter](04_variables.md) when you get there.

## Recap

* A **fact** declares something true. Format: `name(arg1, arg2, ...).`
* **Atoms** start with a lower-case letter. **Numbers** are numbers.
  **Strings** are in `"..."`.
* The **arity** is the number of arguments.
* Comments start with `%`.
* Save your program to a file, load it with `[file].` or `consult(file).`.

Next: **[Rules](02_rules.md)** — teaching Prolog to *derive* new truths.