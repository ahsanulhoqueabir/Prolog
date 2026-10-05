parent(tom, bob).
parent(pam, bob).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

ancestor(X, Y) :-                    % direct parent
    parent(X, Y).
ancestor(X, Y) :-                    % parent of an ancestor chain
    parent(X, Z),
    ancestor(Z, Y).

descendant(X, Y) :-                  % X is a child of Y
    parent(Y, X).
descendant(X, Y) :-                  % X is a child of someone who descends from Y
    parent(Z, X),
    descendant(Z, Y).

% Sample queries:
% ?- ancestor(tom, jim).     true.
% ?- ancestor(X, jim).       X = pat ; X = tom ; X = pam ; X = bob.
% ?- descendant(X, tom).     X = bob ; X = ann ; X = pat ; X = jim.
% ?- descendant(tom, jim).   false.
