parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(liz, sue).

male(tom).
male(bob).
male(pat).
female(liz).
female(ann).
female(sue).

sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

uncle(U, Child) :-                   % U is a male sibling of Child's parent
    parent(P, Child),
    sibling(U, P),
    male(U).

aunt(A, Child) :-                    % A is a female sibling of Child's parent
    parent(P, Child),
    sibling(A, P),
    female(A).

% Sample queries:
% ?- uncle(bob, sue).    true.
% ?- aunt(liz, ann).     true.
% ?- aunt(A, C).         A = liz, C = ann ; A = liz, C = pat.
% ?- uncle(U, ann).      false.
