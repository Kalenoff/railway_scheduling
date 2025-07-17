% input speed atoms:

speed(0, 2).
max_time(0, 17).

% creating the base case:

action_moment(TRAIN, 0) :- speed(TRAIN, _).

% for the ICE:

action_moment(TRAIN, 3) :- speed(TRAIN, 1), action_moment(TRAIN, 0).

action_moment(TRAIN, 5) :- speed(TRAIN, 1), action_moment(TRAIN, 3).

action_moment(TRAIN, NEXT_ACTION_MOMENT) :- speed(TRAIN, 1), action_moment(TRAIN, PREV_ACT_MOMENT),
                                            max_time(TRAIN, MAX_TIME),
                                            PREV_ACT_MOMENT >= 5,
                                            max_time(TRAIN, MAX_TIME),
                                            NEXT_ACTION_MOMENT = PREV_ACT_MOMENT + 1,
                                            braking_time(TRAIN, BRAKING_TIME),
                                            NEXT_ACTION_MOMENT < MAX_TIME - BRAKING_TIME + 1.

start_braking(TRAIN, ACTION_MOMENT) :- max_time(TRAIN, MAX_TIME),
                                       speed(TRAIN, 1),
                                       braking_time(TRAIN, BRAKING_TIME),
                                       action_moment(TRAIN, ACTION_MOMENT), 
                                       ACTION_MOMENT == MAX_TIME - BRAKING_TIME.

action_moment(TRAIN, START_BRK_MOM + 2) :- start_braking(TRAIN, START_BRK_MOM), speed(TRAIN, 1).
action_moment(TRAIN, START_BRK_MOM + 5) :- start_braking(TRAIN, START_BRK_MOM), speed(TRAIN, 1).

% for the local:

action_moment(TRAIN, 3) :- speed(TRAIN, 2), action_moment(TRAIN, 0).

action_moment(TRAIN, NEXT_ACTION_MOMENT) :- speed(TRAIN, 2), action_moment(TRAIN, PREV_ACT_MOMENT),
                                            max_time(TRAIN, MAX_TIME),
                                            PREV_ACT_MOMENT >= 3,
                                            NEXT_ACTION_MOMENT = PREV_ACT_MOMENT + 2,
                                            braking_time(TRAIN, BRAKING_TIME),
                                            NEXT_ACTION_MOMENT < MAX_TIME - BRAKING_TIME + 1.

start_braking(TRAIN, ACTION_MOMENT) :- max_time(TRAIN, MAX_TIME),
                                       MAX_TIME \ 2 == 0,
                                       speed(TRAIN, 2),
                                       braking_time(TRAIN, BRAKING_TIME),
                                       action_moment(TRAIN, ACTION_MOMENT), 
                                       ACTION_MOMENT == MAX_TIME - BRAKING_TIME.

start_braking(TRAIN, ACTION_MOMENT) :- max_time(TRAIN, MAX_TIME),
                                       speed(TRAIN, 2),
                                       MAX_TIME \ 2 != 0,
                                       braking_time(TRAIN, BRAKING_TIME),
                                       action_moment(TRAIN, ACTION_MOMENT), 
                                       ACTION_MOMENT == MAX_TIME - BRAKING_TIME - 1.

action_moment(TRAIN, START_BRK_MOM + 3) :- start_braking(TRAIN, START_BRK_MOM), 
                                           speed(TRAIN, 2), 
                                           max_time(TRAIN, MAX_TIME),
                                           MAX_TIME \ 2 == 0.

action_moment(TRAIN, START_BRK_MOM + 4) :- start_braking(TRAIN, START_BRK_MOM), 
                                           speed(TRAIN, 2), 
                                           max_time(TRAIN, MAX_TIME),
                                           MAX_TIME \ 2 != 0.

% for the freight:

action_moment(TRAIN, NEXT_ACTION_MOMENT) :- speed(TRAIN, 3), 
                                            action_moment(TRAIN, PREV_ACT_MOMENT),
                                            max_time(TRAIN, MAX_TIME),
                                            PREV_ACT_MOMENT >= 0,
                                            NEXT_ACTION_MOMENT = PREV_ACT_MOMENT + 3,
                                            braking_time(TRAIN, BRAKING_TIME),
                                            NEXT_ACTION_MOMENT < MAX_TIME - BRAKING_TIME + 1.

% extracting the braking time from the train type:

braking_time(TRAIN, 5) :- speed(TRAIN, 1).
braking_time(TRAIN, 3) :- speed(TRAIN, 2).
braking_time(TRAIN, 0) :- speed(TRAIN, 3).

#show action_moment/2.
% #show braking_time/2.
% #show max_time/2.
% #show start_braking/2.