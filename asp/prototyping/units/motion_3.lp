% input (environment):

train(1).
start(1, (6, 8), 2, north).
end(1, (3, 3), 14).

train(2).
start(2, (1, 6), 0, west).
end(2, (7, 1), 17).

cell((0, 0), 0).
cell((0, 1), 0).
cell((0, 2), 0).
cell((0, 3), 0).
cell((0, 4), 0).
cell((0, 5), 0).
cell((0, 6), 0).
cell((0, 7), 0).
cell((0, 8), 0).
cell((0, 9), 0).
cell((1, 0), 0).
cell((1, 1), 72).
cell((1, 2), 1025).
cell((1, 3), 2064).
cell((1, 4), 0).
cell((1, 5), 72).
cell((1, 6), 1025).
cell((1, 7), 1025).
cell((1, 8), 2064).
cell((1, 9), 0).
cell((2, 0), 0).
cell((2, 1), 32800).
cell((2, 2), 0).
cell((2, 3), 49186).
cell((2, 4), 1025).
cell((2, 5), 37408).
cell((2, 6), 0).
cell((2, 7), 0).
cell((2, 8), 32800).
cell((2, 9), 0).
cell((3, 0), 0).
cell((3, 1), 16386).
cell((3, 2), 2064).
cell((3, 3), 32800).
cell((3, 4), 0).
cell((3, 5), 16386).
cell((3, 6), 2064).
cell((3, 7), 0).
cell((3, 8), 32800).
cell((3, 9), 0).
cell((4, 0), 0).
cell((4, 1), 0).
cell((4, 2), 16386).
cell((4, 3), 34864).
cell((4, 4), 0).
cell((4, 5), 0).
cell((4, 6), 32872).
cell((4, 7), 1025).
cell((4, 8), 4608).
cell((4, 9), 0).
cell((5, 0), 0).
cell((5, 1), 72).
cell((5, 2), 1025).
cell((5, 3), 37408).
cell((5, 4), 0).
cell((5, 5), 72).
cell((5, 6), 20994).
cell((5, 7), 1025).
cell((5, 8), 2064).
cell((5, 9), 0).
cell((6, 0), 0).
cell((6, 1), 32800).
cell((6, 2), 0).
cell((6, 3), 49186).
cell((6, 4), 1025).
cell((6, 5), 34864).
cell((6, 6), 0).
cell((6, 7), 0).
cell((6, 8), 32800).
cell((6, 9), 0).
cell((7, 0), 0).
cell((7, 1), 32800).
cell((7, 2), 0).
cell((7, 3), 32800).
cell((7, 4), 0).
cell((7, 5), 32800).
cell((7, 6), 0).
cell((7, 7), 0).
cell((7, 8), 32800).
cell((7, 9), 0).
cell((8, 0), 0).
cell((8, 1), 16386).
cell((8, 2), 1025).
cell((8, 3), 4608).
cell((8, 4), 0).
cell((8, 5), 16386).
cell((8, 6), 1025).
cell((8, 7), 1025).
cell((8, 8), 4608).
cell((8, 9), 0).
cell((9, 0), 0).
cell((9, 1), 0).
cell((9, 2), 0).
cell((9, 3), 0).
cell((9, 4), 0).
cell((9, 5), 0).
cell((9, 6), 0).
cell((9, 7), 0).
cell((9, 8), 0).
cell((9, 9), 0).

% a bigger 10 x 10 environment

% conversion of the input to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

start_flat(TRAIN, Y * WIDTH + X, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION), grid_size(_, WIDTH).
end_flat(TRAIN, Y * WIDTH + X, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME), grid_size(_, WIDTH).

% decreasing the search space by describing the routes as tightly as possible:

moment(TRAIN, 0..MAX_TIME-1) :- end(TRAIN, (_, _), MAX_TIME).

path(north, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(east, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 4608), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 4608), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(west, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 16386), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 16386), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(west, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 72), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 72), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(east, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 2064), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 2064), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(east, POSITION, turn_right, south, POSITION - WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, turn_left, north, POSITION + WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 6672), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(west, POSITION, turn_right, south, POSITION - WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(west, POSITION, turn_left, north, POSITION + WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, move_forward, west, POSITION + 1) :- cell_flat(POSITION, 16458), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 3089), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(east, POSITION, turn_left, north, POSITION + WIDTH) :- cell_flat(POSITION, 3089), grid_size(_, WIDTH), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path((south;west), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 3089), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path((north;west), POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_right, east, POSITION + 1) :- cell_flat(POSITION, 32872), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path((north;east), POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_right, west, POSITION - 1) :- cell_flat(POSITION, 34864), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, south, POSITION - WIDTH) :- cell_flat(POSITION, 5633), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path((north;west), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 20994), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(north, POSITION, turn_right, east, POSITION + 1) :- cell_flat(POSITION, 20994), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path((east;west), POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 20994), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, turn_left, south, POSITION - WIDTH) :- cell_flat(POSITION, 17411), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path((east;north), POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 37408), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 37408), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path((south;east), POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 37408), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION + WIDTH):- cell_flat(POSITION, 49186), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(north, POSITION, turn_right, east, POSITION + 1):- cell_flat(POSITION, 49186), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path((south; west), POSITION, move_forward, south, POSITION - WIDTH):- cell_flat(POSITION, 49186), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0. 
path(north, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0. 
path(north, POSITION, turn_right, west, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, east, POSITION - WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(south, POSITION, move_forward, south, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_left, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(north, POSITION, move_forward, north, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, turn_right, north, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, south, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(IN_DIR, POSITION, wait, IN_DIR, POSITION):- path(IN_DIR, POSITION, _, _, _).

% generating solution candidates over all possible routes and input train(s) / time:

1 { transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) : path(IN_DIR, FROM_POS, ACTION, OUT_DIR, TO_POS) } 1 :- train(TRAIN), moment(TRAIN, MOMENT).

% constraints:

% 1. Train must not jump between different cells, only moving by 1 cell at a moment of time:

:- transition(TRAIN, MOMENT, _, _, _, TO_POS, _), 
   transition(TRAIN, MOMENT+1, FROM_POS, _, _, _, _),
   FROM_POS != TO_POS.

:- transition(TRAIN, MOMENT, _, _, _, _, TO_DIR), 
   transition(TRAIN, MOMENT+1, _, IN_DIR, _, _, _),
   TO_DIR != IN_DIR.

% 2. The train must arrive at the destination:

:- transition(TRAIN,MOMENT,_,_,_,TO_POS,_),
   end_flat(TRAIN, ARRIVAL_POS, ARRIVAL_TIME),
   MOMENT == ARRIVAL_TIME-1,
   TO_POS != ARRIVAL_POS.

% 3. The train must start from the departure position:

:- start_flat(TRAIN, DEPARTURE_POS, DEPARTURE_TIME, _),
   transition(TRAIN, MOMENT, FROM_POS, IN_DIR, _, _, _),
   FROM_POS != DEPARTURE_POS,
   MOMENT == DEPARTURE_TIME.

% 4. The train must be directed correctly at the start:

:- start_flat(TRAIN, _, DEPARTURE_TIME, DEPARTURE_DIR), 
   transition(TRAIN, MOMENT, _, IN_DIR, _, _, _),
   IN_DIR != DEPARTURE_DIR,
   MOMENT == DEPARTURE_TIME.

% 5. Addressing jumping over the grid problem:

:- transition(_, _, FROM_POS, _, _, TO_POS, _),
   grid_size(_, WIDTH),
   FROM_POS = WIDTH,
   TO_POS = WIDTH - 1.

% 6. Prohibiting clashes:

:- transition(TRAIN_1, MOMENT, _, _, _, TO_POS, _),
   transition(TRAIN_2, MOMENT, _, _, _, TO_POS, _),
   TRAIN_1 != TRAIN_2.

% standardizing the output:

action(TRAIN, MOMENT, ACTION) :- transition(TRAIN,MOMENT, _, _, ACTION, _, _).

% displaying the output:

% #show action/3.
#show transition/7.
% #show path/5.
% #show end_flat/3.
% #show grid_size/2.
% #show cell_flat/2.
% #show start_flat/4.