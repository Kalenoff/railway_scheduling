% establish the real time scale:

every_moment(0..19).
action(move_forward; turn_left; turn_right; wait).

intermediate_missing(TRAIN, MOMENT) :- every_moment(MOMENT), not action_moment(TRAIN, ACTION_MOMENT), MOMENT == ACTION_MOMENT, speed(TRAIN, _).

% imitating the rule to create real transitions that only occur at action moments:

1{real_transition(TRAIN, MOMENT, ACTION) : action(ACTION)}1 :- action_moment(TRAIN, MOMENT).

% filling the gaps with laggy transitions:

lookback(1;2).

laggy_transition(TRAIN, MOMENT, ACTION) :- intermediate_missing(TRAIN, MOMENT),
                                           real_transition(TRAIN, MOMENT-LOOKBACK, ACTION),
                                           lookback(LOOKBACK).                                                                    

% create a laggy transtion.

#show intermediate_missing/2.
% #show real_transition/3.
% #show laggy_transition/3.