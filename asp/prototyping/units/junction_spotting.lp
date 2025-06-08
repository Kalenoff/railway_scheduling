cell((2, 0), 0).
cell((2,1), 32800).
cell((2,2), 0).
cell((1,0), 1025).
cell((1,1), 33825).
cell((1,2), 1025).
cell((0,0), 0).
cell((0,1), 32800).
cell((0,2), 0).

junction_type(37408; 17411; 32872; 3089; 49186; 1097; 34864; 5633; 33825; 38433; 50211; 33897; 35889; 38505; 52275; 20994; 16458; 2136; 6672).

% conversion of the input to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

is_junction(POS) :- cell_flat(POS, TYPE), junction_type(TYPE).

#show is_junction/1.