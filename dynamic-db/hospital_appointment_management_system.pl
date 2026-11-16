/*
Problem Statement:
Develop a Hospital Appointment Management System using Prolog.
The system should allow users to book appointments, view
appointments, reschedule appointments, and cancel bookings
using dynamic database operations.
*/

:- dynamic appointment/4.

start :-
    menu.

menu :-
    nl,
    write('1. Book Appointment'), nl,
    write('2. View Appointments'), nl,
    write('3. Reschedule Appointment'), nl,
    write('4. Cancel Appointment'), nl,
    write('5. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Appointment ID: '), read(ID),
    write('Patient Name: '), read(Patient),
    write('Doctor Name: '), read(Doctor),
    write('Time: '), read(Time),
    assertz(appointment(ID, Patient, Doctor, Time)),
    write('Appointment booked.'), menu.

handle(2) :-
    forall(appointment(ID, Patient, Doctor, Time),
        format('~w | ~w | ~w | ~w~n',
            [ID, Patient, Doctor, Time])),
    menu.

handle(3) :-
    write('Appointment ID: '), read(ID),
    (retract(appointment(ID, Patient, Doctor, _)) ->
        write('New Time: '), read(NewTime),
        assertz(appointment(ID, Patient, Doctor, NewTime)),
        write('Appointment rescheduled.')
    ;
        write('Appointment not found.')
    ),
    menu.

handle(4) :-
    write('Appointment ID: '), read(ID),
    (retract(appointment(ID, _, _, _)) ->
        write('Appointment cancelled.')
    ;
        write('Appointment not found.')
    ),
    menu.

handle(5) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
