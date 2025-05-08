% input (environment):

train(1).
start(1, (0, 0), 0, north).
end(1, (0, 2), 3).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 0).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 0).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 0).

% generator:

max_time(TRAIN, MAX_TIME) :- end(TRAIN, _, MAX_TIME).

moment(1..MAX_TIME) :- max_time(_, MAX_TIME).

cell_actions((Y,X), none) :- cell((X,Y), 0).
cell_actions((Y,X), (move_forward; wait)) :- cell((X,Y), (32800; 1025; 4608; 16386; 72; 2064)).
cell_actions((Y,X), (move_forward; move_left; wait)) :- cell((X,Y), (37408; 17411; 32872; 3089)).
cell_actions((Y,X), (move_forward; move_right; wait)) :- cell((X,Y), (49186; 1097; 34864; 5633)).
cell_actions((Y,X), (move_forward; wait)) :- cell((X,Y), 33825).
cell_actions((Y,X), (move_forward; move_left; wait)) :- cell((X,Y), (38433; 50211; 33897; 35889)).
cell_actions((Y,X), (move_forward; move_left; move_right; wait)) :- cell((X,Y), (38505; 52275)).
cell_actions((Y,X), (move_forward; move_left; move_right; wait)) :- cell((X,Y), (20994; 16458; 2136; 6672)).

{ dispatcher(TRAIN, POSITION, MOMENT, ACTION) : moment(MOMENT), train(TRAIN), cell(POSITION, TYPE),
 cell_actions(POSITION, ACTION), ACTION != none } = MAX_TIME :- max_time(TRAIN, MAX_TIME).

% constraints:

:- dispatcher(T, P1, M, A1), 
   dispatcher(T, P2, M, A2), 
   (P1, A1) < (P2, A2).

:- dispatcher(TRAIN, POSITION_1, 1, _),
   start(TRAIN, POSITION_2, _, _),
   POSITION_1 != POSITION_2.

#show dispatcher/4.