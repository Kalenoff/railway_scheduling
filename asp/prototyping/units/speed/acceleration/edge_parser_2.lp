train(1).
% train(2).
start(1, (0, 0), 0, east).
start(2, (2, 0), 0, east).
end(1, (2, 0), 9).
end(2, (2, 5), 10).
speed(1, 1).
speed(2, 2).

cell((2,0), 1025).
cell((2,1), 1025).
cell((2,2), 3089).
cell((2,3), 1025).
cell((2,4), 1025).
cell((2,5), 1025).
cell((1,0), 0).
cell((1,1), 0).
cell((1,2), 32800).
cell((1,3), 0).
cell((1,4), 0).
cell((1,5), 0).
cell((0,0), 1025).
cell((0,1), 1025).
cell((0,2), 4608).
cell((0,3), 0).
cell((0,4), 0).
cell((0,5), 0).

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

varying_speed_stretch(POS1,POS2) :- undirected_edge(POS1,POS2).
fixed_speed_stretch() :- undirected_edge(POS1,POS2), .

speed_signal(drop_speed; keep_speed).

1{speed_control((FIRST, SECOND), SIGNAL): speed_signal(SIGNAL)}1 :- varying_speed_stretch(FIRST, SECOND).

range(FIRST, SECOND) :- varying_speed_stretch(FIRST, SECOND).
range_key(X*1000 + Y, (X,Y)) :- range(X,Y).
range_id(ID, (X,Y)) :- range_key(KEY, (X,Y)),
                       ID = #count {KEY2 : range_key(KEY2, _), KEY2 < KEY}.                                                              
                       
local_action_moment(ID, TRAIN, LOCAL_ACTION_MOMENT) :- speed_control((FIRST, SECOND), keep_speed), 
                                                       LENGTH = SECOND - FIRST,
                                                       train(TRAIN), 
                                                       speed(TRAIN, SPEED),
                                                       UPPER_BOUND = LENGTH * SPEED - SPEED,
                                                       LOCAL_ACTION_MOMENT = 0..UPPER_BOUND,
                                                       LOCAL_ACTION_MOMENT \ SPEED = 0,
                                                       range_id(ID, (FIRST, SECOND)).
                                                       
action_moment_candidate(STRETCH_ID, TRAIN, MOMENT_ID) :- local_action_moment(STRETCH_ID, TRAIN, MOMENT_ID),
                                                         not local_action_moment(STRETCH_ID - 1, TRAIN, _).

stretch_offset(STRETCH_ID, OFFSET) :- action_moment_candidate(STRETCH_ID, _, _),
                                      LAST_ID = #max{VAL : action_moment_candidate(STRETCH_ID, _, VAL)},
                                      OFFSET = LAST_ID + 1.

action_moment_candidate(STRETCH_ID, TRAIN, GLOBAL_MOMENT_ID) :- local_action_moment(STRETCH_ID, TRAIN, LOCAL_MOMENT_ID),
                                                                stretch_offset(STRETCH_ID-1, OFFSET),
                                                                GLOBAL_MOMENT_ID = LOCAL_MOMENT_ID + OFFSET.

action_moment(TRAIN, GLOBAL_MOMENT_ID) :- action_moment_candidate(_, TRAIN, GLOBAL_MOMENT_ID).

1 { real_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) : path(IN_DIR, FROM_POS, ACTION, OUT_DIR, TO_POS) } 1 :- train(TRAIN),
                                                                                                                                       action_moment(TRAIN, MOMENT).

intermediate_missing(TRAIN, MOMENT) :- every_moment(TRAIN, MOMENT), not action_moment(TRAIN, ACTION_MOMENT), MOMENT == ACTION_MOMENT.

laggy_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) :- intermediate_missing(TRAIN, MOMENT),
                                                                              real_transition(TRAIN, MOMENT-1, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR).

laggy_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) :- intermediate_missing(TRAIN, MOMENT),
                                                                              not real_transition(TRAIN, MOMENT-1, _, _, _, _, _),
                                                                              real_transition(TRAIN, MOMENT-2, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR).

% 1. Train must not jump between different cells, only moving by 1 cell at a moment of time:

:- real_transition(TRAIN, MOMENT, _, _, _, TO_POS, _), 
   real_transition(TRAIN, MOMENT+1, FROM_POS, _, _, _, _),
   FROM_POS != TO_POS.

:- real_transition(TRAIN, MOMENT, _, _, _, _, TO_DIR), 
   real_transition(TRAIN, MOMENT+1, _, IN_DIR, _, _, _),
   TO_DIR != IN_DIR.

:- laggy_transition(TRAIN, MOMENT, _, _, _, OUT_POS, _),
   real_transition(TRAIN, MOMENT+1, IN_POS, _, _, _, _),
   IN_POS != OUT_POS.

:- laggy_transition(TRAIN, MOMENT, _, _, _, _, OUT_DIR),
    real_transition(TRAIN, MOMENT+1, _, IN_DIR, _, _, _),
    OUT_DIR != IN_DIR.

% 2. The train must arrive at the destination:

% creating auxiliary atoms to cater both for real and laggy transitions

lookback(1;2;3).

reached(TRAIN, MOMENT+1) :- laggy_transition(TRAIN,MOMENT,_,_,_,TO_POS,_),
                            not laggy_transition(TRAIN,MOMENT+1,_,_,_,TO_POS,_),
                            end_flat(TRAIN, ARRIVAL_POS, _),
                            TO_POS == ARRIVAL_POS.

:- end(TRAIN, (_, _), _), not reached(TRAIN, _).


% 4. The train must be directed correctly at the start:

:- start_flat(TRAIN, _, DEPARTURE_TIME, DEPARTURE_DIR), 
   real_transition(TRAIN, MOMENT, _, IN_DIR, _, _, _),
   IN_DIR != DEPARTURE_DIR,
   MOMENT == DEPARTURE_TIME.

% 5. Addressing jumping over the grid problem:

:- real_transition(_, _, FROM_POS, _, _, TO_POS, _),
   grid_size(_, WIDTH),
   FROM_POS = WIDTH,
   TO_POS = WIDTH - 1.

% 6. Prohibiting clashes:

:- real_transition(TRAIN_1, MOMENT, _, _, _, TO_POS, _),
   real_transition(TRAIN_2, MOMENT, _, _, _, TO_POS, _),
    TRAIN_1 != TRAIN_2.

% 7. Prohibiting the ghost train movement: 

:- real_transition(TRAIN_1, MOMENT, IN_POS, _, _ , OUT_POS, _),
   real_transition(TRAIN_2, MOMENT, OUT_POS, _, _, IN_POS, _ ),
   TRAIN_1 != TRAIN_2.

% #show is_junction/2.
% #show junction_between/2.
% show gap_between/2.
% #show edge_candidate/2.
% #show edge/2.
% #show edge_flat/2.
% #show undirected_edge/2.
% #show varying_speed_stretch/2.
% #show speed_control/2.
% #show varying_speed_stretch/2.
% #show range_id/2.
% #show local_action_moment/3.
% #show action_moment_candidate/3.
#show real_transition/7.
#show laggy_transition/7.
% #show intermediate_missing/2.