speed(0,1). % ICE
speed(1,2). % local
speed(2,3). % freight

speed_range(ID, SPEED..3) :- speed(ID, SPEED).

#show speed_range/2.