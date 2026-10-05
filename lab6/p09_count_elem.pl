count_elem([], _, 0).                    % nothing to count in an empty list
count_elem([E|T], E, Count) :-           % head equals the element we look for
    count_elem(T, E, Rest),
    Count is Rest + 1.
count_elem([H|T], E, Count) :-           % head is something else
    H \= E,
    count_elem(T, E, Count).

% Sample queries:
% ?- count_elem([a,b,a,c,a], a, C).   C = 3.
% ?- count_elem([a,b,c], z, C).       C = 0.
% ?- count_elem([], a, C).            C = 0.
