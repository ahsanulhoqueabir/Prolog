/*
Problem Statement:
Develop a Library Management System using Prolog.
The system should allow users to add books, view available books,
issue books to students, return books, and remove book records.
*/

:- dynamic book/3.

start :-
    menu.

menu :-
    nl,
    write('1. Add Book'), nl,
    write('2. View Books'), nl,
    write('3. Issue Book'), nl,
    write('4. Return Book'), nl,
    write('5. Remove Book'), nl,
    write('6. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Book ID: '), read(ID),
    write('Book Title: '), read(Title),
    assertz(book(ID, Title, available)),
    write('Book added.'), menu.

handle(2) :-
    forall(book(ID, Title, Status),
        format('~w | ~w | ~w~n', [ID, Title, Status])),
    menu.

handle(3) :-
    write('Enter Book ID: '), read(ID),
    (retract(book(ID, Title, available)) ->
        assertz(book(ID, Title, issued)),
        write('Book issued.')
    ;
        write('Book unavailable or not found.')
    ),
    menu.

handle(4) :-
    write('Enter Book ID: '), read(ID),
    (retract(book(ID, Title, issued)) ->
        assertz(book(ID, Title, available)),
        write('Book returned.')
    ;
        write('Issued book not found.')
    ),
    menu.

handle(5) :-
    write('Enter Book ID: '), read(ID),
    (retract(book(ID, _, _)) ->
        write('Book removed.')
    ;
        write('Book not found.')
    ),
    menu.

handle(6) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
