# Tutorial Index

Welcome to the **Prolog Tutorial**. This is a slow-paced, beginner-friendly
course that explains *every* important Prolog word and idea. By the end you
will be able to read, write, and debug small Prolog programs confidently.

## Who is this for?

You, if:

* You have **never** written a Prolog program before.
* You have tried reading someone else's Prolog and the code looked alien.
* You understand basic programming concepts (variables, functions, recursion)
  in any language: Python, Java, C, JavaScript, etc.
* You are willing to **type code yourself** — Prolog cannot be learned by
  just reading.

If you already know Prolog, the **[Glossary](99_glossary.md)** is the most
useful page — it is a one-line definition of every term.

## How to use this tutorial

1. **Install SWI-Prolog** (see the project [README](../README.md)).
2. **Open a terminal**, type `swipl` to start the REPL.
3. Read a chapter.
4. **Type every example yourself** — really type it, do not copy-paste.
5. After each chapter, do the "Try it yourself" exercise.
6. If something does not behave the way the book says, type `trace.` and
   re-run the query. (See [chapter 12](12_tracing.md).)

Each chapter is short (5–10 minutes). Do not skip ahead — later chapters
assume you read earlier ones.

## Reading order

| #  | Chapter | Time |
| -- | ------- | ---- |
| 01 | [Facts](01_facts.md) | 5 min |
| 02 | [Rules](02_rules.md) | 7 min |
| 03 | [Queries](03_queries.md) | 5 min |
| 04 | [Variables](04_variables.md) | 7 min |
| 05 | [Unification](05_unification.md) | 10 min |
| 06 | [Recursion](06_recursion.md) | 10 min |
| 07 | [Lists](07_lists.md) | 12 min |
| 08 | [Pattern Matching](08_pattern_matching.md) | 7 min |
| 09 | [Arithmetic](09_arithmetic.md) | 7 min |
| 10 | [Cut & Negation](10_cut_and_negation.md) | 10 min |
| 11 | [Backtracking](11_backtracking.md) | 8 min |
| 12 | [Tracing](12_tracing.md) | 12 min |
| 99 | [Glossary](99_glossary.md) | reference |

Total: about 90 minutes from zero to confident beginner.

## Conventions used in this tutorial

* Code blocks are Prolog unless they start with `?$` (Linux shell) or `cmd>`
  (Windows shell).
* `?-` is the REPL prompt — lines after it are typed by you, not printed
  by Prolog.
* Variables always start with a **capital letter** or `_`. Lower-case atoms
  start with a lower-case letter.
* Comments start with `%` and run to the end of the line.

## Where to go if you are stuck

1. Re-read the chapter — most "bugs" are misunderstandings.
2. Open the REPL, type the failing example **one piece at a time**, and watch
   the answers.
3. Read [Tracing](12_tracing.md) — the tracer will tell you exactly what
   Prolog is doing.
4. Read the [Glossary](99_glossary.md) — the term you don't know is probably
   defined there.

Happy hacking.