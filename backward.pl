% ============================================================
% backward.pl
% Backward Chaining (Goal-Driven Reasoning) in Prolog
%
% Prolog's execution engine is based on BACKWARD CHAINING.
% It starts from a GOAL (the query) and works BACKWARD,
% trying to prove that goal by searching facts and rules.
%
% ============================================================

% ---- Facts (the knowledge base / database) ----
% These are ALWAYS true. Backward chaining ends when it
% reaches a fact that matches the current subgoal.

is_animal(dog).
is_animal(cat).
is_animal(elephant).
is_animal(sparrow).

has_fur(dog).
has_fur(cat).
has_fur(elephant).
has_feathers(sparrow).

eats_meat(dog).
eats_meat(cat).
eats_plant(elephant).
eats_seeds(sparrow).

can_fly(sparrow).
cannot_fly(dog).
cannot_fly(cat).
cannot_fly(elephant).

% ---- Rules (IF ... THENCode language not supported or defined. ...) ----
% A rule is:  Head :- Body.
% Meaning: Head is TRUE if (and only if) Body is proven true.
% To prove the Head, Prolog must prove EVERY goal in the Body.

% mammal(X) is true IF X has fur
mammal(X) :- has_fur(X).

% carnivore(X) is true IF X is a mammal AND X eats meat
carnivore(X) :- mammal(X), eats_meat(X).

% herbivore(X) is true IF X is a mammal AND X eats plants
herbivore(X) :- mammal(X), eats_plant(X).

% bird(X) is true IF X has feathers
bird(X) :- has_feathers(X).

% predator(X) is true IF X is a carnivore OR X eats meat directly
predator(X) :- carnivore(X).
predator(X) :- eats_meat(X).

% terrestrial(X) is true IF X cannot fly
terrestrial(X) :- cannot_fly(X).

% warm_blooded(X) is true IF X is a mammal OR X is a bird
warm_blooded(X) :- mammal(X).
warm_blooded(X) :- bird(X).

% ============================================================
% HOW TO TRY IT (sample queries to type at the ?- prompt):
%
%   ?- mammal(dog).                 % true
%   ?- mammal(sparrow).             % false
%   ?- carnivore(dog).              % true  (dog is mammal + eats meat)
%   ?- carnivore(elephant).         % false (elephant eats plants)
%   ?- warm_blooded(elephant).      % true  (via mammal)
%   ?- warm_blooded(sparrow).       % true  (via bird)
%   ?- predator(X).                 % finds all predators, one by one
%   ?- trace.                       % turn on execution tracing
%   ?- trace, carnivore(dog).       % WATCH backward chaining step by step
%   ?- notrace.                     % turn tracing off
%
% The 'trace' command is the BEST way to SEE backward chaining
% happening internally. Prolog will print CALL, EXIT, REDO, FAIL
% for every step.
% ============================================================
