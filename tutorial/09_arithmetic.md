# Chapter 9 — Arithmetic

> Prolog is symbolic at heart, but it can do math. You have to **ask for it
> explicitly** with `is/2`.

## The trap with `=`

Most beginners expect this to work:

```prolog
?- X = 1 + 3.
X = 1 + 3.            % X is the term "1 + 3", not 4
```

That is because `1 + 3` is just a Prolog **term** (functor `+`, arity 2).
Unification binds `X` to that compound term.

To **evaluate** it, use `is/2`:

```prolog
?- X is 1 + 3.
X = 4 .
```

`is` evaluates the **right side** and unifies the result with the left
side.

## `is/2` syntax

```
Left is Right
```

* `Left` must be a **variable** (or a pattern that can be unified with a
  number).
* `Right` must be an **arithmetic expression** that evaluates to a number.

```prolog
?- X is 5 * 3 + 1.
X = 16 .                          % standard precedence

?- X is (5 * 3) + 1.
X = 16 .

?- X is 5 * (3 + 1).
X = 20 .
```

## Built-in arithmetic operators

| Op | Meaning        |
| -- | -------------- |
| `+`  | addition       |
| `-`  | subtraction    |
| `*`  | multiplication |
| `/`  | division (float if non-exact) |
| `//` | integer division |
| `mod` | modulo (same sign as divisor) |
| `rem` | remainder (same sign as dividend) |
| `**` or `^` | power (in SWI-Prolog) |
| `abs/1` | absolute value |
| `max/2`, `min/2` | maximum / minimum |
| `sqrt/1` | square root |
| `sin/1`, `cos/1`, `log/1`, etc. | math |
| `random/1` | random float 0..1 |
| `succ/1` | successor (`succ(2, 3)`) |

```prolog
?- X is 10 // 3.
X = 3 .                            % integer division

?- X is 10 mod 3.
X = 1 .

?- X is abs(-5).
X = 5 .

?- X is max(3, 7).
X = 7 .
```

## Comparisons

Comparisons in Prolog also need **evaluated** operands. There are two
flavours:

### Symbolically unifiable comparisons

| Op | Meaning         |
| -- | --------------- |
| `=`  | unifiable with  |
| `\=` | not unifiable with |
| `==` | strictly equal (both already bound) |
| `\==` | not strictly equal |
| `=:=` | numerically equal |
| `=\=` | numerically unequal |
| `<`    | less than       |
| `=<`   | less than or equal |
| `>`    | greater than    |
| `>=`   | greater than or equal |

The confusing pair:

```prolog
?- 1 + 1 =:= 2.
true.                             % numeric equality

?- 1 + 1 = 2.
false.                            % unification: 1+1 ≠ 2
```

### Tricky difference

```prolog
?- 1 + 2 = 3.
false.

?- 1 + 2 =:= 3.
true.
```

`=` tries to unify the **terms** `1+2` and `3`. They are different
compound terms. `=:=` **evaluates both** then compares.

## Variables on the right side of `is`

The variables must already be bound:

```prolog
?- X is Y + 1.       % Y unbound → INSTANTIATION ERROR
ERROR: Arguments are not sufficiently instantiated

?- Y = 5, X is Y + 1.
X = 6 .
```

## Variables on the left of comparisons

Most comparisons require **either side** to be ground (or both):

```prolog
?- X < 10.
ERROR: Arguments are not sufficiently instantiated
```

Use `between/3` to enumerate:

```prolog
?- between(1, 5, X).
X = 1 ;
X = 2 ;
X = 3 ;
X = 4 ;
X = 5 .
```

## A working example

```prolog
fact(0, 1) :- !.
fact(N, F) :- N > 0, N1 is N - 1, fact(N1, F1), F is N * F1.
```

```prolog
?- fact(6, X).
X = 720 .
```

## Try it yourself

Predict each answer, then check:

1. `?- X is 7 + 3 * 2.`
2. `?- X is (7 + 3) * 2.`
3. `?- 5 + 5 = 10.`
4. `?- 5 + 5 =:= 10.`
5. `?- X is 10 mod 4.`
6. `?- X is sqrt(16).`

Then write a predicate `triples(A, B, C)` that succeeds when A² + B² = C²
(Pythagorean triple), using `is` and `=:=`:

```prolog
triples(A, B, C) :- between(1, 20, A), between(1, 20, B), C2 is A*A + B*B, C is sqrt(C2), C2 =:= C*C.
```

You will need to use `truncate` or integer arithmetic to get integer
results cleanly. Don't worry if it takes a few tries.

## Recap

* `=` is unification; `is/2` evaluates.
* Comparison operators: `=:=`, `=\=`, `<`, `=<`, `>`, `>=` evaluate.
* `=` and `==` are structural / unification.
* All arithmetic requires variables to be **already bound**.
* Use `between/3` to enumerate integers in a range.

Next: **[Cut & Negation](10_cut_and_negation.md)** — controlling the search.