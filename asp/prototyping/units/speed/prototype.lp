do(move_forward;wait;turn_right;turn_left).
dir(n;s;w;e).
all_time(6).
speed(2).
start((0,0), e).

moment(0..MAX_TIME-1) :- all_time(MAX_TIME).

action_moment(ACTION_MOMENT) :- ACTION_MOMENT = 0..MAX_TIME-1, 
                                all_time(MAX_TIME),
                                speed(MOM_PER_POS),
                                R = ACTION_MOMENT - (ACTION_MOMENT / MOM_PER_POS) * MOM_PER_POS,
                                R == 0.

% let's prescribe deltas that occur from actions, following Jonas approximately:

1{action_candidate(ACTION_MOMENT, DO) : do(DO)}1 :- action_moment(ACTION_MOMENT).

intermediate_missing(MOMENT) :- moment(MOMENT), not action_moment(ACTION_MOMENT), MOMENT == ACTION_MOMENT.

action(MOMENT, DO) :- action_candidate(MOMENT, DO).

diff_to_check(1..SPEED) :- speed(SPEED).

action(MOMENT, DO) :- action_candidate(MOMENT - DIFF_TO_CHECK, DO), intermediate_missing(MOMENT), diff_to_check(DIFF_TO_CHECK).

#show action/2.
#show offset/2.
% #show action_atom/2.
% #show action_moment/1.
% #show intermediate_missing/1.