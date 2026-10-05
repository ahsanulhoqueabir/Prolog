fib(0, 0).                           % base case 1
fib(1, 1).                           % base case 2
fib(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1 + F2.

% Sample queries:
% ?- fib(5, F).    F = 5.
% ?- fib(10, F).   F = 55.
% ?- fib(0, F).    F = 0.
