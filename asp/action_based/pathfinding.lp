dir(n;s;e;w). action_type(move_left;move_right;move_forwards;wait).

time(0..T) :- global(T).

at(ID,X,Y,T,Dir) :- move(ID,X,Y,T,Dir).
at(ID,X,Y,T,Dir) :- start(ID,(X,Y),T,Dir).
goal(ID,T) :- at(ID,X,Y,T,_), end(ID,(X,Y),MaxT), T <= MaxT. 

% check if a train has reached its goal
reached(ID,T) :- goal(ID,T2), time(T), train(ID), T > T2.

% do one action per timestep for each train that hasn't reached its goal
1 {action(train(ID),A,T) : action_type(A)} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T).

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

% TODO implement swapping conflict constraint
:- at(ID1,X1,Y1,T,_), at(ID2,X2,Y2,T,_), at(ID1,X2,Y2,T+1,_), at(ID2,X1,Y1,T+1,_), ID1!=ID2.

% prefer the solution with the least possible actions
%#minimize {1,ID,A,T : action(train(ID),A,T)}.

% ignore all cells in the environment which have track number 0 (dont think this is needed because i explicitly name track types)
%valid_cell((X,Y)) :- cell((X,Y),T), T != 0.

% prefer the solution with the least possible time (still dont know if this really works)
%#minimize {1,T : time(T)}.

% you are not allowed to wait if another move is possible (still dont know if this really works)
%:- action(train(ID),wait,T), at(ID,X,Y,T,Dir), not goal(ID,T), cell((X,Y),_), time(T), action(A), A!=wait.

% logic for waiting on any direction and track
move(ID,X,Y,T+1,Dir) :- action(train(ID),wait,T), at(ID,X,Y,T,Dir), not goal(ID,T), cell((X,Y),_), time(T).

%#show at/5.
#show goal/2.
#show action/3.
%#show reached/2.
%#show time/1.