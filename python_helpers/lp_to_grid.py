import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import re
import os

input_env = """cell((0, 0), 0).
cell((0, 1), 32800).
cell((0, 2), 32800).
cell((0, 3), 0).
cell((1, 0), 1025).
cell((1, 1), 1097).
cell((1, 2), 3089).
cell((1, 3), 1025)"""


def plot_grid_with_values(pos_type_map):
   
    y_coords = sorted(set(y for y, x in pos_type_map.keys()))
    x_coords = sorted(set(x for y, x in pos_type_map.keys()))

    plt.figure()

    for x in x_coords:
      for dx in [-0.5, 0.5]: 
         plt.axvline(x=x + dx, color='black', linestyle='-')

  
    for y in y_coords:
      for dy in [-0.5, 0.5]:  
         plt.axhline(y=y + dy, color='black', linestyle='-')

    for (y, x), value in pos_type_map.items():
       plt.text(x, y, value, ha='center', va='center', fontsize=6)

    plt.xlim(min(x_coords) - 0.5, max(x_coords) + 0.5)
    plt.ylim(min(y_coords) - 0.5, max(y_coords) + 0.5)

    plt.xticks(x_coords)
    plt.yticks(y_coords)

    plt.gca().set_aspect('equal', adjustable='box')
    plt.show()



def grid_extractor(env: str):
    env_listed_cleared = [x.replace('\n', '').strip() for x in env.split('.') if x.strip()]
    pos_type_map = {}

    for item in env_listed_cleared:
        # Use regular expressions to extract coordinates and value
        match = re.match(r'cell\(\((\d+),\s*(\d+)\),\s*(\d+)\)', item)
        if match:
            y_coord = int(match.group(1))
            x_coord = int(match.group(2))
            value = match.group(3)
            pos_type_map[(y_coord, x_coord)] = value

    return pos_type_map


def plot_grid_with_images(pos_type_map):
    # Extract unique coordinates
    y_coords = sorted(set(y for y, x in pos_type_map.keys()))
    x_coords = sorted(set(x for y, x in pos_type_map.keys()))

    # Create a new figure
    fig, ax = plt.subplots()

    # Plot vertical lines
    for x in x_coords:
        for dx in [-0.5, 0.5]:
            ax.axvline(x=x + dx, color='black', linestyle='-')

    # Plot horizontal lines
    for y in y_coords:
        for dy in [-0.5, 0.5]:
            ax.axhline(y=y + dy, color='black', linestyle='-')

    # Create a list of sorted coordinates to assign indices
    sorted_coords = sorted(pos_type_map.keys())

    # Plot each image in its respective cell and add an index
    for idx, (y, x) in enumerate(sorted_coords):
        value = pos_type_map[(y, x)]
        image_path = os.path.join(r'C:\Users\roman\Documents\Code\ASP\railway_scheduling\python_helpers\lp_to_grid_tiles_backup_2', f"{value}.png")
        if os.path.exists(image_path):
            img = mpimg.imread(image_path)
            ax.imshow(img, extent=[x - 0.5, x + 0.5, y - 0.5, y + 0.5], aspect='auto', origin='lower')

            ax.text(x + 0.45, y - 0.45, str(idx), fontsize=4, ha='right', va='top')

    ax.set_xlim(min(x_coords) - 0.5, max(x_coords) + 0.5)
    ax.set_ylim(max(y_coords) + 0.5, min(y_coords) - 0.5)

    ax.tick_params(axis='both', which='major', labelsize=4) 

    ax.set_xticks(x_coords)
    ax.set_yticks(y_coords)

    ax.set_aspect('equal', adjustable='box')
    plt.show()


print(plot_grid_with_images(grid_extractor(input_env)))