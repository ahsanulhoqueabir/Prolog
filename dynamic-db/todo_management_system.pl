/*
Problem Statement:
Develop a dynamic To-Do List Management System using Prolog.
The system should allow users to add, view, update, and delete
tasks at runtime using dynamic database operations.
*/

:- dynamic todo/1.

start :-
    menu.

menu :-
    nl,
    write('1. Add Task'), nl,
    write('2. View Tasks'), nl,
    write('3. Update Task'), nl,
    write('4. Delete Task'), nl,
    write('5. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Enter task: '),
    read(Task),
    assertz(todo(Task)),
    write('Task added.'), menu.

handle(2) :-
    forall(todo(T), format('~w~n', [T])),
    menu.

handle(3) :-
    write('Enter old task: '), read(Old),
    (retract(todo(Old)) ->
        write('Enter new task: '), read(New),
        assertz(todo(New)),
        write('Task updated.')
    ;
        write('Task not found.')
    ),
    menu.

handle(4) :-
    write('Enter task to delete: '), read(Task),
    (retract(todo(Task)) ->
        write('Task deleted.')
    ;
        write('Task not found.')
    ),
    menu.

handle(5) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
