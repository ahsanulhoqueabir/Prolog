is_prime(N) :-
    N > 1,                           % 0, 1 and negatives are not prime
    \+ has_divisor(N, 2).            % no divisor found, starting from 2

has_divisor(N, D) :-                 % D divides N exactly
    D * D =< N,
    N mod D =:= 0.
has_divisor(N, D) :-                 % otherwise try the next D
    D * D =< N,
    D1 is D + 1,
    has_divisor(N, D1).

% Sample queries:
% ?- is_prime(7).    true.
% ?- is_prime(15).   false.
% ?- is_prime(2).    true.
% ?- is_prime(1).    false.
