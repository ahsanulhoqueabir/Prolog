nth_element(1, [H|_], H).                % the 1st element is the head
nth_element(N, [_|T], Elem) :-
    N > 1,
    N1 is N - 1,                         % one step closer to the front
    nth_element(N1, T, Elem).            % ask the same question about the tail

% Sample queries:
% ?- nth_element(3, [a,b,c,d], E).   E = c.
% ?- nth_element(1, [x,y], E).       E = x.
% ?- nth_element(5, [a,b], E).       false.
