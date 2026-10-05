# Glossary — Prolog Terminology

> Quick lookup of every important term. Click the chapter link for an
> in-depth explanation.

## A

* **Anonymous variable** (`_`) — A placeholder for a value you don't care
  about. Each `_` is a different variable. (See [chapter 4](04_variables.md).)
* **Argument** — A value passed to a predicate inside the parentheses.
  `parent(john, mary)` has arguments `john` and `mary`.
* **Arity** — The number of arguments a predicate takes. `parent/2` has
  arity 2.
* **Atom** — A literal symbol starting with a lower-case letter (e.g.
  `john`, `apple`). Immutable.

## B

* **Backtracking** — When Prolog undoes the most recent goal to try another
  alternative. (See [chapter 11](11_backtracking.md).)
* **Base case** — The clause that stops recursion. Usually a fact.
* **Body** — The goals to the right of `:-` in a rule.
* **Bound** — A variable that has been given a value.
* **Breakpoint** — A line in the source code where the tracer pauses.
* **Built-in predicate** — A predicate that comes with SWI-Prolog, written
  in C, not Prolog (e.g. `write/1`, `nl`, `format/2`).

## C

* **Clause** — A fact or a rule.
* **Closed World Assumption** — Everything Prolog can't prove is
  considered false.
* **Compound term** — A term with a functor and arguments, e.g.
  `parent(john, mary)`.
* **Conjunction** — Goals joined by `,` (AND).
* **Consult** — `consult(file).` or `[file].` — load a file into memory.
* **Cut** (`!`) — Prunes the search tree to its left. (See [chapter 10](10_cut_and_negation.md).)

## D

* **DCG** — Definite Clause Grammar. A Prolog syntax for parsing.
* **Declarative** — Saying *what* is true, not *how* to compute it.
* **Disjunction** — Goals joined by `;` (OR).
* **Deterministic** — A predicate that has at most one solution.

## E

* **Exit** — One of the four tracer ports: goal succeeded.
* **Expression** — An arithmetic term to be passed to `is/2`.

## F

* **Fact** — A statement of truth. `parent(john, mary).` (See [chapter 1](01_facts.md).)
* **Fail** — One of the four tracer ports: goal failed.
* **Free variable** — An unbound variable.
* **Functor** — The name + arity of a compound term. `parent/2` has
  functor `parent` and arity 2.

## G

* **Goal** — A query, a fact, or a sub-goal in a rule body that Prolog tries
  to prove.
* **Ground** — A term containing no unbound variables.

## H

* **Head** — The left side of a rule (the part before `:-`).

## I

* **If-then-else** — `Cond -> Then ; Else`.
* **Indexing** — Prolog's optimisation that jumps directly to clauses with
  matching heads.
* **Instantiation** — Binding a variable to a value.
* **Interpreter** — The REPL where you type `?-` queries.

## L

* **Last Call Optimisation** — Prolog reuses stack frames when the
  recursive call is the **last** in the clause, enabling true iteration.
* **Leap** (`l`) — Tracer command: finish this goal.
* **List** — `[]` or `[H|T]`. (See [chapter 7](07_lists.md).)

## M

* **Member** — `member(X, L)` — X is an element of L.
* **Module** — A namespace for predicates, imported with `use_module/1`.
* **Mode** — How a predicate's arguments are typically bound:
  `+` (input), `-` (output), `?` (either). E.g. `length(+, -)`.

## N

* **Negation as failure** (`\+`) — Succeeds iff the goal cannot be proven.
  (See [chapter 10](10_cut_and_negation.md).)
* **Neck** — The `:-` in a rule.
* **Nondeterministic** — A predicate that can have multiple solutions.

## O

* **Occurs check** — Safety check that prevents `X = f(X)`. Off by default
  in SWI-Prolog.

## P

* **Pattern matching** — Unification applied to structured terms.
  (See [chapter 8](08_pattern_matching.md).)
* **Pipe** (`|`) — Splits a list into head and tail: `[H|T]`.
* **Predicate** — A name + arity that defines a relation.
* **Predicate indicator** — `Name/Arity`, e.g. `parent/2`.

## Q

* **Query** — A goal typed at `?-`. (See [chapter 3](03_queries.md).)

## R

* **REPL** — Read-Eval-Print Loop. The interactive Prolog prompt.
* **Recursion** — A predicate that calls itself with smaller input.
  (See [chapter 6](06_recursion.md).)
* **Recursive case** — The clause of a recursive predicate that does the
  recursive call.
* **Redo** — One of the four tracer ports: trying another alternative.
* **Rule** — A clause that defines a head from a body. (See [chapter 2](02_rules.md).)

## S

* **Singleton variable** — A variable that appears only once in a clause
  (a warning).
* **Skip** (`s`) — Tracer command: don't enter this goal.
* **Spy point** — `spy(P/N).` — debugger breaks only on `P/N`.
* **SWI-Prolog** — The most popular, free, open-source Prolog
  implementation. From the University of Amsterdam.

## T

* **Tail-recursive** — A recursive call that is the **last** goal in a
  clause. Optimised automatically.
* **Term** — Anything in Prolog: atom, number, variable, or compound term.
* **Trace** — `trace.` — turn on the step-by-step debugger.
* **Tracer** — The debugger itself. (See [chapter 12](12_tracing.md).)

## U

* **Unbound** — A variable without a value yet.
* **Unification** — Making two terms equal by binding variables.
  (See [chapter 5](05_unification.md).)
* **Univ** (`=..`) — Convert between a term and a list: `foo(a,b) =.. [foo,a,b]`.

## V

* **Variable** — A placeholder starting with a capital letter. (See
  [chapter 4](04_variables.md).)

## Operators quick reference

| Operator | Meaning |
| ---------- | --------- |
| `,`        | AND (conjunction) |
| `;`        | OR (disjunction) |
| `:-`       | if (rule neck, also goal separator in `?-`) |
| `?`        | query |
| `=`        | unify |
| `\=`       | not unifiable |
| `==`       | strictly equal |
| `\==`      | not strictly equal |
| `=:=`      | numerically equal |
| `=\=`      | numerically unequal |
| `is`       | arithmetic evaluate |
| `<`, `=<`, `>`, `>=` | comparisons |
| `\+`       | negation as failure |
| `!`        | cut |
| `->`       | if-then |
| `;`        | else (after `->`) |
| `\|`       | list cons |
| `=..`      | univ |
| `\+`       | not |

## Useful built-ins

| Built-in | Purpose |
| -------- | ------- |
| `consult(File).` / `[File].` | Load a file |
| `listing.` | List all in-memory predicates |
| `listing(P/N).` | List a specific predicate |
| `halt.` | Exit |
| `trace.` / `notrace.` | Toggle tracer |
| `gtrace.` / `nogtrace.` | Toggle graphical tracer |
| `spy(P/N).` / `nospy(P/N).` | Set / remove spy |
| `debug.` / `nodebug.` | Toggle debugging mode |
| `assert(Fact).` | Add a fact at runtime |
| `retract(Fact).` | Remove a fact at runtime |
| `findall(T, G, L).` | Collect all solutions |
| `bagof(T, G, L).` | Collect solutions grouped |
| `setof(T, G, L).` | Sorted, unique solutions |
| `between(L, U, X).` | X is between L and U |
| `length(L, N).` | Length of a list |
| `append(L1, L2, L3).` | Concatenate lists |
| `member(X, L).` | Membership |
| `write(X).` / `writeln(X).` | Output |
| `format(~w, [Args]).` | Formatted output |
| `read(X).` | Read a term from input |
| `nl.` | Newline |
| `atom_chars(A, Cs).` | Atom ↔ list of chars |
| `string_codes(S, Cs).` | String ↔ list of codes |
| `succ(N, M).` | M = N + 1 |
| `random(R).` | Random float 0..1 |
| `use_module(library(Lib)).` | Import a library |

## File extensions

| Extension | Used for |
| --------- | -------- |
| `.pl`     | Prolog source code |
| `.plt`    | Prolog test cases |
| `.pro`    | Prolog source code (less common) |

## REPL shortcuts

| Key | Action |
| --- | ------ |
| `Ctrl-D` | Exit (also `halt.`) |
| `Ctrl-Up` | Previous command |
| `Tab` | Predicate-name completion |
| `Ctrl-C` | Abort current goal |

---

That's the glossary! Revisit any chapter for depth:

* **[Index](00_index.md)**
* **[Tracing](12_tracing.md)** for when things go wrong.
* **[Backtracking](11_backtracking.md)** to understand enumeration.