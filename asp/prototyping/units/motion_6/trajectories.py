sample_input = """path(n,3,move_forward,n,0) path(n,5,move_forward,n,2) path(n,6,move_forward,n,3) path(n,8,move_forward,n,5) path(s,3,move_forward,s,6) path(s,5,move_forward,s,8) path(e,1,move_forward,e,2) path(s,1,move_forward,s,0) path(e,2,move_forward,s,5) path(n,2,move_forward,s,1) path(s,0,move_forward,s,3) path(n,0,move_forward,e,1)"""
sample_start = 'start_flat(1,6,0,n)'

def find_trajectories(paths: str, start: str)->str:
    start_cleared = start.replace('start_flat(', "")
    start_listed = [start_cleared[6], start_cleared[2]]
    paths_listed = paths.split(" ")
    paths_sublists = [x.replace("path", "").
                       replace(")", "").
                       replace("(", "").
                       replace("move_forward,", "").
                       replace("wait,", "").
                       split(",") for x in paths_listed]
    trajectory = [path for path in paths_sublists if path[0] == start_listed[0] and path[1] == start_listed[1]]
    for path in paths_sublists:
        if path[0] == trajectory[-1][2] and path[1] == trajectory[-1][3]:
            trajectory.append(path)
    return paths_sublists
          
# let's find the separator: it is the whitespace, every other char is closely put
# let's test it
# the perfect structure for this multiple trajectories array is a dictionary:
# {1: [[]],
#  2: [[]],
#  3: [[]]}
# trajectories themselves must be immutable and with unique elements

# print(find_trajectories(sample_input, sample_start))

test_list = [['n', '3', 'n', '0'], ['n', '5', 'n', '2'], ['n', '6', 'n', '3'], ['n', '8', 'n', '5'], ['s', '3', 's', '6'], ['s', '5', 's', '8'], ['e', '1', 'e', '2'], ['s', '1', 's', '0'], ['e', '2', 's', '5'], ['n', '2', 's', '1'], ['s', '0', 's', '3'], ['n', '0', 'e', '1']]
trajectories = [['n', '6', 'n', '3']]

for path in test_list:
    if path[0] == trajectories[-1][2] and path[1] == trajectories[-1][3]:
       trajectories.append(path)
       print(path)

