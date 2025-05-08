% environment:

start(0).
end(8).
grid_size(3,3).
segment(0, 128).
segment(1, 0).
segment(2, 0).
segment(3, 32800).
segment(4, 0).
segment(5, 0).
segment(6, 16386).
segment(7, 1025).
segment(8, 256).

% solver:

max_time(MAX_TIME) :- MAX_TIME = #count{VAL : segment(VAL, TYPE), TYPE != 0}.

moment(1..MAX_TIME) :- max_time(MAX_TIME).

{ travel(MOMENT, POSITION) : moment(MOMENT), segment(POSITION, TYPE), TYPE != 0 } = MAX_TIME :- max_time(MAX_TIME).

:- travel(MOMENT, POSITION_1),
   travel(MOMENT, POSITION_2),
   POSITION_1 != POSITION_2.

:- travel(1, POSITION),
   start(START),
   POSITION != START.

:- travel(MAX_TIME, POSITION),
   max_time(MAX_TIME),
   end(END),
   POSITION != END.

:- grid_size(HEIGHT, WIDTH),
   segment(POSITION_1, (128; 32800; 8192)),
   travel(MOMENT, POSITION_1),
   travel(MOMENT+1, POSITION_2),
   not 1 {POSITION_2 = POSITION_1 + WIDTH; 
   POSITION_2 = POSITION_1 - WIDTH} 1.

:- segment(POSITION_1, (1025; 256)),
   travel(MOMENT, POSITION_1),
   travel(MOMENT+1, POSITION_2),
   not 1 {POSITION_2 = POSITION_1 + 1; 
   POSITION_2 = POSITION_1 - 1} 1.

:- segment(POSITION_1, 16386),
   grid_size(HEIGHT, WIDTH),
   travel(MOMENT, POSITION_1),
   travel(MOMENT+1, POSITION_2),
   not 1 {POSITION_2 = POSITION_1 + 1; 
   POSITION_2 = POSITION_1 - WIDTH} 1.

:- segment(POSITION_1, 4608),
   grid_size(HEIGHT, WIDTH),
   travel(MOMENT, POSITION_1),
   travel(MOMENT+1, POSITION_2),
   not 1 {POSITION_2 = POSITION_1 - 1; 
   POSITION_2 = POSITION_1 - WIDTH} 1.

#show travel/2.