% input (environment):

train(1).
start(1, (0, 0), 0, north).
end(1, (0, 2), 6).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 32800).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 32800).
cell((2, 0), 16386).
cell((2, 1), 1025).
cell((2, 2), 4608).

% conversion of the input to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
position(Y*10 + X) :- cell((Y, X), _).
flat_id(P, I) :- position(P), I = #count { Q : position(Q), Q < P }.
cell_flat(POSITION, TYPE) :- cell((Y,X), TYPE), flat_id(Y*10+X, POSITION).
start_flat(TRAIN, FLAT_POS, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION),
                                                          flat_id(Y*10 + X, FLAT_POS).
end_flat(TRAIN, FLAT_POS, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME),
                                           flat_id(Y*10 + X, FLAT_POS).

% expressing the route:

moment(0..MAX_TIME-1) :- end(_, (_, _), MAX_TIME).

path(north, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE).
path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE).

path(east, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION + 1, TYPE).
path(west, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION - 1, TYPE).

path(east, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 4608), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE).
path(north, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 4608), cell_flat(POSITION - 1, TYPE).

path(west, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 16386), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE).
path(north, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 16386), cell_flat(POSITION + 1, TYPE).

path(west, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 72), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE).
path(south, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 72), cell_flat(POSITION + 1, TYPE).

path(east, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 2064), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE).
path(south, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 2064), cell_flat(POSITION - 1, TYPE).

% generating solution candidates:

1 { transition(TRAIN, MOMENT, FROM, TO) : path(_, FROM, _, TO) } 1 :- train(TRAIN), moment(MOMENT).

% constraints:

:- transition(TRAIN, MOMENT, CURRENT_CELL_1, _),
   transition(TRAIN, MOMENT, CURRENT_CELL_2, _),
   CURRENT_CELL_1 != CURRENT_CELL_2.

:- transition(TRAIN_1, MOMENT_1, FROM_CELL, TO_CELL), 
   transition(TRAIN_2, MOMENT_2, FROM_CELL, TO_CELL),
   TRAIN_1 == TRAIN_2, MOMENT_1 != MOMENT_2.

:- transition(TRAIN, MOMENT, _, TO_CELL),
   transition(TRAIN, MOMENT+1, FROM_CELL, _),
   TO_CELL != FROM_CELL.

:- transition(TRAIN, MOMENT, FROM_CELL, TO_CELL),
   transition(TRAIN, MOMENT+1, TO_CELL, FROM_CELL).

:- transition(TRAIN, DEPARTUTRE_TIME, FLAT_POS_1, _),
   start_flat(TRAIN, FLAT_POS_START, DEPARTUTRE_TIME, _),
   FLAT_POS_1 != FLAT_POS_START.

:- end_flat(TRAIN, FLAT_POS_1, ARRIVAL_TIME),
   transition(TRAIN, ARRIVAL_TIME - 1, _, FLAT_POS_2),
   FLAT_POS_1 != FLAT_POS_2.

% output:

% #show transition/4.
#show path/4.
% #show end_flat/3.
