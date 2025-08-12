start(0, (0,0), 0, east).
end(0, (0,15), 20).
speed(0, 1).
train(0).

cell((0, 0), 1025).%0,1,2
cell((0, 1), 1025).%3,4
cell((0, 2), 1025).%5
cell((0, 3), 1025).%6
cell((0, 4), 1025).%7
cell((0, 5), 38505).%8
cell((0, 6), 1025).%9
cell((0, 7), 1025).%10
cell((0, 8), 1025).%11
cell((0, 9), 1025).%12
cell((0, 10), 38505).%13
cell((0, 11), 1025).%14
cell((0, 12), 1025).%15
cell((0, 13), 38505).%16
cell((0, 14), 1025).%17,18
cell((0, 15), 1025).%19,20,21

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
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

is_junction(POS) :- cell_flat(POS, TYPE), junction_type(TYPE).

junction_type(37408; 17411; 32872; 3089; 49186; 1097; 34864; 5633; 33825; 38433; 50211; 33897; 35889; 38505; 52275; 20994; 16458; 2136; 6672).

junction_in_between(FIRST, THIRD) :- is_junction(FIRST),
                                     is_junction(SECOND),
                                     is_junction(THIRD),
                                     SECOND < THIRD,
                                     SECOND > FIRST.
                                
junction_in_between(FIRST, THIRD) :- start_flat(_, FIRST, _, _),
                                     is_junction(SECOND),
                                     is_junction(THIRD),
                                     SECOND < THIRD,
                                     SECOND > FIRST.

junction_in_between(FIRST, THIRD) :-  end_flat(_, THIRD, _),
                                      is_junction(SECOND),
                                      is_junction(FIRST),
                                      SECOND < THIRD,
                                      SECOND > FIRST.

varying_speed_stretch(FIRST, SECOND) :- is_junction(FIRST),
                                        is_junction(SECOND),
                                        FIRST < SECOND,
                                        not junction_in_between(FIRST, SECOND).

fixed_speed_stretch(FIRST, SECOND) :- start_flat(_, FIRST, _, _),
                                      is_junction(SECOND),
                                      not junction_in_between(FIRST, SECOND).

fixed_speed_stretch(FIRST, SECOND) :- end_flat(_, SECOND, _),
                                      is_junction(FIRST),
                                      not junction_in_between(FIRST, SECOND).

speed_signal(drop_speed; keep_speed).

1{speed_control((FIRST, SECOND), SIGNAL): speed_signal(SIGNAL)}1 :- varying_speed_stretch(FIRST, SECOND).

speed_control((FIRST, SECOND), keep_speed) :- fixed_speed_stretch(FIRST, SECOND).

range(FIRST, SECOND) :- fixed_speed_stretch(FIRST, SECOND).
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

local_action_moment(ID, TRAIN, LOCAL_ACTION_MOMENT) :- speed_control((FIRST, SECOND), drop_speed), 
                                                             LENGTH = SECOND - FIRST,
                                                             speed(TRAIN, CRUISER_SPEED),
                                                             SPEED = CRUISER_SPEED + 1,
                                                             train(TRAIN),
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

% 3. The train must start from the departure position:

 :- start_flat(TRAIN, DEPARTURE_POS, DEPARTURE_TIME, _),
    real_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, _, _, _),
    FROM_POS != DEPARTURE_POS,
    MOMENT == DEPARTURE_TIME.

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

% #show is_junction/1.
% #show varying_speed_stretch/2.
% #show fixed_speed_stretch/2.
% #show junction_in_between/2.
% #show speed_control/2.
% #show local_action_moment/2.
% #show range/2.
% #show range_key/2.
% #show range_id/2.
% #show local_action_moment/2.
% #show action_moment_candidate/2.
% #show stretch_offset/2.
% #show action_moment/2.
#show real_transition/7.
#show laggy_transition/7.