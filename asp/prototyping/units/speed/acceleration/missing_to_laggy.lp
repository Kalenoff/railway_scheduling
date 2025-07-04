% establish the real time scale:

every_moment(0..13).
action(move_forward; turn_left; turn_right; wait).

% establish the action time scale (by hand in this case):

action_moment(0).
% action_moment(1).
% action_moment(2).
action_moment(3).
% action_moment(4).
action_moment(5).
action_moment(6).
action_moment(7).
action_moment(8).
action_moment(9).
% action_moment(10).
action_moment(11).
% action_moment(12).
% action_moment(13).

% zip them together to identify gaps:

intermediate_missing(MOMENT) :- every_moment(MOMENT), not action_moment(ACTION_MOMENT), MOMENT == ACTION_MOMENT.

% imitating the rule to create real transitions that only occur at action moments:

1{real_transition(MOMENT, ACTION) : action(ACTION)}1 :- action_moment(MOMENT).

% filling the gaps with laggy transitions:

lookback(1;2).

laggy_transition(MOMENT, ACTION) :- intermediate_missing(MOMENT),
                                    real_transition(MOMENT-LOOKBACK, ACTION),
                                    lookback(LOOKBACK).                                                                        

% create a laggy transtion.

% #show intermediate_missing/1.
#show real_transition/2.
#show laggy_transition/2.