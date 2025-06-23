train(1).
speed(1,2).
start(1, (2, 0), 0, north).
end(1, (0, 0), 5).

moment(TRAIN, MOMENT) :- MOMENT = 0..MAX_TIME-1, 
                         end(TRAIN, (_, _), MAX_TIME), 
                         train(TRAIN), 
                         speed(TRAIN, MOM_PER_POS),
                         R = MOMENT - (MOMENT / MOM_PER_POS) * MOM_PER_POS,
                         R == 0.

#show moment/2.