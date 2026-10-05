palindrome(List) :-
    reverse_list(List, List).        % a palindrome equals its own reverse

reverse_list(List, Reversed) :-
    reverse_acc(List, [], Reversed).
reverse_acc([], Acc, Acc).
reverse_acc([H|T], Acc, Reversed) :-
    reverse_acc(T, [H|Acc], Reversed).

% Sample queries:
% ?- palindrome([r,a,c,e,c,a,r]).   true.
% ?- palindrome([1,2,3]).           false.
% ?- palindrome([]).                true.

