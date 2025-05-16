% input (environment):

train(1).
start(1, (2, 0), 0, east).
end(1, (0, 1), 3).

cell((0, 0), 72).
cell((0, 1), 38433).
cell((0, 2), 2064).
cell((1, 0), 38505).
cell((1, 1), 17411).
cell((1, 2), 17411).
cell((2, 0), 20994).
cell((2, 1), 2064).
cell((2, 2), 0).

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

moment(TRAIN, 0..MAX_TIME-1) :- end(TRAIN, (_, _), MAX_TIME).

path(north, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, south, POSITION) :- cell_flat(POSITION, 32800).
path(north, POSITION, north, POSITION) :- cell_flat(POSITION, 32800).

path(east, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(west, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(west, POSITION, west, POSITION) :- cell_flat(POSITION, 1025).
path(east, POSITION, east, POSITION) :- cell_flat(POSITION, 1025).

path(east, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 4608), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 4608), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(north, POSITION, north, POSITION) :- cell_flat(POSITION, 4608).
path(east, POSITION, east, POSITION) :- cell_flat(POSITION, 4608).

path(west, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 16386), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 16386), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(north, POSITION, north, POSITION) :- cell_flat(POSITION, 16386).
path(west, POSITION, west, POSITION) :- cell_flat(POSITION, 16386).

path(west, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 72), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 72), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(south, POSITION, south, POSITION) :- cell_flat(POSITION, 72).
path(west, POSITION, west, POSITION) :- cell_flat(POSITION, 72).

path(east, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 2064), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 2064), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(south, POSITION, south, POSITION) :- cell_flat(POSITION, 2064).
path(east, POSITION, east, POSITION) :- cell_flat(POSITION, 2064).

path(east, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, west, POSITION - 1) :- cell_flat(POSITION, 6672), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(west, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(west, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, west, POSITION + 1) :- cell_flat(POSITION, 16458), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(north, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(west, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 34864), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path((north;east), POSITION, south, POSITION + WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 32872), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path((north; west), POSITION, south, POSITION + WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(east, POSITION, east, POSITION - WIDTH) :- cell_flat(POSITION, 5633), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, south, POSITION + 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path((north; west), POSITION, west, POSITION - 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(north, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((north; west), POSITION, east, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.

path(south, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(north, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(north, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, north, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(west, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(west, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 17411), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path((east; north), POSITION, east, POSITION + 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(north, POSITION, west, POSITION - 1) :- cell_flat(POSITION, 20994), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(north, POSITION, east, POSITION + 1) :- cell_flat(POSITION, 20994), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path((east; west), POSITION, south, POSITION - WIDTH) :- cell_flat(POSITION, 20994), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.

% generating solution candidates:

1 { transition(TRAIN, MOMENT, FROM_CELL, TO_CELL) : path(FROM_DIR, FROM_CELL, TO_DIR, TO_CELL) } 1 :- train(TRAIN), moment(TRAIN, MOMENT).

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

:- transition(TRAIN_1, MOMENT, _, TO_CELL),
   transition(TRAIN_2, MOMENT, _, TO_CELL),
   TRAIN_1 != TRAIN_2.

:- start_flat(_, FROM_POSITION, _, DIRECTION),
   path(_, FROM_POSITION, _, TO_POSITION),
   transition(DIRECTION, FROM_POSITION, _, TO_POSITION).

% standardizing the output:

action(TRAIN,MOMENT,wait) :- transition(TRAIN,MOMENT,POS_1,POS_2), POS_1 == POS_2.
action(TRAIN, MOMENT, move_forward) :- transition(TRAIN, MOMENT, POS_1, POS_2), POS_1 != POS_2.

% displaying the output:

% #show action/3.
#show transition/4.
% #show path/4.
% #show end_flat/3.
% #show grid_size/2.
% #show cell_flat/2.
% #show start_flat/4.