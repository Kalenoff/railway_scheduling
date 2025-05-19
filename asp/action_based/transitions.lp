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