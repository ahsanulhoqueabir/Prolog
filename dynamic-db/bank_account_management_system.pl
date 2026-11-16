/*
Problem Statement:
Develop a Bank Account Management System using Prolog.
The system should allow users to create accounts, view account
details, deposit money, withdraw money, update account holder
information, and delete accounts dynamically.
*/

:- dynamic account/3.

start :-
    menu.

menu :-
    nl,
    write('1. Create Account'), nl,
    write('2. View Accounts'), nl,
    write('3. Deposit Money'), nl,
    write('4. Withdraw Money'), nl,
    write('5. Update Account Holder'), nl,
    write('6. Delete Account'), nl,
    write('7. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Account Number: '), read(ID),
    write('Account Holder: '), read(Name),
    write('Initial Balance: '), read(Balance),
    assertz(account(ID, Name, Balance)),
    write('Account created.'), menu.

handle(2) :-
    forall(account(ID, Name, Balance),
        format('~w | ~w | Balance: ~w~n',
            [ID, Name, Balance])),
    menu.

handle(3) :-
    write('Account Number: '), read(ID),
    write('Deposit Amount: '), read(Amount),
    (account(ID, Name, Balance) ->
        (Amount > 0 ->
            retract(account(ID, Name, Balance)),
            NewBalance is Balance + Amount,
            assertz(account(ID, Name, NewBalance)),
            write('Deposit successful.')
        ;
            write('Invalid amount.')
        )
    ;
        write('Account not found.')
    ),
    menu.

handle(4) :-
    write('Account Number: '), read(ID),
    write('Withdraw Amount: '), read(Amount),
    (account(ID, Name, Balance) ->
        (Amount > 0, Amount =< Balance ->
            retract(account(ID, Name, Balance)),
            NewBalance is Balance - Amount,
            assertz(account(ID, Name, NewBalance)),
            write('Withdrawal successful.')
        ;
            write('Insufficient balance or invalid amount.')
        )
    ;
        write('Account not found.')
    ),
    menu.

handle(5) :-
    write('Account Number: '), read(ID),
    (retract(account(ID, _, Balance)) ->
        write('New Account Holder: '), read(Name),
        assertz(account(ID, Name, Balance)),
        write('Account updated.')
    ;
        write('Account not found.')
    ),
    menu.

handle(6) :-
    write('Account Number: '), read(ID),
    (retract(account(ID, _, _)) ->
        write('Account deleted.')
    ;
        write('Account not found.')
    ),
    menu.

handle(7) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
