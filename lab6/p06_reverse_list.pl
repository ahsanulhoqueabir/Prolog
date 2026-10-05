reverse_list(Input, Output) :-
    reverse_acc(Input, [], Output).      % start with an empty accumulator
reverse_acc([], Acc, Acc).               % input used up: accumulator is the answer
reverse_acc([H|T], Acc, Output) :-
    reverse_acc(T, [H|Acc], Output).     % move H onto the front of Acc

% Sample queries:
% ?- reverse_list([1,2,3], R).   R = [3,2,1].
% ?- reverse_list([], R).        R = [].
% ?- reverse_list([a], R).       R = [a].
