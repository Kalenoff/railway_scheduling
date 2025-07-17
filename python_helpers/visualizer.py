import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import re
import os

input_env = """cell((0, 0), 1025).
cell((0, 1), 1025). 
cell((0, 2), 1025). 
cell((0, 3), 1025). 
cell((0, 4), 1025). 
cell((0, 5), 1025). 
cell((0, 6), 1025). 
cell((0, 7), 1025). 
cell((0, 8), 1025). 
cell((0, 9), 1025).
"""

input_trans = """real_transition(0,0,0,east,wait,0,east) real_transition(0,3,0,east,wait,0,east) real_transition(0,4,0,east,wait,0,east) real_transition(0,7,0,east,wait,0,east) real_transition(0,6,0,east,wait,0,east) real_transition(0,9,0,east,wait,0,east) real_transition(0,10,0,east,wait,0,east) real_transition(0,13,0,east,move_forward,1,east) real_transition(0,12,0,east,wait,0,east) real_transition(0,15,1,east,move_forward,2,east) real_transition(0,16,2,east,move_forward,3,east) real_transition(0,19,4,east,move_forward,5,east) real_transition(0,18,3,east,move_forward,4,east) real_transition(0,21,5,east,move_forward,6,east) real_transition(0,22,6,east,move_forward,7,east) real_transition(0,25,8,east,move_forward,9,east) real_transition(0,24,7,east,move_forward,8,east) laggy_transition(0,1,0,east,wait,0,east) laggy_transition(0,5,0,east,wait,0,east) laggy_transition(0,8,0,east,wait,0,east) laggy_transition(0,11,0,east,wait,0,east) laggy_transition(0,14,0,east,move_forward,1,east) laggy_transition(0,17,2,east,move_forward,3,east) laggy_transition(0,20,4,east,move_forward,5,east) laggy_transition(0,23,6,east,move_forward,7,east) laggy_transition(0,26,8,east,move_forward,9,east) laggy_transition(0,2,0,east,wait,0,east) laggy_transition(0,27,8,east,move_forward,9,east)"""


def dummy_transition_adder(raw_trans: str) -> str:

    transitions_listed = raw_trans.split(' ')
    transitions_listed_sublists = [x.split(',') for x in transitions_listed]
    transition_listed_sorted = sorted(transitions_listed_sublists, key=lambda x: int(x[1]))
    transitions_listed_remerged = [','.join(x) for x in transition_listed_sorted]

    last_transition = transitions_listed_remerged[-1]
    last_transition_listed = last_transition.split(',')

    out_dir = last_transition_listed[-1].strip(')')
    out_pos = last_transition_listed[-2]
    moment = last_transition_listed[1]

    last_transition_listed[2] = out_pos
    last_transition_listed[3] = out_dir
    last_transition_listed[1] = str(int(moment) + 1)
    last_transition_remerged = ','.join(last_transition_listed)

    transitions_listed_remerged.append(last_transition_remerged)

    return_string = ' '.join(transitions_listed_remerged)

    return return_string


def grid_extractor(env: str):
    env_listed_cleared = [x.replace('\n', '').strip() for x in env.split('.') if x.strip()]
    pos_type_map = {}

    for item in env_listed_cleared:
        match = re.match(r'cell\(\((\d+),\s*(\d+)\),\s*(\d+)\)', item)
        if match:
            y_coord = int(match.group(1))
            x_coord = int(match.group(2))
            value = match.group(3)
            pos_type_map[(y_coord, x_coord)] = value

    return pos_type_map


def onedto2d(flat_pos: int, grid_width: int) -> tuple:

    y = flat_pos // (grid_width + 1)
    x = flat_pos % (grid_width + 1)

    return (y, x)


def transition_parser(transitions: str, grid_width: int)->list:

    transitions_extended = dummy_transition_adder(transitions)

    transitions_listed = transitions_extended.split(" ")

    parsed_transition_list = []

    for transition in transitions_listed:

        pattern = r'transition\(([^,]+),([^,]+),([^,]+),([^,]+)'
        match = re.search(pattern, transition)

        transition_data = {'train': match.group(1),
                           'moment': match.group(2),
                           'pos': onedto2d(int(match.group(3)), grid_width),
                           'dir': match.group(4)}
        
        parsed_transition_list.append(transition_data)

    sorted_data = sorted(parsed_transition_list, key=lambda x: int(x['moment']))

    return sorted_data


def plot_grid_with_images(environment: str, transitions_raw: str, grid_width: int, show1d=False):
    pos_type_map = grid_extractor(environment)
    parsed_transitions = transition_parser(transitions_raw, grid_width)

    y_coords = sorted(set(y for y, x in pos_type_map.keys()))
    x_coords = sorted(set(x for y, x in pos_type_map.keys()))

    moments = sorted(set(transition['moment'] for transition in parsed_transitions))

    for moment in moments:
        fig, ax = plt.subplots()

        for x in x_coords:
            for dx in [-0.5, 0.5]:
                ax.axvline(x=x + dx, color='black', linestyle='-')
        for y in y_coords:
            for dy in [-0.5, 0.5]:
                ax.axhline(y=y + dy, color='black', linestyle='-')

        sorted_coords = sorted(pos_type_map.keys())
        for idx, (y, x) in enumerate(sorted_coords):
            value = pos_type_map[(y, x)]
            image_path = os.path.join(r'C:\Users\roman\Documents\Code\ASP\railway_scheduling\python_helpers\lp_to_grid_tiles_backup_2', f"{value}.png")
            if os.path.exists(image_path):
                img = mpimg.imread(image_path)
                ax.imshow(img, extent=[x - 0.5, x + 0.5, y - 0.5, y + 0.5], aspect='auto', origin='lower')
                if show1d:
                    ax.text(x + 0.45, y - 0.45, str(idx), fontsize=8, ha='right', va='top')

        for transition in parsed_transitions:
            if transition['moment'] == moment:
                pos = transition['pos']
                ax.plot(pos[1], pos[0], 'ro', markersize=10)

        ax.set_xlim(min(x_coords) - 0.5, max(x_coords) + 0.5)
        ax.set_ylim(max(y_coords) + 0.5, min(y_coords) - 0.5)
        ax.tick_params(axis='both', which='major', labelsize=4)
        ax.set_xticks(x_coords)
        ax.set_yticks(y_coords)
        ax.set_aspect('equal', adjustable='box')
        ax.set_title(f"Moment: {moment}")
        
        output_path = os.path.join(r"C:\Users\roman\Documents\Code\ASP\railway_scheduling\python_helpers\visualization_outputs", f"moment_{moment}.png")
        plt.savefig(output_path)
        plt.close()


plot_grid_with_images(input_env, input_trans, 10)



