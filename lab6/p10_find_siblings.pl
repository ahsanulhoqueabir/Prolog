parent(tom, bob).
parent(pam, bob).
parent(tom, liz).
parent(pam, liz).
parent(tom, jack).
parent(pam, jack).
parent(bob, ann).
parent(bob, pat).

sibling(X, Y) :-                     % same parent, but not the same person
    parent(P, X),
    parent(P, Y),
    X \= Y.

find_siblings(Person, Siblings) :-
    findall(S, sibling(Person, S), AllSiblings),
    sort(AllSiblings, Siblings).     % sort also removes duplicates

% Sample queries:
% ?- find_siblings(bob, L).                   L = [jack, liz].
% ?- findall(S, sibling(bob, S), L).          L = [liz, jack, liz, jack].
% ?- find_siblings(ann, L).                   L = [pat].
% ?- find_siblings(tom, L).                   L = [].
