eval(N, N) :-                        % a plain number is its own value
    number(N).
eval(add(A, B), R) :-
    eval(A, RA),
    eval(B, RB),
    R is RA + RB.
eval(sub(A, B), R) :-
    eval(A, RA),
    eval(B, RB),
    R is RA - RB.
eval(mul(A, B), R) :-
    eval(A, RA),
    eval(B, RB),
    R is RA * RB.
eval(div(A, B), R) :-
    eval(A, RA),
    eval(B, RB),
    R is RA / RB.

% Sample queries:
% ?- eval(add(3, mul(2, 4)), R).            R = 11.
% ?- eval(sub(10, add(2, 3)), R).           R = 5.
% ?- eval(div(mul(6, 4), sub(7, 4)), R).    R = 8.
% ?- eval(7, R).                            R = 7.
