% the input:

train(1).
speed(1,1).
start(1, (2, 0), 0, n).
end(1, (0, 0), 2).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 0).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 0).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 0).

% the logic:

dir(n;s;e;w). action_type(move_left;move_right;move_forwards;wait).

time(0..T) :- global(T).

% bind the global maxtime to the latest arrival time
global(Max) :- Max = #max { T : end(_,(_,_),T) }.

:- train(ID), not goal(ID,_).

at(ID,X,Y,T,Dir) :- move(ID,X,Y,T,Dir).
at(ID,X,Y,T,Dir) :- start(ID,(X,Y),T,Dir).
goal(ID,T) :- at(ID,X,Y,T,_), end(ID,(X,Y),MaxT), T <= MaxT. 

% whenever a train waits, it stays in the same spot as in the last timestep
at(ID,X,Y,T+1,Dir) :- action(train(ID),wait,T), at(ID,X,Y,T,Dir), cell((X,Y),_), time(T).

% offsets for each direction
offset(n,-1,0).
offset(n,-1,-1).
offset(n,-1,1).

offset(s,1,0).
offset(s,1,-1).
offset(s,1,1).

offset(e,0,1).
offset(e,-1,1).
offset(e,1,1).

offset(w,0,-1).
offset(w,-1,-1).
offset(w,1,-1).
    
% check if a train has reached its goal
reached(ID,T) :- goal(ID,T2), time(T), train(ID), T > T2.

% do one action per timestep for each train that hasn't reached its goal
1 {action(train(ID),A,T) : action_type(A), A!=wait; action(train(ID),wait,T) : at(ID,X,Y,T,Dir), offset(Dir,DX,DY), at(ID2,X+DX,Y+DY,T,_), ID > ID2} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T).

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

% no two trains on the same cell at the same time (no collisions)
:- at(ID1,X,Y,T,_), at(ID2,X,Y,T,_), ID1!=ID2.

% swapping conflict constraint
:- at(ID1,X1,Y1,T,_), at(ID2,X2,Y2,T,_), at(ID1,X2,Y2,T+1,_), at(ID2,X1,Y1,T+1,_), ID1!=ID2.

% prefer the solution with the least possible actions
#minimize {1,ID,A,T : action(train(ID),A,T)}.

% movement rules
% logic for moving forwards on a horizontal track facing east and west
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),1025), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),1025), cell((X,Y-1),_), time(T), dir(w).

% logic for moving forwards on a vertical track facing north and south
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),32800), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),32800), cell((X+1,Y),_), time(T), dir(s).


% turns
% move left and right while facing east
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),2064), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),4608), cell((X+1,Y),_), time(T), dir(s).

% move left and right while facing west
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),16386), cell((X+1,Y),_), time(T), dir(s).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),72), cell((X-1,Y),_), time(T), dir(n).

% move left and right while facing north
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),4608), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),16386), cell((X,Y+1),_), time(T), dir(e).

% move left and right while facing south
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),72), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),2064), cell((X,Y-1),_), time(T), dir(w).


% symmetrical switch
% logic for symmetrical switch facing north track 20994
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),20994), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_right,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),20994), cell((X,Y+1),_), time(T), dir(e).

% logic for symmetrical switch facing south track 
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_left,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),2136), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_right,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),2136), cell((X,Y-1),_), time(T), dir(w).

% logic for symmetrical switch facing east
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_left,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),6672), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_right,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),6672), cell((X+1,Y),_), time(T), dir(s).

% logic for symmetrical switch facing west
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_left,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),16458), cell((X+1,Y),_), time(T), dir(s).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),16458), cell((X-1,Y),_), time(T), dir(n).


% simple switch
% 37408
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),37408), cell((X-1,Y),_), time(T), dir(n).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),37408), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),37408), cell((X+1,Y),_), time(T), dir(s).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),37408), cell((X+1,Y),_), time(T), dir(s).

% 49186
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),49186), cell((X-1,Y),_), time(T), dir(n).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_right,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),49186), cell((X,Y+1),_), time(T), dir(e).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),49186), cell((X+1,Y),_), time(T), dir(s).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),49186), cell((X+1,Y),_), time(T), dir(s).

% 32872
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),32872), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_left,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),32872), cell((X,Y+1),_), time(T), dir(e).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),32872), cell((X-1,Y),_), time(T), dir(n).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),32872), cell((X-1,Y),_), time(T), dir(n).

% 34864
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),34864), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_right,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),34864), cell((X,Y-1),_), time(T), dir(w).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),34864), cell((X-1,Y),_), time(T), dir(n).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),34864), cell((X-1,Y),_), time(T), dir(n).

% 3089
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),3089), cell((X,Y+1),_), time(T), dir(e).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_left,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),3089), cell((X-1,Y),_), time(T), dir(n).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),3089), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),3089), cell((X,Y-1),_), time(T), dir(w).

% 5633
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),5633), cell((X,Y+1),_), time(T), dir(e).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_right,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),5633), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),5633), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),5633), cell((X,Y-1),_), time(T), dir(w).

% 17411
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),17411), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_left,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),17411), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),17411), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),17411), cell((X,Y+1),_), time(T), dir(e).

% 1097
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),1097), cell((X,Y-1),_), time(T), dir(w).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),1097), cell((X-1,Y),_), time(T), dir(n).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),1097), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),1097), cell((X,Y+1),_), time(T), dir(e).


% diamond crossing
% 33825
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),33825), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),33825), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),33825), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),33825), cell((X,Y-1),_), time(T), dir(w).


% single slip switch
% 38433
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),38433), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),38433), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),38433), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),38433), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T),     at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),38433), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_right,T),    at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),38433), cell((X+1,Y),_), time(T), dir(s).

% 50211
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),50211), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),50211), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),50211), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),50211), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_left,T),     at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),50211), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_right,T),    at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),50211), cell((X,Y+1),_), time(T), dir(e).

% 33897
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),33897), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),33897), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),33897), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),33897), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_left,T),     at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),33897), cell((X,Y+1),_), time(T), dir(e).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T),    at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),33897), cell((X-1,Y),_), time(T), dir(n).

% 35889
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),35889), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),35889), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),35889), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),35889), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T),     at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),35889), cell((X,Y-1),_), time(T), dir(w).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T),    at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),35889), cell((X-1,Y),_), time(T), dir(n).


% double-slip switch
% 38505
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),38505), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),38505), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),38505), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),38505), cell((X,Y-1),_), time(T), dir(w).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T),     at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),38505), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_right,T),    at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),38505), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_left,T),     at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),38505), cell((X,Y+1),_), time(T), dir(e).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T),    at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),38505), cell((X-1,Y),_), time(T), dir(n).

% 52275
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),52275), cell((X-1,Y),_), time(T), dir(n).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),52275), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),52275), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_forwards,T), at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),52275), cell((X,Y-1),_), time(T), dir(w).
move(ID,X+1,Y,T+1,s) :- action(train(ID), move_left,T),     at(ID,X,Y,T,w), not goal(ID,T), cell((X,Y),52275), cell((X+1,Y),_), time(T), dir(s).
move(ID,X,Y+1,T+1,e) :- action(train(ID), move_right,T),    at(ID,X,Y,T,n), not goal(ID,T), cell((X,Y),52275), cell((X,Y+1),_), time(T), dir(e).
move(ID,X,Y-1,T+1,w) :- action(train(ID), move_left,T),     at(ID,X,Y,T,s), not goal(ID,T), cell((X,Y),52275), cell((X,Y-1),_), time(T), dir(w).
move(ID,X-1,Y,T+1,n) :- action(train(ID), move_right,T),    at(ID,X,Y,T,e), not goal(ID,T), cell((X,Y),52275), cell((X-1,Y),_), time(T), dir(n).

#show at/5.
% #show goal/2.
% #show action/3.
%#show reached/2.
%#show time/1.
