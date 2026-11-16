/*
Problem Statement:
Develop an Inventory Management System using Prolog.
The system should allow users to add products, view stock,
update product quantities, increase or decrease stock, and
remove products dynamically.
*/

:- dynamic product/3.

start :-
    menu.

menu :-
    nl,
    write('1. Add Product'), nl,
    write('2. View Products'), nl,
    write('3. Update Quantity'), nl,
    write('4. Stock In'), nl,
    write('5. Stock Out'), nl,
    write('6. Delete Product'), nl,
    write('7. Exit'), nl,
    read(Choice),
    handle(Choice).

handle(1) :-
    write('Product ID: '), read(ID),
    write('Product Name: '), read(Name),
    write('Quantity: '), read(Qty),
    assertz(product(ID, Name, Qty)),
    write('Product added.'), menu.

handle(2) :-
    forall(product(ID, Name, Qty),
        format('~w | ~w | Quantity: ~w~n', [ID, Name, Qty])),
    menu.

handle(3) :-
    write('Product ID: '), read(ID),
    (retract(product(ID, Name, _)) ->
        write('New Quantity: '), read(Qty),
        assertz(product(ID, Name, Qty)),
        write('Quantity updated.')
    ;
        write('Product not found.')
    ),
    menu.

handle(4) :-
    write('Product ID: '), read(ID),
    write('Stock to add: '), read(Amount),
    (retract(product(ID, Name, Qty)) ->
        NewQty is Qty + Amount,
        assertz(product(ID, Name, NewQty)),
        write('Stock added.')
    ;
        write('Product not found.')
    ),
    menu.

handle(5) :-
    write('Product ID: '), read(ID),
    write('Stock to remove: '), read(Amount),
    (product(ID, Name, Qty) ->
        (Amount =< Qty, Amount >= 0 ->
            retract(product(ID, Name, Qty)),
            NewQty is Qty - Amount,
            assertz(product(ID, Name, NewQty)),
            write('Stock removed.')
        ;
            write('Insufficient stock or invalid amount.')
        )
    ;
        write('Product not found.')
    ),
    menu.

handle(6) :-
    write('Product ID: '), read(ID),
    (retract(product(ID, _, _)) ->
        write('Product deleted.')
    ;
        write('Product not found.')
    ),
    menu.

handle(7) :-
    write('Goodbye!'), nl.

handle(_) :-
    write('Invalid choice.'), menu.
