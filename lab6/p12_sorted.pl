sorted([]).                          % empty list is sorted
sorted([_]).                         % one element is sorted
sorted([X, Y|T]) :-                  % compare the first two elements
    X =< Y,
    sorted([Y|T]).                   % then check the rest

% Sample queries:
% ?- sorted([1,2,2,5,9]).   true.
% ?- sorted([1,3,2]).       false.
% ?- sorted([]).            true.
