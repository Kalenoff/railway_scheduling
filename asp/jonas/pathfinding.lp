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


#show at/5.
#show goal/2.
#show action/3.
%#show reached/2.
%#show time/1.
