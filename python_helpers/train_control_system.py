from collections import defaultdict


def train_control_system(railroad, grid_size, trains):
    dispatcher = []
    for train in trains.keys():
        current_segment = trains[train][0]
        goal = trains[train][1]
        action_log = []
        timer = 0
        print(f'Departing from {current_segment}')
        dispatcher.append((train, timer, current_segment))
        while current_segment != goal:
            track_type = railroad[current_segment]
            if track_type == 4 and len(action_log)==0:
                current_segment += 1
                action_log.append('east')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 4 and action_log[-1] == 'west':
                action_log.append('deadend')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} now on {current_segment}")
            elif track_type == 128 and len(action_log)==0:
                current_segment += grid_size[1]
                action_log.append('north')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 128 and action_log[-1] == 'south':
                action_log.append('deadend')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 8192 and len(action_log) == 0:
                current_segment -= grid_size[1]
                action_log.append('south')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 8192 and action_log[-1] == 'north':
                action_log.append('deadend')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 256 and len(action_log) == 0:
                current_segment -= 1
                action_log.append('west')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 256 and action_log[-1] == 'east':
                action_log.append('deadend')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 32800 and action_log[-1] == 'north':
                current_segment += grid_size[1]
                action_log.append('north')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 32800 and action_log[-1] == 'south':
                current_segment -= grid_size[1]
                action_log.append('south')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 1025 and action_log[-1] == 'east':
                current_segment += 1
                action_log.append('east')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 1025 and action_log[-1] == 'west':
                current_segment -= 1 
                action_log.append('west')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 4608 and action_log[-1] == 'east':
                current_segment -= grid_size[1]
                action_log.append('south')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 4608 and action_log[-1] == 'east':
                current_segment -= 1
                action_log.append('west')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 16386 and action_log[-1] == 'north':
                current_segment += 1
                action_log.append('east')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 16386 and action_log[-1] == 'east':
                current_segment -= grid_size[1]
                action_log.append('south')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 72 and action_log[-1] == 'west':
                current_segment += grid_size[1]
                action_log.append('north')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 72 and action_log[-1] == 'south':
                current_segment += 1
                action_log.append('east')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 2064 and action_log[-1] == 'east':
                current_segment += grid_size[1]
                action_log.append('north')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 2064 and action_log[-1] == 'south':
                current_segment -= 1
                action_log.append('west')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 3089 and action_log[-1] == 'south':
                current_segment -= 1
                action_log.append('west')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 3089 and action_log[-1] == 'east': # fixing this switch to a single pass for now; but there
                current_segment += 1                              # must be binary choice: turn north or continue east
                action_log.append('east')
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 3089 and action_log[-1] == 'west':
                 current_segment -= 1
                 action_log.append('west')
                 timer += 1
                 dispatcher.append((train, timer, current_segment))
                 print(f"Train {train} on {current_segment} at moment {timer}")
            elif track_type == 0:
                timer += 1
                dispatcher.append((train, timer, current_segment))
                print(f"Train wrecked")
                break
    seen = defaultdict(set)
    for first, second, third in dispatcher:
        seen[(second, third)].add(first)
    conflicts = [key for key, firsts in seen.items() if len(firsts) > 1]
    if len(conflicts) == 0:
        return "All trains have run without collisions!"
    else:
        return f'Collisions at {conflicts}!'


grid_1_idx = {0: 128,
              1: 0,
              2: 0,
              3: 32800,
              4: 0,
              5: 0,
              6: 8192,
              7: 0,
              8: 0}


grid_2_idx = {0: 128,
              1: 0,
              2: 0,
              3: 32800,
              4: 0,
              5: 0,
              6: 16386,
              7: 1025,
              8: 256}


grid_3_idx = {0: 128,
              1: 0,
              2: 128,
              3: 32800,
              4: 0,
              5: 32800,
              6: 16386,
              7: 1025,
              8: 4608}


grid_5_idx = {0: 4,
              1: 1025,
              2: 3089,
              3: 1025,
              4: 1025,
              5: 256,
              6: 0,
              7: 0,
              8: 32800,
              9: 0, 
             10: 0,
             11: 0,
             12: 4,
             13: 1025,
             14: 4608,
             15: 0,
             16: 0,
             17: 0}


grid_6 = {0: 4,
          1: 1025,
          2: 1025,
          3: 1025,
          4: 1025,
          5: 1025,
          6: 256}


trains = {1: (0, 6),
          2: (6, 0)}

print(train_control_system(grid_6, (1,6), trains))