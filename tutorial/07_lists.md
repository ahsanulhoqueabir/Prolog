# Chapter 7 — Lists

> The list is the only built-in data structure you need. It is a recursive
> structure, and almost every program uses it.

## What is a Prolog list?

A list is either:

* the empty list `[]`, or
* a **cons cell** `[Head | Tail]`, where `Head` is one item and `Tail` is
  another (shorter) list.

Examples:

```prolog
[]                              % empty list
[a]                             % one item
[a, b, c]                       % three items
[H | T]                         % head H, tail T  (T is a list)
[1, 2, 3 | T]                   % head 1,2,3 then tail T
```

## The pipe `|`

The pipe splits a list into a head and a tail:

```prolog
?- [a, b, c] = [H | T].
H = a, T = [b, c].

?- [a, b, c] = [H1, H2 | T].
H1 = a, H2 = b, T = [c].

?- [a] = [H | T].
H = a, T = [].
```

You can put any number of items before the `|`, but the part after **must
be a list**.

## Building lists

```prolog
?- L = [a, b, c].
L = [a, b, c].

?- L = [1, 2 | [3, 4]].
L = [1, 2, 3, 4].
```

`|` is **right-associative**, so `[1, 2, 3 | []]` is the same as
`[1 | [2 | [3 | []]]]`.

## The empty list `[]`

`[]` is the only list of length zero. It is the **base case** for nearly
every recursive list predicate.

```prolog
?- [] = [].
true.

?- [] = [H | T].
false.
```

You cannot unify `[]` with a non-empty list, because there is no head to
extract.

## Recursion over lists

The pattern is always the same:

```prolog
my_list_pred([], base_result).
my_list_pred([H|T], Result) :- my_list_pred(T, R1), ..., Result = ...
```

### Example: list length

```prolog
length([], 0).
length([_|T], N) :- length(T, N1), N is N1 + 1.
```

```prolog
?- length([a, b, c, d], X).
X = 4 .
```

### Example: list sum

```prolog
sum([], 0).
sum([H|T], S) :- sum(T, S1), S is H + S1.
```

```prolog
?- sum([1, 2, 3, 4, 5], X).
X = 15 .
```

### Example: member

```prolog
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
```

"Is X a member of the list?" Try:

```prolog
?- member(b, [a, b, c]).
true.

?- member(X, [a, b, c]).
X = a ;
X = b ;
X = c .
```

This shows how a predicate can be used in **both directions** — to check
or to enumerate.

### Example: append

```prolog
append([], L, L).
append([H|T], L2, [H|L3]) :- append(T, L2, L3).
```

```prolog
?- append([1, 2], [3, 4], X).
X = [1, 2, 3, 4].

?- append(X, [3, 4], [1, 2, 3, 4]).
X = [1, 2].

?- append([1,2], X, [1, 2, 3, 4]).
X = [3, 4].
```

Three queries, three different uses of the same definition. This is the
**relational** nature of Prolog — predicates are equations, not functions.

### Example: reverse

Naive version:

```prolog
reverse([], []).
reverse([H|T], R) :- reverse(T, R1), append(R1, [H], R).
```

```prolog
?- reverse([a, b, c], X).
X = [c, b, a] .
```

This is O(n²) — append is O(n) and we do it n times. The tail-recursive
version with an accumulator is O(n):

```prolog
reverse(L, R) :- reverse_acc(L, [], R).
reverse_acc([], Acc, Acc).
reverse_acc([H|T], Acc, R) :- reverse_acc(T, [H|Acc], R).
```

## Strings as lists of codes

In SWI-Prolog, a `"string"` is actually a list of character codes:

```prolog
?- "abc" = [a, b, c].
false.                       % because "abc" is [97, 98, 99]
?- "abc" = [97, 98, 99].
true.
```

To convert, use `atom_chars/2` or `string_codes/2`:

```prolog
?- atom_chars(hello, X).
X = [h, e, l, l, o].
```

But for most beginner code, you don't need this — just use atoms or numbers.

## Common list mistakes

| Mistake                          | Result                              |
| -------------------------------- | ----------------------------------- |
| `[H|T] = []`                     | fails (no head in empty list)       |
| `T = [1, 2]` so `[H|T] = [1,2]`  | H = 1, T = [2] ✓                    |
| `[H|T] = [1]`                    | H = 1, T = [] ✓                    |
| `[H,T] = [1]`                    | fails — two heads but one element   |
| `|` on the left only             | fails — `[H|T]` must be a single term on left |

## Try it yourself

For each, predict the answer first:

1. `[1,2,3] = [H|T].` — H? T?
2. `[1,2,3] = [H1,H2|T].`
3. `[1,2,3] = [H1,H2,H3,H4|T].`
4. `[X|Y] = [a|[b,c]]` — X? Y?
5. Write `last(L, X)` — X is the last element of L. Use recursion.

Then write a tail-recursive `max_list/2` — the largest element of a list
(0 if empty).

## Recap

* A list is `[]` or `[H | T]`. Always.
* `|` separates head from tail. The tail must be a list.
* Almost every list predicate has two clauses: empty + non-empty.
* `member/2` and `append/3` are workhorse predicates you will use daily.
* Lists can be matched, taken apart, built up — and the same predicate can
  do all three.

Next: **[Pattern Matching](08_pattern_matching.md)** — going deeper on
matching.