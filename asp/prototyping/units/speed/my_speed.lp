train(1).
speed(1,4).
start(1, (2, 0), 0, north).
end(1, (0, 0), 8).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 0).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 0).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 0).

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

start_flat(TRAIN, Y * WIDTH + X, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION), grid_size(_, WIDTH).
end_flat(TRAIN, Y * WIDTH + X, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME), grid_size(_, WIDTH).

% decreasing the search space by describing the routes as tightly as possible:

action_moment(TRAIN, MOMENT) :- MOMENT = 0..MAX_TIME-1, 
                                 end(TRAIN, (_, _), MAX_TIME), 
                                 train(TRAIN), 
                                 speed(TRAIN, MOM_PER_POS),
                                 R = MOMENT - (MOMENT / MOM_PER_POS) * MOM_PER_POS,
                                 R == 0.

every_moment(TRAIN, 0..MAX_TIME-1) :- end(TRAIN, (_, _), MAX_TIME).

path(north, POSITION, move_forward, north, POSITION - WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.
path(south, POSITION, move_forward, south, POSITION + WIDTH) :- cell_flat(POSITION, 32800), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

% path(OUT_DIR, OUT_POS, wait, OUT_DIR, OUT_POS) :- start_flat(_, OUT_POS, _, OUT_DIR).

1 { action_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) : path(IN_DIR, FROM_POS, ACTION, OUT_DIR, TO_POS) } 1 :- train(TRAIN),
                                                                                                                                         action_moment(TRAIN, MOMENT).

intermediate_missing(TRAIN, MOMENT) :- every_moment(TRAIN, MOMENT), not action_moment(TRAIN, ACTION_MOMENT), MOMENT == ACTION_MOMENT.

margin(TRAIN, 1..SPEED) :- speed(TRAIN, SPEED), train(TRAIN).

laggy_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) :- intermediate_missing(TRAIN, MOMENT),
                                                                             action_transition(TRAIN, MOMENT-MARGIN, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR),
                                                                             margin(TRAIN, MARGIN).

transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR) :- action_transition(TRAIN, MOMENT, FROM_POS, IN_DIR, ACTION, TO_POS, OUT_DIR).

% constraints:

% 1. Train must not jump between different cells, only moving by 1 cell at a moment of time:

:- transition(TRAIN, MOMENT, _, _, _, TO_POS, _), 
   transition(TRAIN, MOMENT+1, FROM_POS, _, _, _, _),
   FROM_POS != TO_POS.

:- transition(TRAIN, MOMENT, _, _, _, _, TO_DIR), 
   transition(TRAIN, MOMENT+1, _, IN_DIR, _, _, _),
   TO_DIR != IN_DIR.

% 2. The train must arrive at the destination:

% creating auxiliary atoms to cater both for real and laggy transitions

reached(TRAIN, MOMENT+1) :- transition(TRAIN,MOMENT,_,_,_,TO_POS,_),
                            not laggy_transition(TRAIN,MOMENT+MARGIN,_,_,_,TO_POS,_),
                            margin(TRAIN, MARGIN),
                            end_flat(TRAIN, ARRIVAL_POS, _),
                            TO_POS == ARRIVAL_POS.

reached(TRAIN, MOMENT+1) :- laggy_transition(TRAIN,MOMENT,_,_,_,TO_POS,_),
                            not laggy_transition(TRAIN,MOMENT+1,_,_,_,TO_POS,_),
                            end_flat(TRAIN, ARRIVAL_POS, _),
                            TO_POS == ARRIVAL_POS.

:- end(TRAIN, (_, _), SCHEDULED_ARRIVAL), not reached(TRAIN, SCHEDULED_ARRIVAL).

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

% 7. Prohibiting the ghost train movement: 

:- transition(TRAIN_1, MOMENT, IN_POS, _, _ , OUT_POS, _),
   transition(TRAIN_2, MOMENT, OUT_POS, _, _, IN_POS, _ ),
   TRAIN_1 != TRAIN_2.

% standardizing the output:

action(TRAIN, MOMENT, ACTION) :- transition(TRAIN,MOMENT, _, _, ACTION, _, _).
action(TRAIN, MOMENT, ACTION) :- laggy_transition(TRAIN,MOMENT, _, _, ACTION, _, _).

% optimization imperative:

% #minimize {1,ID,A,T : action(ID,A,T)}.

% displaying the output:

% #show reached/2.
#show laggy_transition/7.
% #show intermediate_missing/2.
% #show action/3.
#show transition/7.
% #show path/5.
% #show is_junction/1.
% #show end_flat/3.
% #show grid_size/2.
% #show cell_flat/2.
% #show start_flat/4.
% #show mid_transition/7.