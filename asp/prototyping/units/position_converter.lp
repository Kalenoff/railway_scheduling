train(1).
start(1, (0, 0), 0, north).
end(1, (2, 0), 2).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 0).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 0).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 0).

% conversion to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

% output:

% #show grid_size/2.
% #show num_cells/1.
#show cell_flat/2.