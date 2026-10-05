list_length([], 0).                  % empty list has length 0
list_length([_|T], N) :-
    list_length(T, N1),              % length of the tail
    N is N1 + 1.                     % plus one for the head

% Sample queries:
% ?- list_length([a,b,c], N).   N = 3.
% ?- list_length([], N).        N = 0.
% ?- list_length([1,[2,3],4], N). N = 3.
