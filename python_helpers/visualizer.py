import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import re
import os

input_env = """cell((2,0), 1025).
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
"""

input_trans = """transition(1,0,1,east,move_forward,2,east) transition(1,1,2,east,move_forward,8,south) transition(1,2,8,south,move_forward,14,south) transition(1,3,14,south,move_forward,13,west) transition(1,4,13,west,move_forward,12,west) transition(1,5,13,west,move_forward,12,west)"""


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


def per_train_adder(transitions: str) -> dict:
    """
    Splits transitions by train ID and returns a dictionary where:
    - keys are train IDs (as strings)
    - values are lists of transitions for that train (sorted by moment)
    """
    if not transitions.strip():
        return {}
    
    transitions_listed = [t.strip() for t in transitions.split(" ") if t.strip()]
    train_dict = {}
    
    for transition in transitions_listed:

        match = re.match(r'transition\((\d+)', transition)
        if not match:
            continue
            
        train_id = match.group(1)
        
        if train_id not in train_dict:
            train_dict[train_id] = []
        train_dict[train_id].append(transition)

    for train_id in train_dict:
        # Sort by moment
        train_dict[train_id].sort(key=lambda x: int(re.search(r'transition\(\d+,(\d+)', x).group(1)))
        # Join into single string
        train_trans_str = ' '.join(train_dict[train_id])
        # Apply dummy_transition_adder
        train_dict[train_id] = dummy_transition_adder(train_trans_str)
    
    joined_per_train = [''.join(x) for x in train_dict.values()]
    joined_total = ' '.join(joined_per_train)

    return joined_total


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

    y = flat_pos // grid_width
    x = flat_pos % grid_width

    return (y, x)


def transition_parser(transitions: str, grid_width: int)->list:

    transitions_extended = per_train_adder(transitions)

    transitions_listed = transitions_extended.split(" ")

    parsed_transition_list = []

    for transition in transitions_listed:

        pattern = r'transition\((\d+),(\d+),(\d+),([^,]+)'
        # pattern = r'transition\(([^,]+),([^,]+),([^,]+),([^,]+)'
        match = re.match(pattern, transition)

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

    # Extract unique train IDs
    train_ids = sorted(set(transition['train'] for transition in parsed_transitions))

    # Assign a color to each train ID
    colors = ['red', 'blue', 'yellow', 'purple', 'orange', 'pink', 'brown', 'gray', 'cyan']
    train_color_map = {train_id: colors[i % len(colors)] for i, train_id in enumerate(train_ids)}

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
                train_id = transition['train']
                color = train_color_map[train_id]
                ax.plot(pos[1], pos[0], marker='o', markersize=10, color=color)

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


plot_grid_with_images(input_env, input_trans, 6)