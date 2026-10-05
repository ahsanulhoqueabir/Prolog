sum_even([], 0).                    % empty list: sum is 0
sum_even([H|T], Sum) :-             % H is even: add it
    H mod 2 =:= 0,
    sum_even(T, Rest),
    Sum is Rest + H.
sum_even([H|T], Sum) :-             % H is odd: skip it
    H mod 2 =\= 0,
    sum_even(T, Sum).

% Sample queries:
% ?- sum_even([1,2,3,4,5,6], S).   S = 12.
% ?- sum_even([1,3,5], S).         S = 0.
% ?- sum_even([], S).              S = 0.
