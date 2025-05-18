global(100). dir(n;s;e;w). action_type(move_left;move_right;move_forwards;wait).

time(0..T) :- global(T).

at(ID,X,Y,T,Dir) :- move(ID,X,Y,T,Dir).
at(ID,X,Y,T,Dir) :- start(ID,(X,Y),T,Dir).
goal(ID,T) :- at(ID,X,Y,T,_), end(ID,(X,Y),MaxT), T < MaxT.

% check if a train has reached its goal
reached(ID,T) :- goal(ID,T2), time(T), train(ID), T > T2.

% do one action per timestep for each train that hasn't reached its goal
1 {action(train(ID),A,T) : action_type(A)} 1 :- train(ID), time(T), not goal(ID,T), not reached(ID,T).

% ignore all cells in the environment which have track number 0
%valid_cell((X,Y)) :- cell((X,Y)), T != 0.

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

% force the trains to reach its destination
:- end(ID,(X,Y),T), not goal(ID,T).

% no two trains on the same cell (at )the same time (no collisions)
:- at(ID1,X,Y,T,_), at(ID2,X,Y,T,_), ID1!=ID2.

% prefer the solution with the least possible actions
#minimize {1,ID,A,T : action(train(ID),A,T)}.

% prefer the solution with the least possible time (still dont know if this really works)
%#minimize {1,T : time(T)}.


%#show at/5.
#show goal/2.
#show action/3.
%#show reached/2

