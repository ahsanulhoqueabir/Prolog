fact(0, 1).                  % base case: 0! = 1
fact(N, F) :-                % recursive case
    N > 0,
    N1 is N - 1,
    fact(N1, F1),
    F is N * F1.

% Sample queries:
% ?- fact(5, F).     F = 120.
% ?- fact(0, F).     F = 1.
% ?- fact(10, F).    F = 3628800.
% ?- fact(-3, F).    false.
