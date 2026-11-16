/*
Problem Statement:
Develop a Student Management System using Prolog.
The system should allow users to register students, view student
records, update student information, delete records, and update
students' marks dynamically.
*/

:- dynamic student/3.

start :-
    menu.

menu :-
    nl,
    write('1. Add Student'), nl,
    write('2. View Students'), nl,
    write('3. Update Student'), nl,
    write('4. Delete Student'), nl,
    write('5. Update Marks'), nl,
    write('6. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Student ID: '), read(ID),
    write('Name: '), read(Name),
    write('Marks: '), read(Marks),
    assertz(student(ID, Name, Marks)),
    write('Student added.'), menu.

handle(2) :-
    forall(student(ID, Name, Marks),
        format('ID: ~w | Name: ~w | Marks: ~w~n',
            [ID, Name, Marks])),
    menu.

handle(3) :-
    write('Student ID: '), read(ID),
    (retract(student(ID, _, Marks)) ->
        write('New Name: '), read(Name),
        assertz(student(ID, Name, Marks)),
        write('Student updated.')
    ;
        write('Student not found.')
    ),
    menu.

handle(4) :-
    write('Student ID: '), read(ID),
    (retract(student(ID, _, _)) ->
        write('Student deleted.')
    ;
        write('Student not found.')
    ),
    menu.

handle(5) :-
    write('Student ID: '), read(ID),
    (retract(student(ID, Name, _)) ->
        write('New Marks: '), read(Marks),
        assertz(student(ID, Name, Marks)),
        write('Marks updated.')
    ;
        write('Student not found.')
    ),
    menu.

handle(6) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
