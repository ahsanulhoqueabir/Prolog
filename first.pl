% ============================================
% Basic Prolog Program - first.pl
% Facts, Rules, and Queries
% ============================================

% ---- Facts ----
% parent(Parent, Child)
parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(tom, lily).

% gender
male(john).
male(tom).
male(jack).
female(mary).
female(ann).
female(lily).

% ---- Rules ----
% father: X is father of Y if X is parent of Y and X is male
father(X, Y) :- parent(X, Y), male(X).

% mother: X is mother of Y if X is parent of Y and X is female
mother(X, Y) :- parent(X, Y), female(X).

% grandparent
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

% sibling: X and Y are siblings if they share a parent
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% ancestor
ancestor(X, Z) :- parent(X, Z).
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).
