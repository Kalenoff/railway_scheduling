every_moment(1..10).

{ action_moment(X) : every_moment(X) }.

:- #count { X : action_moment(X) } < 2. % this could be made equal to the local time horizon

:- action_moment(X), action_moment(Y), action_moment(Z), 
   Y-X == Z-Y, X < Y, Y < Z.

#show action_moment/1.