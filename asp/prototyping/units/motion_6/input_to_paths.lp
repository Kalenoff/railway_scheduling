% input (environment):

train(1).
start(1, (2, 0), 0, n).
end(1, (2, 2), 6).

cell((0, 0), 16386).
cell((0, 1), 1025).
cell((0, 2), 4608).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 32800).
cell((2, 0), 32800).
cell((2, 1), 0).
cell((2, 2), 32800).

% conversion of the input to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

start_flat(TRAIN, Y * WIDTH + X, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION), grid_size(_, WIDTH).
end_flat(TRAIN, Y * WIDTH + X, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME), grid_size(_, WIDTH).

% decreasing the search space by describing the routes as tightly as possible:

moment(TRAIN, 0..MAX_TIME-1) :- end(TRAIN, (_, _), MAX_TIME).

path(n, POSITION, move_forward, n, POSITION - WIDTH) :- cell_flat(POSITION, (34864;32800;32872;37408;49186;33825;33825;38433;35889;38505)), grid_size(HEIGHT, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0, POSITION != HEIGHT - 1.

path(s, POSITION, move_forward, s, POSITION + WIDTH) :- cell_flat(POSITION, (37408;49186;32800;32872;34864;38433;33825;35889;38505)), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(e, POSITION, move_forward, e, POSITION + 1) :- cell_flat(POSITION, (1025;3089;5633;33825;38433;35889;38505;17411;1097)), cell_flat(POSITION + 1, TYPE), TYPE != 0, grid_size(_, WIDTH), POSITION != WIDTH - 1.

path(s, POSITION, move_forward, s, POSITION - 1) :- cell_flat(POSITION, (5633;1025;17411;1097;33825;38433;35889;38505;3089)), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(e, POSITION, move_forward, s, POSITION + WIDTH) :- cell_flat(POSITION, (4608;20994;37408)), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(n, POSITION, move_forward, s, POSITION - 1) :- cell_flat(POSITION, (4608; 6672; 5633)), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(s, POSITION, move_forward, s, POSITION + WIDTH) :- cell_flat(POSITION, (16386;20994;49186)), grid_size(_, WIDTH), cell_flat(POSITION + WIDTH, TYPE), TYPE != 0.

path(n, POSITION, move_forward, e, POSITION + 1) :- cell_flat(POSITION, (16386;16458;17411)), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(s, POSITION, move_forward, n, POSITION - WIDTH) :- cell_flat(POSITION, (72;32872)), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(s, POSITION, move_forward, e, POSITION + 1) :- cell_flat(POSITION, (72;1097;16458)), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(e, POSITION, move_forward, n, POSITION - WIDTH) :- cell_flat(POSITION, (2064;34864)), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(s, POSITION, move_forward, s, POSITION - 1) :- cell_flat(POSITION, (2064;3089;6672)), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(e, POSITION, turn_right, s, POSITION + WIDTH) :- cell_flat(POSITION, (6672;38505;5633)), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(e, POSITION, turn_left, n, POSITION - WIDTH) :- cell_flat(POSITION, (6672;3089)), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.

path(s, POSITION, turn_right, s, POSITION + WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(s, POSITION, turn_left, n, POSITION - WIDTH) :- cell_flat(POSITION, 16458), grid_size(_, WIDTH), cell_flat((POSITION - WIDTH), TYPE), TYPE != 0.

path(s, POSITION, turn_right, e, POSITION + 1) :- cell_flat(POSITION, 32872), cell_flat((POSITION + 1), TYPE), TYPE != 0.

path(s, POSITION, turn_right, s, POSITION - 1) :- cell_flat(POSITION, (34864;35889)), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(n, POSITION, turn_left, s, POSITION - 1) :- cell_flat(POSITION, (20994;37408;38505)), cell_flat(POSITION - 1, TYPE), TYPE != 0.

path(n, POSITION, turn_right, e, POSITION + 1) :- cell_flat(POSITION, (20994;49186)), cell_flat(POSITION + 1, TYPE), TYPE != 0.

path(s, POSITION, turn_left, s, POSITION + WIDTH) :- cell_flat(POSITION, 17411), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(s, POSITION, turn_right, n, POSITION - WIDTH) :- cell_flat(POSITION, (1097;38505)), grid_size(_, WIDTH), cell_flat(POSITION - WIDTH, TYPE), TYPE != 0.

path(n, POSITION, turn_right, s, POSITION - 1) :- cell_flat(POSITION, 38433), cell_flat((POSITION - 1), TYPE), TYPE != 0.

path(e, POSITION, turn_right, e, POSITION + WIDTH) :- cell_flat(POSITION, 38433), grid_size(_, WIDTH), cell_flat((POSITION + WIDTH), TYPE), TYPE != 0.

path(s, POSITION, turn_left, e, POSITION + 1) :- cell_flat(POSITION, 38505), cell_flat((POSITION + 1), TYPE), TYPE != 0.

% allowing the train to wait before junctions:

is_junction(POS) :- cell_flat(POS, TYPE), junction_type(TYPE).

junction_type(37408; 17411; 32872; 3089; 49186; 1097; 34864; 5633; 33825; 38433; 50211; 33897; 35889; 38505; 52275; 20994; 16458; 2136; 6672).

path(IN_DIR, IN_POS, wait, IN_DIR, IN_POS) :- path(IN_DIR, IN_POS, _, OUT_DIR, OUT_POS), path(OUT_DIR, OUT_POS, _, _, _), is_junction(OUT_POS).

% allowing the train to wait at the starting position:

path(OUT_DIR, OUT_POS, wait, OUT_DIR, OUT_POS) :- start_flat(_, OUT_POS, _, OUT_DIR).

% displaying the output:

#show path/5.
#show start_flat/4.