start(0, (0,0), 0, east).
end(0, (0,15), 20).
speed(0, 1).
train(0).

cell((0, 0), 1025).
cell((0, 1), 1025).
cell((0, 2), 1025).
cell((0, 3), 1025).
cell((0, 4), 1025).
cell((0, 5), 38505).
cell((0, 6), 1025).
cell((0, 7), 1025).
cell((0, 8), 1025).
cell((0, 9), 1025).
cell((0, 10), 1025).
cell((0, 11), 38505).
cell((0, 12), 1025).
cell((0, 13), 1025).
cell((0, 14), 38505).
cell((0, 15), 1025).
cell((0, 16), 1025).

cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

start_flat(TRAIN, Y * WIDTH + X, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION), grid_size(_, WIDTH).
end_flat(TRAIN, Y * WIDTH + X, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME), grid_size(_, WIDTH).

max_time(TRAIN, MAX_TIME) :- end(TRAIN, _, MAX_TIME).
every_moment(TRAIN, 0..MAX_TIME-1) :- end(TRAIN, (_, _), MAX_TIME).

path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 1025), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(east, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 4608), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(north, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 4608), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(west, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 16386), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(north, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 16386), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(west, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 72), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 72), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(east, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 2064), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 2064), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(east, POSITION, turn_right, south, POSITION + WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(east, POSITION, turn_left, north, POSITION - WIDTH) :- cell_flat(POSITION, 6672), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 6672), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(west, POSITION, turn_right, south, POSITION + WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(west, POSITION, turn_left, north, POSITION - WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path((south;north), POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 16458), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 3089), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(east, POSITION, turn_left, north, POSITION - WIDTH) :- cell_flat(POSITION, 3089), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path((south;west), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 3089), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path((north;west), POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 32872), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_right, east, POSITION + 1) :- cell_flat(POSITION, 32872), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path((north;east), POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 34864), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_right, west, POSITION - 1) :- cell_flat(POSITION, 34864), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, south, POSITION + WIDTH) :- cell_flat(POSITION, 5633), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((north;west), POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 5633), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 20994), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(north, POSITION, turn_right, east, POSITION + 1) :- cell_flat(POSITION, 20994), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path((east;west), POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 20994), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, turn_left, south, POSITION + WIDTH) :- cell_flat(POSITION, 17411), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path((east;north), POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 17411), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 37408), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 37408), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path((south; east), POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 37408), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 49186), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(north, POSITION, turn_right, east, POSITION + 1) :- cell_flat(POSITION, 49186), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path((south; west), POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 49186), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(west, POSITION, turn_right, north, POSITION - WIDTH) :- cell_flat(POSITION, 1097), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 1097), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path((east; south), POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 1097), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 33825), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 33825), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0. 
path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0. 
path(north, POSITION, turn_right, west, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, east, POSITION + WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 35889), cell_flat(POSITION + 1, TYPE), TYPE != 0.
path(east, POSITION, turn_left, north, POSITION - WIDTH) :- cell_flat(POSITION, 35889), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 35889), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.
path(south, POSITION, turn_right, west, POSITION - 1) :- cell_flat(POSITION, 35889), cell_flat(POSITION - 1, TYPE), TYPE != 0.
path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 35889), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 35889), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(south, POSITION, turn_left, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.
path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(north, POSITION, turn_left, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(west, POSITION, turn_right, north, POSITION - WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.
path(west, POSITION, move_forward, west, POSITION - 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION - 1), TYPE), TYPE != 0.
path(east, POSITION, turn_right, south, POSITION + WIDTH) :- cell_flat(POSITION, 38505), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.
path(east, POSITION, move_forward, east, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.

junction_type(37408; 17411; 32872; 3089; 49186; 1097; 34864; 5633; 33825; 38433; 50211; 33897; 35889; 38505; 52275; 20994; 16458; 2136; 6672).

path(IN_DIR, IN_POS, wait, IN_DIR, IN_POS) :- path(IN_DIR, IN_POS, _, OUT_DIR, OUT_POS), path(OUT_DIR, OUT_POS, _, _, _), junction_type(OUT_POS).

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.

edge_type(1025; 32800).
no_track_type(0).

is_junction(Y,X) :- cell((Y,X), 1025), not cell((Y,X-1), _).
is_junction(Y,X) :- cell((Y,X), 1025), not cell((Y,X+1), _).

is_junction(Y,X) :- cell((Y,X), TYPE), 
                    not edge_type(TYPE),
                    not no_track_type(TYPE).

junction_between((Y,X1),(Y,X3)) :-  is_junction(Y,X1),
                                    is_junction(Y,X2),
                                    is_junction(Y,X3),
                                    X1 < X2,
                                    X2 < X3.
                                    
junction_between((Y,X1),(Y,X3)) :-  is_junction(Y,X1),
                                    is_junction(Y,X2),
                                    is_junction(Y,X3),
                                    X1 > X2,
                                    X2 > X3.    

junction_between((Y1,X),(Y3,X)) :-  is_junction(Y1,X),
                                    is_junction(Y2,X),
                                    is_junction(Y3,X),
                                    Y1 < Y2,
                                    Y2 < Y3.

junction_between((Y1,X),(Y3,X)) :-  is_junction(Y1,X),
                                    is_junction(Y2,X),
                                    is_junction(Y3,X),
                                    Y1 > Y2,
                                    Y2 > Y3.

gap_between((Y,X1),(Y,X3)) :- is_junction(Y,X1),
                              cell((Y,X2), 0),
                              is_junction(Y,X3),
                              X1 < X2,
                              X2 < X3.

gap_between((Y,X1),(Y,X3)) :- is_junction(Y,X1),
                              cell((Y,X2), 0),
                              is_junction(Y,X3),
                              X1 > X2,
                              X2 > X3.

gap_between((Y1,X),(Y3,X)) :- is_junction(Y1,X),
                              cell((Y2,X), 0),
                              is_junction(Y3,X),
                              Y1 < Y2,
                              Y2 < Y3.

gap_between((Y1,X),(Y3,X)) :- is_junction(Y1,X),
                              cell((Y2,X), 0),
                              is_junction(Y3,X),
                              Y1 > Y2,
                              Y2 > Y3.

edge_candidate((Y,X1),(Y,X2)) :- is_junction(Y,X1),
                                 is_junction(Y,X2).

edge_candidate((Y1,X),(Y2,X)) :- is_junction(Y1,X),
                                 is_junction(Y2,X).

edge((Y,X1), (Y,X2)) :- edge_candidate((Y,X1), (Y,X2)),
                        not gap_between((Y,X1), (Y,X2)),
                        not junction_between((Y,X1), (Y,X2)),
                        X1 != X2.

edge((Y1,X), (Y2,X)) :- edge_candidate((Y1,X), (Y2,X)),
                        not gap_between((Y1,X), (Y2,X)),
                        not junction_between((Y1,X), (Y2,X)),
                        Y1 != Y2.

edge_flat(Y1 * WIDTH + X1, Y2 * WIDTH + X2) :- edge((Y1,X1),(Y2,X2)),
                                               grid_size(_, WIDTH). 

undirected_edge(X,Y) :- edge_flat(X,Y),edge_flat(Y,X), X < Y.

varying_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), not fixed_speed_stretch(TRAIN, (POS1,POS2)).
fixed_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), start_flat(TRAIN, POS1, _, _).
fixed_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), start_flat(TRAIN, POS2, _, _).
fixed_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), end_flat(TRAIN, POS2, _).
fixed_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), end_flat(TRAIN, POS1, _).
fixed_speed_stretch(TRAIN, (POS1,POS2)) :- undirected_edge(POS1,POS2), train(TRAIN), |POS1-POS2| < 2.

speed_signal(drop_speed; keep_speed).

1{speed_control(TRAIN, (FIRST, SECOND), SIGNAL): speed_signal(SIGNAL)}1 :- varying_speed_stretch(TRAIN, (FIRST, SECOND)).

speed_control(TRAIN, (FIRST, SECOND), keep_speed) :- fixed_speed_stretch(TRAIN, (FIRST, SECOND)).

local_action_moment((FIRST,SECOND), TRAIN, LOCAL_ACTION_MOMENT) :- speed_control(TRAIN, (FIRST, SECOND), keep_speed), 
                                                                   LENGTH = SECOND - FIRST,
                                                                   speed(TRAIN, SPEED),
                                                                   UPPER_BOUND = LENGTH * SPEED - SPEED,
                                                                   LOCAL_ACTION_MOMENT = 0..UPPER_BOUND,
                                                                   LOCAL_ACTION_MOMENT \ SPEED = 0.

local_action_moment((FIRST,SECOND), TRAIN, LOCAL_ACTION_MOMENT) :- speed_control(TRAIN, (FIRST, SECOND), drop_speed), 
                                                                   LENGTH = SECOND - FIRST,
                                                                   speed(TRAIN, CRUISER_SPEED),
                                                                   CRUISER_SPEED = SPEED + 1,
                                                                   UPPER_BOUND = LENGTH * SPEED - SPEED,
                                                                   LOCAL_ACTION_MOMENT = 0..UPPER_BOUND,
                                                                   LOCAL_ACTION_MOMENT \ SPEED = 0.



% #show is_junction/2.
% #show junction_between/2.
% show gap_between/2.
% #show edge_candidate/2.
% #show edge/2.
% #show edge_flat/2.
% #show varying_speed_stretch/2.
% #show fixed_speed_stretch/2.
% #show speed_control/3.
#show local_action_moment/3.
