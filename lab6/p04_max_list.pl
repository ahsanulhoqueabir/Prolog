max_list([X], X).                    % one element: it is the maximum
max_list([H|T], Max) :-
    max_list(T, MaxTail),            % maximum of the rest
    Max is max(H, MaxTail).          % bigger of H and that maximum

% Sample queries:
% ?- max_list([3,9,2,7], M).   M = 9.
% ?- max_list([5], M).         M = 5.
% ?- max_list([-4,-8,-1], M).  M = -1.
