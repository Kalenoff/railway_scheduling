% input (environment):

train(1).
start(1, (0, 0), 0, north).
end(1, (0, 2), 3).

cell((0, 0), 32800).
cell((0, 1), 0).
cell((0, 2), 32800).
cell((1, 0), 32800).
cell((1, 1), 0).
cell((1, 2), 32800).
cell((2, 0), 16386).
cell((2, 1), 1025).
cell((2, 2), 4608).

% conversion to 1d positional encoding:

grid_size(ROWS, COLUMNS) :- ROWS = #count{VAL : cell((VAL, _), _)}, COLUMNS = #count{VAL : cell((_, VAL), _)}.
position(Y*10 + X) :- cell((Y, X), _).
flat_id(P, I) :- position(P), I = #count { Q : position(Q), Q < P }.
cell_flat(POSITION, TYPE) :- cell((Y,X), TYPE), flat_id(Y*10+X, POSITION).

% experimenting:

moment(0..MAX_TIME) :- end(_, (_, _), MAX_TIME).

%track type 1:
tracker(POSITION, (north; south)) :- cell_flat(POSITION, 32800).
tracker(POSITION, (east; west)) :- cell_flat(POSITION, 1025).
tracker(POSITION, (east; north)) :- cell_flat(POSITION, 4608).
tracker(POSITION, (west; north)) :- cell_flat(POSITION, 16386).
tracker(POSITION, (west; south)) :- cell_flat(POSITION, 72).
tracker(POSITION, (east; south)) :- cell_flat(POSITION, 2064).
%track type 2:
tracker(POSITION, (south; north; east)) :- cell_flat(POSITION, (37408;34864)).
tracker(POSITION, (west; north; east)) :- cell_flat(POSITION, (17411;5633)).
tracker(POSITION, (south; north; west)) :- cell_flat(POSITION, (32872; 49186)).
tracker(POSITION, (south; east; west)) :- cell_flat(POSITION, (3089;1097)).
%track type 3:
tracker(POSITION, (north; south; west; east)) :- cell_flat(POSITION, (33825)).
%track type 4:
tracker(POSITION, (north; south; west; east)) :- cell_flat(POSITION, (38433; 50211; 33897; 35889)).
% track type 5:
tracker(POSITION, (north; south; west; east)) :- cell_flat(POSITION, (38505;52275)).
% track type 6:
tracker(POSITION, (north; east; west)) :- cell_flat(POSITION, 20994).
tracker(POSITION, (west; south; north)) :- cell_flat(POSITION, 16458).
tracker(POSITION, (south; east; west)) :- cell_flat(POSITION, 2136).
tracker(POSITION, (east; south; north)) :- cell_flat(POSITION, 6672).

% output:

#show tracker/2.

