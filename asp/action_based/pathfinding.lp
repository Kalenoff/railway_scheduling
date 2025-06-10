dir(n;s;e;w). action_type(move_left;move_right;move_forwards;wait).

time(0..T) :- global(T).

% bind the global maxtime to the latest destination time
global(Max) :- Max = #max { T : end(_,_,T) }.

:- train(ID), not goal(ID,_).

at(ID,X,Y,T,Dir) :- move(ID,X,Y,T,Dir).
at(ID,X,Y,T,Dir) :- start(ID,(X,Y),T,Dir).
goal(ID,T) :- at(ID,X,Y,T,_), end(ID,(X,Y),MaxT), T <= MaxT. 

% check if a train has reached its goal
reached(ID,T) :- goal(ID,T2), time(T), train(ID), T > T2.

% do one action per timestep for each train that hasn't reached its goal
1 {action(train(ID),A,T) : action_type(A)} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T).

% declaring which tracks are either straights or turns
straight_or_turn(32800).
straight_or_turn(1025).
straight_or_turn(4608).
straight_or_turn(16386).
straight_or_turn(72).
straight_or_turn(2064).

% only generate move_forwards for straight or turn tracks
%1 {action(train(ID),move_forwards,T)} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T), at(ID,X,Y,T,Dir), cell((X,Y),C), straight_or_turn(C).

% generate all moves for all other tracks
%1 {action(train(ID),A,T) : action_type(A)} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T), at(ID,X,Y,T,Dir), cell((X,Y),C), not straight_or_turn(C).

% logic for waiting on any direction and track
%move(ID,X,Y,T+1,Dir) :- action(train(ID),wait,T), at(ID,X,Y,T,Dir), not goal(ID,T), cell((X,Y),_), time(T).

% only make it possible to wait if there is a train in front of you
:- action(train(ID),wait,T), at(ID,X,Y,T,s), not at(_,X+1,Y,T,_).
:- action(train(ID),wait,T), at(ID,X,Y,T,n), not at(_,X-1,Y,T,_).
:- action(train(ID),wait,T), at(ID,X,Y,T,e), not at(_,Y+1,Y,T,_).
:- action(train(ID),wait,T), at(ID,X,Y,T,w), not at(_,Y-1,Y,T,_).

% no moving straight on a turn
:- at(ID,X,Y,T,Dir), cell((X,Y),4068), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),16386), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),72), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),2064), move(ID,X2,Y2,T+1,Dir).

% no moving straight on a symmetrical switch
:- at(ID,X,Y,T,Dir), cell((X,Y),20994), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),2136), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),6672), move(ID,X2,Y2,T+1,Dir).
:- at(ID,X,Y,T,Dir), cell((X,Y),16458), move(ID,X2,Y2,T+1,Dir).

% no two trains on the same cell (at )the same time (no collisions)
:- at(ID1,X,Y,T,_), at(ID2,X,Y,T,_), ID1!=ID2.

% swapping conflict constraint
:- at(ID1,X1,Y1,T,_), at(ID2,X2,Y2,T,_), at(ID1,X2,Y2,T+1,_), at(ID2,X1,Y1,T+1,_), ID1!=ID2.

% prefer the solution with the least possible actions
%#minimize {1,ID,A,T : action(train(ID),A,T)}.


#show at/5.
#show goal/2.
#show action/3.
%#show reached/2.
%#show time/1.