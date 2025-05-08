% input (standard format facts):

train(1).
train(2).
start(1, (2, 0), 0, east).
start(2, (0, 0), 0, east).
end(1, (0, 0), 3).
end(2, (0, 5), 3).

cell((0,0), 1025).
cell((0,1), 1025).
cell((0,2), 3089).
cell((0,3), 1025).
cell((0,4), 1025).
cell((0,5), 1025).
cell((1,0), 0).
cell((1,1), 0).
cell((1,2), 32800).
cell((1,3), 0).
cell((1,4), 0).
cell((1,5), 0).
cell((2,0), 1025).
cell((2,1), 1025).
cell((2,2), 4608).
cell((2,3), 0).
cell((2,4), 0).
cell((2,5), 0).

% conversion to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.

position(Y*10 + X) :- cell((Y, X), _).

flat_id(P, I) :- position(P), I = #count { Q : position(Q), Q < P }.

cell_flat(POSITION, TYPE) :- cell((Y,X), TYPE), flat_id(Y*10+X, POSITION).

start_flat(TRAIN, FLAT_POS, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION),
                                                          flat_id(Y*10 + X, FLAT_POS).

end_flat(TRAIN, FLAT_POS, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME),
                                           flat_id(Y*10 + X, FLAT_POS).

% total_cells(TOTAL_CELLS) :- TOTAL_CELLS = #count{VAL : cell_flat(VAL, _)}.

% output:

#show cell_flat/2.
#show grid_size/2.
#show start_flat/4.
#show end_flat/3.