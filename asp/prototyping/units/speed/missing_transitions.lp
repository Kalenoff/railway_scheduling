% action_atom(0, a). action_atom(2, b). action_atom(4, c). action_atom(6, d).

attr(a;b;c;d).
all_time(6).
speed(3).

moment(0..MAX_TIME-1) :- all_time(MAX_TIME).

action_moment(ACTION_MOMENT) :- ACTION_MOMENT = 0..MAX_TIME-1, 
                                all_time(MAX_TIME),
                                speed(MOM_PER_POS),
                                R = ACTION_MOMENT - (ACTION_MOMENT / MOM_PER_POS) * MOM_PER_POS,
                                R == 0.

1{action_atom(ACTION_MOMENT, ATTR) : attr(ATTR)}1 :- action_moment(ACTION_MOMENT).

intermediate_missing(MOMENT) :- moment(MOMENT), not action_moment(ACTION_MOMENT), MOMENT == ACTION_MOMENT.

atom(MOMENT, ATTR) :- action_atom(MOMENT, ATTR).

diff_to_check(1..SPEED) :- speed(SPEED).

atom(MOMENT, ATTR) :- action_atom(MOMENT - DIFF_TO_CHECK, ATTR), intermediate_missing(MOMENT), diff_to_check(DIFF_TO_CHECK).

#show atom/2.
% #show action_atom/2.
% #show action_moment/1.
% #show intermediate_missing/1.