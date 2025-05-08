cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 0).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 0).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 0).

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.

position(Y*10 + X) :- cell((Y, X), _).

flat_id(MERGED_YX, POSITION) :- position(MERGED_YX), POSITION = #count { VAL : position(VAL), VAL < MERGED_YX }.

cell_flat(POSITION, TYPE) :- cell((Y,X), TYPE), flat_id(Y*10+X, POSITION).

directions(north; south; east; west).

cell_direction_actions(POSITION, DIRECTION, (move_forward; wait)) :- cell_flat(POSITION, 32800),
                                                                     directions(DIRECTION).

#show cell_direction_actions/3.
