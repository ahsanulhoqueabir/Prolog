# Backward Chaining in Prolog — অন্তর্নিহিত কার্যপ্রণালী (Internal Working)

এই ডকুমেন্টটা `backward.pl` ফাইলটার সাথে মিলিয়ে পড়ুন। এখানে **কোড কী করে** তার চেয়েও বেশি গুরুত্ব দিয়ে দেখানো হয়েছে **Prolog-এর ইঞ্জিন ভেতরে ভেতরে কীভাবে backward chaining করে** — ধাপে ধাপে, কল স্ট্যাক, ব্যাকট্র্যাকিং আর পয়েন্টার (choice point) সহ।

> **মূল কথা:** Prolog-এ আমরা ফ্যাক্ট আর রুল লিখি **কীভাবে** (how) কম্পিউট করব সেটা না বলে **কী সত্য** (what is true) সেটা বলে দিই। বাকি কাজ — "কোন নিয়ম আগে ব্যবহার করব", "কোনটা মিথ্যা হলে পেছনে ফিরব" — সবটা Prolog-এর **backward chaining engine** নিজে করে।

---

## ১. Backward Chaining কী? (এক লাইনে)

**Forward chaining** = ফ্যাক্ট থেকে শুরু করে লক্ষ্যের দিকে এগোনো (data-driven)।
**Backward chaining** = **লক্ষ্য (goal) থেকে শুরু করে** ফ্যাক্ট/রুল খুঁজে পেছনের দিকে কাজ করা (goal-driven)। Prolog এটাই করে।

যখন আপনি `?- carnivore(dog).` টাইপ করেন, Prolog জিজ্ঞেস করছে না "dog-এর কী কী বৈশিষ্ট্য আছে?" বরং বলছে:

> "প্রমাণ করো `carnivore(dog)` সত্য। যদি না পারো, সেটা মিথ্যা।"

এই "প্রমাণ করো" (prove it) অনুরোধই backward chaining-এর সূচনা।

---

## ২. Prolog-এর মূল ডেটা স্ট্রাকচার: Goal Stack

Prolog-এর ভেতরে একটা **goal stack** (লক্ষ্য-এর স্তুপ) থাকে। শুরুতে শুধু একটা goal থাকে:

```
Goal Stack:  [ carnivore(dog) ]
```

Prolog একটা চিরন্তন লুপে চলে:

1. স্ট্যাকের **শীর্ষ** (top) থেকে একটা goal বের করো।
2. সেই goal-কে সত্য প্রমাণ করার চেষ্টা করো।
3. সফল হলে পরের goal; ব্যর্থ হলে **ব্যাকট্র্যাক** (পেছনে ফেরো)।

---

## ৩. ধাপে ধাপে: `?- carnivore(dog).` কীভাবে internally প্রমাণ হয়

### ধাপ ০ — প্রাথমিক অবস্থা

```
Goal Stack:  [ carnivore(dog) ]
```

### ধাপ ১ — রুল হেড ম্যাচিং (Rule Head Matching)

Prolog নলেজ বেসে খোঁজে এমন কিছু যা `carnivore(dog)`-কে প্রমাণ করতে পারে। পায়:

```prolog
carnivore(X) :- mammal(X), eats_meat(X).
```

**Unification** (একীকরণ): `carnivore(X)` আর `carnivore(dog)` — এই দুটোকে মেলালে `X = dog` হয়। মিলে গেছে!

### ধাপ ২ — Body-কে সাবগোলে রূপান্তর

রুলের body-তে দুটো অংশ। Prolog সেগুলোকে **স্ট্যাকের উপরে** চাপিয়ে দেয় (ডান থেকে বামে, যাতে বামেরটা আগে প্রসেস হয়):

```
Goal Stack:  [ eats_meat(dog), mammal(dog) ]
                  ^
                  |__ পরের টার্গেট (top)
```

> ⚠️ **গুরুত্বপূর্ণ:** Prolog body-র goal-গুলো **ক্রমে (left to right)** প্রমাণ করে, কিন্তু স্ট্যাকের কারণে ভেতরে ডানদিকের goal আগে স্ট্যাকে পড়ে।

### ধাপ ৩ — প্রথম সাবগোল প্রমাণ

Top-এ `mammal(dog)`। Prolog আবার রুল খোঁজে:

```prolog
mammal(X) :- has_fur(X).
```

Unify করে `X = dog`। Body থেকে নতুন সাবগোল:

```
Goal Stack:  [ eats_meat(dog), has_fur(dog) ]
```

### ধাপ ৪ — ফ্যাক্টে পৌঁছানো (Base Case)

Top-এ `has_fur(dog)`। এবার Prolog রুল নয়, **ফ্যাক্ট** খোঁজে। নলেজ বেসে আছে `has_fur(dog).` — সরাসরি মিলে গেল! এই সাবগোল **EXIT** (সফল)।

```
Goal Stack:  [ eats_meat(dog) ]
```

### ধাপ ৫ — পরের সাবগোল

`eats_meat(dog)` — ফ্যাক্ট `eats_meat(dog).` সরাসরি আছে। সফল।

### ধাপ ৬ — ফাঁকা স্ট্যাক = সফল

```
Goal Stack:  [ ]     ← খালি!
```

স্ট্যাক পুরোপুরি খালি হওয়া মানে **সব সাবগোল প্রমাণিত**, অর্থাৎ মূল goal সত্য। Prolog উত্তর দেয়:

```
?- carnivore(dog).
true.
```

---

## ৪. ব্যর্থতা ও ব্যাকট্র্যাকিং (Failure & Backtracking)

এবার `?- carnivore(elephant).` চেষ্টা করুন। একই রকম শুরু:

```
Goal Stack:  [ carnivore(elephant) ]
→ রুল:  carnivore(X) :- mammal(X), eats_meat(X).     X = elephant
Goal Stack:  [ eats_meat(elephant), mammal(elephant) ]
→ রুল:  mammal(X) :- has_fur(X).                      X = elephant
Goal Stack:  [ eats_meat(elephant), has_fur(elephant) ]
```

`has_fur(elephant)` — নলেজ বেসে আছে `has_fur(elephant).` ✅ সফল।

```
Goal Stack:  [ eats_meat(elephant) ]
```

`eats_meat(elephant)` — আছে কি? ফ্যাক্টগুলো দেখুন: `eats_meat(dog).`, `eats_meat(cat).` — **`eats_meat(elephant)` নেই!** ❌

এখানেই **ব্যাকট্র্যাকিং**:

- Prolog এই সাবগোল প্রমাণ করতে ব্যর্থ।
- তাই এটি **সম্পূর্ণ প্রমাণ-প্রচেষ্টা বাতিল** করে না — বরং **পেছনে ফিরে** দেখে অন্য কোনো উপায় আছে কিনা।
- কিন্তু `carnivore(…)` রুলের জন্য আর অন্য কোনো ম্যাচ নেই। তাই পুরো goal ব্যর্থ।

```
?- carnivore(elephant).
false.
```

> **ব্যাকট্র্যাকিং-এর সংজ্ঞা:** যখন একটা পথ (path) ব্যর্থ হয়, Prolog শেষ "choice point"-এ (যেখানে একাধিক বিকল্প ছিল) ফিরে যায় এবং **পরের বিকল্পটা** চেষ্টা করে। সব বিকল্প শেষ হলে `false`।

---

## ৫. Choice Point (নির্বাচন-বিন্দু) — সবচেয়ে গুরুত্বপূর্ণ ধারণা

যখন Prolog কোনো goal-এর জন্য **একাধিক** ম্যাচিং ক্লজ পায়, তখন সেটা একটা **choice point** তৈরি করে রাখে। যেমন `predator/1`:

```prolog
predator(X) :- carnivore(X).     % বিকল্প ১
predator(X) :- eats_meat(X).     % বিকল্প ২
```

`?- predator(X).` দিলে Prolog প্রথমে **বিকল্প ১** চেষ্টা করে। পরে সেটা শেষ (সমস্ত সম্ভাব্য X শেষ) হলে, Prolog choice point-এ ফিরে **বিকল্প ২** চালায়।

`trace` চালিয়ে দেখলে এই গুলো `REDO` হিসেবে দেখা যায়।

---

## ৬. `trace` দিয়ে ভেতরে দেখা (সবচেয়ে ভালো অভিজ্ঞতা)

`backward.pl` লোড করে চালান:

```prolog
?- trace, carnivore(dog).
```

আউটপুট এমন দেখাবে:

```
   Call: (8) carnivore(dog) ?
   Call: (9) mammal(dog) ?
   Call: (10) has_fur(dog) ?
   Exit: (10) has_fur(dog)
   Exit: (9) mammal(dog)
   Call: (9) eats_meat(dog) ?
   Exit: (9) eats_meat(dog)
   Exit: (8) carnivore(dog)
true.
```

**এই চারটা শব্দই backward chaining-এর ভাষা:**

| চিহ্ন  | অর্থ                                | অর্থ (বাংলা)     |
| ------ | ----------------------------------- | ---------------- |
| `Call` | একটা goal প্রমাণ করার চেষ্টা শুরু   | একটি লক্ষ্য শুরু |
| `Exit` | goal সফলভাবে প্রমাণিত               | লক্ষ্য সফল       |
| `Redo` | ব্যাকট্র্যাকিং করে goal আবার চেষ্টা | পেছনে ফিরে আবার  |
| `Fail` | goal প্রমাণ করা গেল না              | লক্ষ্য ব্যর্থ    |

লক্ষ্য করুন **বন্ধনীর সংখ্যা** `(8)`, `(9)`, `(10)` — এটা **কল স্ট্যাকের গভীরতা** (recursion depth)। Program stack গভীরতর হচ্ছে, আবার ফিরে আসছে। এটাই literally "backward" চেইনিং।

---

## ৭. Recursive Rule-এ Backward Chaining

`first.pl`-এর `ancestor/2`-এর মতো recursive রুলে backward chaining সবচেয়ে স্পষ্ট:

```prolog
ancestor(X, Z) :- parent(X, Z).            % base case
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).   % recursive case
```

`?- ancestor(john, lily).` দিলে:

```
Call: ancestor(john, lily)
  Call: parent(john, lily)        → ব্যর্থ (base case)
  Redo: (দ্বিতীয় রুলে যায়)
  Call: parent(john, _Y)          → _Y = mary
  Call: ancestor(mary, lily)
    Call: parent(mary, lily)      → ব্যর্থ
    Redo:
    Call: parent(mary, _Y2)       → _Y2 = ann
    Call: ancestor(ann, lily)
      Call: parent(ann, lily)     → সফল! ✅
      Exit: ancestor(ann, lily)
    Exit: ancestor(mary, lily)
  Exit: ancestor(john, lily)
true.
```

দেখুন — goal `ancestor(john, lily)` নিজেকে ছোট goal `ancestor(mary, lily)`, তারপর আরও ছোট `ancestor(ann, lily)`-তে ভেঙে ফেলছে, যতক্ষণ না একটা ফ্যাক্টে (`parent(ann, lily)`) পৌঁছায়। **এটাই backward chaining + recursion-এর মিলিত শক্তি।**

---

## ৮. Forward vs Backward — তুলনা

|          | Forward Chaining          | Backward Chaining (Prolog)  |
| -------- | ------------------------- | --------------------------- |
| শুরু     | পরিচিত ফ্যাক্ট থেকে       | **লক্ষ্য (query)** থেকে     |
| দিক      | ফ্যাক্ট → উপসংহার         | উপসংহার → ফ্যাক্ট           |
| ড্রাইভ   | Data-driven               | **Goal-driven**             |
| কখন ভালো | সামান্য ডেটা, অনেক প্রশ্ন | অনেক ডেটা, নির্দিষ্ট প্রশ্ন |
| Prolog?  | না                        | **হ্যাঁ, এটাই Prolog**      |

---

## ৯. সারসংক্ষেপ — Prolog-এর ইঞ্জিনের ভেতরে যা ঘটে

1. **Goal stack**-এ query-টা বসে।
2. Prolog নলেজ বেসে **শীর্ষ থেকে নিচে** খোঁজে একটি ম্যাচিং ক্লজ (ফ্যাক্ট বা রুল হেড)।
3. **Unification** দিয়ে ভেরিয়েবল বাঁধা হয় (binding)।
4. রুল হলে, body-র goal-গুলো নতুন **সাবগোল** হয়ে স্ট্যাকে যায়।
5. ফ্যাক্টে পৌঁছালে সেই শাখা সফল (**Exit**)।
6. কোনো শাখা ব্যর্থ হলে, Prolog **choice point**-এ ফিরে পরের বিকল্প চেষ্টা করে (**Redo/Backtrack**), শেষে না পারলে **Fail**।
7. স্ট্যাক খালি হলে পুরো goal সত্য; নাহলে মিথ্যা।

> **মনে রাখার সূত্র:** _"Backward chaining = লক্ষ্য থেকে শুরু, রুলের body ভেঙে ছোট subgoal, ফ্যাক্টে পৌঁছে সফল, ব্যর্থ হলে পেছনে ফিরে অন্য পথ।"_

**পরীক্ষা করার পরামর্শ:** `trace` চালিয়ে `?- carnivore(X).`, `?- predator(X).`, অথবা `first.pl`-এ `?- ancestor(john, lily).` চালান — backward chaining-এর পুরো নাচটা চোখের সামনে দেখতে পাবেন।
