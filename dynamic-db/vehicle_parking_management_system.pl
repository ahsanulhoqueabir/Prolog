/*
Problem Statement:
Develop a Vehicle Parking Management System using Prolog.
The system should allow users to park vehicles, view parked
vehicles, update parking slots, and remove vehicles when they
leave. It should also display available parking slots.
*/

:- dynamic parking/3.

total_slots(10).

start :-
    menu.

menu :-
    nl,
    write('1. Park Vehicle'), nl,
    write('2. View Parked Vehicles'), nl,
    write('3. Remove Vehicle'), nl,
    write('4. Update Parking Slot'), nl,
    write('5. Show Available Slots'), nl,
    write('6. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Vehicle Number: '), read(Number),
    write('Vehicle Type: '), read(Type),
    write('Parking Slot: '), read(Slot),
    (parking(_, Slot, _) ->
        write('Slot already occupied.')
    ;
        assertz(parking(Number, Slot, Type)),
        write('Vehicle parked successfully.')
    ),
    menu.

handle(2) :-
    forall(parking(N, S, T),
        format('Vehicle: ~w | Slot: ~w | Type: ~w~n', [N, S, T])),
    menu.

handle(3) :-
    write('Enter vehicle number: '), read(Number),
    (retract(parking(Number, _, _)) ->
        write('Vehicle removed.')
    ;
        write('Vehicle not found.')
    ),
    menu.

handle(4) :-
    write('Vehicle number: '), read(Number),
    write('New slot: '), read(NewSlot),
    (parking(Number, OldSlot, Type) ->
        (parking(_, NewSlot, _) ->
            write('Slot already occupied.')
        ;
            retract(parking(Number, OldSlot, Type)),
            assertz(parking(Number, NewSlot, Type)),
            write('Slot updated.')
        )
    ;
        write('Vehicle not found.')
    ),
    menu.

handle(5) :-
    total_slots(Total),
    findall(S, parking(_, S, _), Occupied),
    length(Occupied, Count),
    Available is Total - Count,
    format('Total Slots: ~w~nOccupied: ~w~nAvailable: ~w~n',
        [Total, Count, Available]),
    menu.

handle(6) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
