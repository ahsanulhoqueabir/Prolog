# Prolog Learning Hub

Welcome to your **one-stop Prolog learning repository**. This project is designed for
absolute beginners who want to learn **logic programming** using SWI-Prolog — the most
widely used, free, open-source Prolog implementation.

> Prolog is a **declarative** programming language: you describe *what* is true, and
> Prolog figures out *how* to prove it. If you have ever written `if/else` chains or
> SQL `SELECT … WHERE` statements, Prolog will feel both familiar and surprisingly
> powerful.

---

## Table of Contents

1. [What is Prolog?](#1-what-is-prolog)
2. [Why learn Prolog?](#2-why-learn-prolog)
3. [What is in this repository?](#3-what-is-in-this-repository)
4. [Quick Start (60 seconds)](#4-quick-start-60-seconds)
5. [Running Prolog in VS Code](#5-running-prolog-in-vs-code)
6. [Running Prolog from a terminal](#6-running-prolog-from-a-terminal)
7. [Tutorial Folder — Learn Prolog from Scratch](#7-tutorial-folder--learn-prolog-from-scratch)
8. [Lab Folder — 15 Practice Programs](#8-lab-folder--15-practice-programs)
9. [Useful REPL commands](#9-useful-repl-commands)
10. [Tracing & Debugging — The "Process" Section](#10-tracing--debugging--the-process-section)
11. [Project Layout](#11-project-layout)
12. [Troubleshooting](#12-troubleshooting)
13. [Recommended Resources](#13-recommended-resources)

---

## 1. What is Prolog?

Prolog (short for **PROgrammation en LOGique**) was invented in the early 1970s
by Alain Colmerauer and Philippe Roussel in Marseille, France. It is the most
popular language in the **logic programming** family.

A Prolog program is just a set of **facts** and **rules**. You then ask **queries**,
and Prolog's built-in **inference engine** searches for proofs that satisfy them.

A tiny example:

```prolog
% facts
loves(mary, food).
loves(mary, wine).
loves(john, wine).
loves(john, mary).

% a rule
jealous(A, B) :- loves(A, B), loves(A, C), B \= C.
```

Query:

```prolog
?- jealous(john, X).
X = food ;     % other things john loves besides mary
X = wine .
```

Prolog automatically finds every possible `X`. No loops, no iteration, no
`printf` — just logic.

---

## 2. Why learn Prolog?

| Reason | What it teaches you |
| ------ | ------------------- |
| **AI & Knowledge Engineering** | Prolog was the original AI language. Expert systems, natural-language parsing, planning — Prolog excels at all of these. |
| **Search algorithms** | You will re-discover Depth First Search, Recursion, and Backtracking *by using them*. |
| **Declarative thinking** | You stop worrying about *how* and focus on *what* — a skill that improves every other code you write. |
| **Pattern matching & unification** | The same engine that powers Haskell, Erlang, and modern databases — Prolog teaches the foundation. |
| **Constraint solving** | Prolog's search is used in scheduling, configuration, type inference, and theorem provers. |
| **It's different** | Learning Prolog makes you a *better programmer*, period. |

> Coursework tip — this repository is laid out for a typical undergraduate
> "Logic Programming" lab. The 15 programs in `lab6/` cover the classic exercises:
> factorial, sum, list reversal, palindrome, prime, fibonacci, etc., but written
> *declaratively* instead of imperatively.

---

## 3. What is in this repository?

```
Prolog/
├── README.md                       <- you are here
├── first.pl                        <- tiny example: family tree
├── backward.pl / backward.md       <- backward chaining explained
├── lab6/
│   ├── p01_factorial.pl
│   ├── p02_sum_even.pl
│   ├── p03_palindrome.pl
│   ├── p04_max_list.pl
│   ├── p05_list_length.pl
│   ├── p06_reverse_list.pl
│   ├── p07_ancestor_descendant.pl
│   ├── p08_expression_evaluator.pl
│   ├── p09_count_elem.pl
│   ├── p10_find_siblings.pl
│   ├── p11_nth_element.pl
│   ├── p12_sorted.pl
│   ├── p13_is_prime.pl
│   ├── p14_fibonacci.pl
│   ├── p15_uncle_aunt.pl
│   └── Prolog_Lab6_Explained.pdf   <- printable lab guide
├── tutorial/                       <- BEGINNER-FRIENDLY TUTORIALS
│   ├── 00_index.md                 <- start here
│   ├── 01_facts.md
│   ├── 02_rules.md
│   ├── 03_queries.md
│   ├── 04_variables.md
│   ├── 05_unification.md
│   ├── 06_recursion.md
│   ├── 07_lists.md
│   ├── 08_pattern_matching.md
│   ├── 09_arithmetic.md
│   ├── 10_cut_and_negation.md
│   ├── 11_backtracking.md
│   ├── 12_tracing.md
│   └── 99_glossary.md
└── .vscode/                        <- one-click tasks (Ctrl+Shift+B)
```

---

## 4. Quick Start (60 seconds)

1. **Install SWI-Prolog** from <https://www.swi-prolog.org/Download.html>
   (Windows installer puts it at `C:\Program Files\swipl\bin\swipl.exe`,
   already configured in this repo).
2. **Open this folder in VS Code** and install the recommended extension
   *VFX-Prolog* (auto-prompt on first open).
3. **Press `Ctrl+Shift+B`** — SWI-Prolog starts with `first.pl` ready.
5. **Type a query** at the `?-` prompt:

   ```prolog
   ?- parent(john, X).
   X = mary ;
   X = tom .
   ```

   Press `;` for the next solution, `.` to stop.

That's it. You're a Prolog programmer. Now read `tutorial/00_index.md` to
actually understand what just happened.

---

## 5. Running Prolog in VS Code

VS Code is pre-configured with 7 build tasks and 3 debug configurations.

### The fastest path: `Ctrl+Shift+B`

1. Open any `.pl` file.
2. Press `Ctrl+Shift+B`.
3. SWI-Prolog loads the file and drops you at `?-`.
4. Type any query.

### The full task menu

Open the menu with **Terminal → Run Task...** or `Ctrl+Shift+P` then
`Tasks: Run Task`:

| Want to…                                   | Pick this task                                     |
| ------------------------------------------ | -------------------------------------------------- |
| Just open a REPL                           | `SWI-Prolog: Start REPL`                           |
| Load current file + open REPL               | `SWI-Prolog: Run current file`                     |
| Load current file, run a single query, exit | `SWI-Prolog: Run current file + query`             |
| Pick any file + type any query             | `SWI-Prolog: Run query on chosen file`             |
| Load **all 15** lab files                  | `SWI-Prolog: Load all lab6/*.pl files`             |
| Syntax-check current file                  | `SWI-Prolog: Syntax-check current file`            |
| Step through code with the tracer          | (use `F5` → CLI tracer)                            |
| Use the graphical tracer                   | (use `F5` → Graphical tracer)                      |

---

## 6. Running Prolog from a terminal

### cmd.exe

```cmd
prolog                REM -> fresh REPL
prolog first.pl       REM -> load first.pl and open the REPL
run-all-lab6.bat      REM -> load every lab6/*.pl file
```

### PowerShell

```powershell
.\prolog.ps1                                  # fresh REPL
.\prolog.ps1 -File first.pl                   # load file
.\prolog.ps1 -File first.pl -Query "father(john,X)"  # load + run + exit
```

> **Why no `prolog first.pl "father(john,X)"` in cmd?**
> `cmd.exe` splits argument tokens on `(` and `)`, so a quoted query gets
> shredded. PowerShell doesn't have that quirk, which is why the helper
> script accepts `-Query`.

### If `swipl` is not recognized

Run this once to put it on your PATH permanently:

```powershell
powershell -ExecutionPolicy Bypass -File .\add-path-current-user.ps1
```

Close and reopen your terminal — `swipl` and `prolog` now work everywhere.

---

## 7. Tutorial Folder — Learn Prolog from Scratch

If you are a **complete beginner**, start with [`tutorial/00_index.md`](tutorial/00_index.md).
The tutorial is a 13-chapter beginner-friendly course covering every
important term you will encounter in Prolog.

Each chapter is short, has runnable examples, and ends with a "try it yourself"
exercise. Chapters build on each other, so read them in order:

| #  | Chapter                                       | What you will learn |
| -- | --------------------------------------------- | ------------------- |
| 00 | [Index](tutorial/00_index.md)                  | How to use the tutorial |
| 01 | [Facts](tutorial/01_facts.md)                  | The smallest Prolog program |
| 02 | [Rules](tutorial/02_rules.md)                  | Teaching Prolog to reason |
| 03 | [Queries](tutorial/03_queries.md)              | Asking Prolog questions |
| 04 | [Variables](tutorial/04_variables.md)          | Logic variables and `=` |
| 05 | [Unification](tutorial/05_unification.md)      | The heart of Prolog |
| 06 | [Recursion](tutorial/06_recursion.md)          | Loops the Prolog way |
| 07 | [Lists](tutorial/07_lists.md)                  | `[H|T]`, the only data structure you need |
| 08 | [Pattern Matching](tutorial/08_pattern_matching.md) | Decomposing data |
| 09 | [Arithmetic](tutorial/09_arithmetic.md)        | `is/2`, `>/2`, comparisons |
| 10 | [Cut & Negation](tutorial/10_cut_and_negation.md)  | `!`, `\+`, controlling search |
| 11 | [Backtracking](tutorial/11_backtracking.md)    | Why `;` keeps giving answers |
| 12 | [Tracing](tutorial/12_tracing.md)              | Watching Prolog think — the **process** |
| 99 | [Glossary](tutorial/99_glossary.md)           | Quick lookup of every Prolog word you encounter |

---

## 8. Lab Folder — 15 Practice Programs

The `lab6/` folder contains 15 classic Prolog exercises used in many
university courses. Each program is a single self-contained file:

| File | Topic | Difficulty |
| ---- | ----- | ---------- |
| `p01_factorial.pl`          | Recursion | ★☆☆ |
| `p02_sum_even.pl`           | List + arithmetic | ★☆☆ |
| `p03_palindrome.pl`         | Recursion + lists | ★★☆ |
| `p04_max_list.pl`           | List traversal | ★☆☆ |
| `p05_list_length.pl`        | Classic recursive pattern | ★☆☆ |
| `p06_reverse_list.pl`       | Accumulator vs naive | ★★☆ |
| `p07_ancestor_descendant.pl` | Family tree rules | ★★☆ |
| `p08_expression_evaluator.pl` | Recursive descent | ★★★ |
| `p09_count_elem.pl`         | Counting occurrences | ★★☆ |
| `p10_find_siblings.pl`      | Compound conditions | ★★☆ |
| `p11_nth_element.pl`        | Index into a list | ★☆☆ |
| `p12_sorted.pl`             | Generating ordered lists | ★★★ |
| `p13_is_prime.pl`           | Number theory | ★★☆ |
| `p14_fibonacci.pl`          | Naive + memoised | ★★☆ |
| `p15_uncle_aunt.pl`         | Multi-rule family logic | ★★☆ |

`Prolog_Lab6_Explained.pdf` is a printable PDF of the lab sheet for offline study.

To load them all at once:

```cmd
run-all-lab6.bat
```

…or inside the REPL:

```prolog
?- [lab6/p01_factorial].
?- [lab6/p02_sum_even].
... (or use the load-all task)
```

---

## 9. Useful REPL commands

| Command                         | What it does                                        |
| ------------------------------- | --------------------------------------------------- |
| `consult('lab6/p01.pl').`       | (re-)load a file from inside the REPL               |
| `[file].`                       | short form of `consult`                              |
| `listing.`                      | show every predicate currently in memory            |
| `trace.`                        | turn on the step-by-step tracer                     |
| `notrace.`                      | turn tracing off                                    |
| `gtrace.`                       | open the graphical tracer window                    |
| `nodebug.`                      | remove all breakpoints                              |
| `halt.` / `Ctrl-D`              | exit SWI-Prolog                                     |
| `make.`                         | re-consult all files that have changed              |

> Tip: in the REPL, press **`Ctrl-Up`** for command-line history, **`Tab`**
> for predicate-name completion.

---

## 10. Tracing & Debugging — The "Process" Section

> "How do I see what Prolog is actually doing?"

Prolog ships with a built-in **tracer** that shows you the *process* of
proving a query, goal by goal. This is the single most important debugging
skill you will learn — see **[tutorial/12_tracing.md](tutorial/12_tracing.md)**
for a full walkthrough.

### 5-second trace

```prolog
?- trace, parent(john, X).
```

You'll see prompts like:

```
   Call: parent(john, _G123)
   Exit: parent(john, mary)
   X = mary ;
   Redo: parent(john, _G123)
   Exit: parent(john, tom)
   X = tom .
```

The four "ports":

| Port       | Meaning                                          |
| ---------- | ------------------------------------------------ |
| **Call**   | Starting to try a goal                           |
| **Exit**   | Goal succeeded                                   |
| **Redo**   | Going back to look for another way               |
| **Fail**   | Goal failed                                      |

Inside the tracer, single-character commands (no Enter needed):

| Key | Action                                  |
| --- | --------------------------------------- |
| `s` | **s**kip — don't enter this goal        |
| `h` | help                                    |
| `n` |                                         |
| `c` | creep — single step                     |
| `l` | **l**eap — finish this goal             |
| `f` | **f**ail — force this goal to fail      |
| `a` | **a**bort                               |
| `=` | show info                               |

### Graphical tracer

In VS Code, press `F5` → pick **"SWI-Prolog: Trace current file (Graphical tracer)"**.
A separate window opens showing the call tree visually — perfect for
understanding recursion and backtracking.

### Spy points

```prolog
?- spy(parent/2).          % break only on parent/2
?- nospy(parent/2).        % remove spy
?- nospyall.               % remove all spies
```

Spy points are persistent breakpoints that automatically engage the tracer
on matching goals.

### Common debugging recipes

| Symptom                                      | Try                                                  |
| -------------------------------------------- | ---------------------------------------------------- |
| Query loops forever                          | `Ctrl+C` then add a base case / check order of rules |
| Query returns `false.` when it shouldn't    | `trace.` — almost always reveals a typo or wrong var |
| Query returns the wrong variable             | Print intermediate values with `format/2`            |
| "Singleton variable" warning                 | `_Var` (underscore) — see [Variables](tutorial/04_variables.md) |
| Need to see what rules fired                 | `trace.` or `[file].` then `listing.`                |

See **[tutorial/12_tracing.md](tutorial/12_tracing.md)** for the full guide
with screenshots-equivalent examples.

---

## 11. Project Layout

```
.vscode/
  settings.json     <- prolog executable + editor settings
  tasks.json        <- the 7 Prolog tasks
  launch.json       <- the 3 tracer/REPL debug configurations
  extensions.json   <- recommended extensions
prolog.bat          <- simple Windows launcher (cmd)
prolog.ps1          <- PowerShell launcher with -File / -Query
run-all-lab6.bat    <- loads every lab6/p*.pl file
add-path-current-user.ps1   <- optional: put swipl on your PATH permanently
first.pl            <- facts / rules / queries example
backward.pl         <- backward chaining example
backward.md         <- explanation of backward chaining
lab6/               <- 15 lab programs + printable PDF
tutorial/           <- beginner-friendly tutorial (this README links here)
```

---

## 12. Troubleshooting

| Symptom | Fix |
| ------- | --- |
| `swipl` not recognized in integrated terminal | Open a new one so it picks up the PATH added by `.vscode/settings.json` |
| Want permanent fix                            | Run `add-path-current-user.ps1` once and restart the terminal |
| No syntax highlighting                      | Install VFX-Prolog (`Ctrl+Shift+X` → search → install) |
| Query prints nothing                        | The answer may have been `true` — try `format('~p~n', [Result])` |
| Query returns `false.` but should be true   | `trace.` and step through — almost always a typo or wrong order |
| Stuck in infinite loop                      | `Ctrl+C` to abort, then re-check your base case |

---

## 13. Recommended Resources

* **SWI-Prolog official docs** — <https://www.swi-prolog.org/pldoc/index>
* **"Learn Prolog Now!"** — free online textbook, perfect beginner level
  (<http://www.learnprolognow.org/>)
* **"Programming in Prolog"** by Clocksin & Mellish — the classic
* **SWI-Prolog YouTube channel** — walkthroughs and Prolog logs episodes
* **`?- help.`** at the REPL — built-in help browser

---

## Contributing

Pull requests welcome — especially:
* More lab programs
* More tracing examples
* Translations of the tutorial

## License

Educational use. SWI-Prolog itself is licensed under the GPL.