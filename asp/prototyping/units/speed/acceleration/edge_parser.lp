train(1).
train(2).
start(1, (0, 0), 0, east).
start(2, (2, 0), 0, east).
end(1, (2, 0), 6).
end(2, (2, 5), 5).

cell((2,0), 1025).
cell((2,1), 1025).
cell((2,2), 3089).
cell((2,3), 1025).
cell((2,4), 1025).
cell((2,5), 1025).
cell((1,0), 0).
cell((1,1), 0).
cell((1,2), 32800).
cell((1,3), 0).
cell((1,4), 0).
cell((1,5), 0).
cell((0,0), 1025).
cell((0,1), 1025).
cell((0,2), 4608).
cell((0,3), 0).
cell((0,4), 0).
cell((0,5), 0).

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
cell_flat(Y * WIDTH + X, TYPE) :- cell((Y, X), TYPE), grid_size(_, WIDTH).

start_flat(TRAIN, Y * WIDTH + X, DEPARTURE_TIME, DIRECTION) :- start(TRAIN, (Y, X), DEPARTURE_TIME, DIRECTION), grid_size(_, WIDTH).
end_flat(TRAIN, Y * WIDTH + X, ARRIVAL_TIME) :- end(TRAIN, (Y, X), ARRIVAL_TIME), grid_size(_, WIDTH).

edge_type(1025; 32800).
no_track_type(0).

parsed_junction((Y,X), TYPE) :- cell((Y,X), TYPE), 
                                not edge_type(TYPE),
                                not no_track_type(TYPE).


junction_between((Y,X1),(Y,X3)) :-  parsed_junction((Y,X1), _),
                                    parsed_junction((Y,X2), _),
                                    parsed_junction((Y,X3), _),
                                    X1 < X2,
                                    X2 < X3.

junction_between((Y1,X),(Y3,X)) :-  parsed_junction((Y1,X), _),
                                    parsed_junction((Y2,X), _),
                                    parsed_junction((Y3,X), _),
                                    Y1 < Y2,
                                    Y2 < Y3.


junction_between((Y1,X),(Y3,X)) :-  parsed_junction((Y1,X), _),
                                    parsed_junction((Y2,X), _),
                                    parsed_junction((Y3,X), _),
                                    Y1 < Y2,
                                    Y2 < Y3.
                                    
gap_between((Y,X1),(Y,X3)) :- parsed_junction((Y,X1), _); start(_, (Y,X1), _, _),
                              cell((Y,X2), 0),
                              parsed_junction((Y,X3), _); end(_, (Y,X3), _),
                              X1 < X2,
                              X2 < X3.

gap_between((Y1,X),(Y3,X)) :- parsed_junction((Y1,X), _); start(_, (Y1,X), _, _),
                              cell((Y2,X), 0),
                              parsed_junction((Y3,X), _); end(_, (Y3,X), _),
                              Y1 < Y2,
                              Y2 < Y3.

gap_between((Y1,X),(Y1+10,X)) :- cell((Y1,X), 2064),
                                 cell((Y1+10,X), 4608). % MAKESHIFT

edge((Y,X1),(Y,X2)) :- parsed_junction((Y,X1), _),
                       parsed_junction((Y,X2), _),
                       not junction_between((Y,X1), (Y,X2)),
                       not gap_between((Y,X1), (Y,X2)),
                       X1 != X2.

edge((Y1,X),(Y2,X)) :- parsed_junction((Y1,X), _),
                       parsed_junction((Y2,X), _),
                       not junction_between((Y1,X), (Y2,X)),
                       not gap_between((Y1,X), (Y2,X)),
                       Y1 != Y2.

varying_speed_stretch(START, END) :- edge((Y1,X1),(Y2,X2)),
                                     grid_size(_, WIDTH),
                                     START = Y1 * WIDTH + X1,
                                     END = Y2 * WIDTH + X2.

% for fixed speed stretches:

junction_between((Y,X1), (Y,X2)) :- start(_, (Y,X1), _, _),
                                    parsed_junction((Y,X2), _),
                                    parsed_junction((Y,X3), _),
                                    X1 < X2,
                                    X2 > X3.

junction_between((Y1,X), (Y2,X)) :- start(_, (Y1,X), _, _),
                                    parsed_junction((Y2,X), _),
                                    parsed_junction((Y3,X), _),
                                    Y1 < Y2,
                                    Y2 > Y3.

junction_between((Y,X1), (Y,X2)) :- end(_, (Y,X1), _),
                                    parsed_junction((Y,X2), _),
                                    parsed_junction((Y,X3), _),
                                    X1 < X2,
                                    X2 > X3.

junction_between((Y1,X), (Y2,X)) :- end(_, (Y1,X), _),
                                    parsed_junction((Y2,X), _),
                                    parsed_junction((Y3,X), _),
                                    Y1 < Y2,
                                    Y2 > Y3.

fixed_speed_stretch(FIRST, SECOND) :- start(_, (Y,X), _, _),
                                      is_junction(SECOND),
                                      not junction_between(FIRST, SECOND).

fixed_speed_stretch(FIRST, SECOND) :- start(_, (Y,X1), _, _),
                                      is_junction((Y,X2), _),
                                      not junction_between((Y,X1), (Y,X2)).

fixed_speed_stretch(FIRST, SECOND) :- end(_, (Y1,X), _),
                                      is_junction((Y2,X), _),
                                      not junction_between((Y1,X),(Y2,X)).

% #show parsed_junction/2.
% #show edge_candidate/2.
% #show junction_between/2.
% #show gap_between/2.
% #show edge/2.
#show varying_speed_stretch/2.
#show fixed_speed_stretch/2.