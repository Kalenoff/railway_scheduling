import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import re
import os

input_env = """cell((0, 0), 0).
cell((0, 1), 0).
cell((0, 2), 0).
cell((0, 3), 0).
cell((0, 4), 0).
cell((0, 5), 0).
cell((0, 6), 0).
cell((0, 7), 0).
cell((0, 8), 0).
cell((0, 9), 0).
cell((0, 10), 0).
cell((0, 11), 0).
cell((0, 12), 0).
cell((0, 13), 0).
cell((0, 14), 0).

cell((1, 0), 0).
cell((1, 1), 16386).
cell((1, 2), 1025).
cell((1, 3), 1025).
cell((1, 4), 1025).
cell((1, 5), 4608).
cell((1, 6), 0).
cell((1, 7), 0).
cell((1, 8), 16386).
cell((1, 9), 1025).
cell((1, 10), 1025).
cell((1, 11), 1025).
cell((1, 12), 4608).
cell((1, 13), 0).
cell((1, 14), 0).

cell((2, 0), 0).
cell((2, 1), 32800).
cell((2, 2), 0).
cell((2, 3), 0).
cell((2, 4), 0).
cell((2, 5), 32800).
cell((2, 6), 0).
cell((2, 7), 0).
cell((2, 8), 32800).
cell((2, 9), 0).
cell((2, 10), 0).
cell((2, 11), 0).
cell((2, 12), 32800).
cell((2, 13), 0).
cell((2, 14), 0).

cell((3, 0), 0).
cell((3, 1), 32872).
cell((3, 2), 4608).
cell((3, 3), 0).
cell((3, 4), 0).
cell((3, 5), 72).
cell((3, 6), 17411).
cell((3, 7), 1025).
cell((3, 8), 2064).
cell((3, 9), 0).
cell((3, 10), 0).
cell((3, 11), 0).
cell((3, 12), 32800).
cell((3, 13), 0).
cell((3, 14), 0).

cell((4, 0), 0).
cell((4, 1), 32800).
cell((4, 2), 32800).
cell((4, 3), 0).
cell((4, 4), 0).
cell((4, 5), 16386).
cell((4, 6), 3089).
cell((4, 7), 1025).
cell((4, 8), 4608).
cell((4, 9), 0).
cell((4, 10), 16386).
cell((4, 11), 1025).
cell((4, 12), 2064).
cell((4, 13), 0).
cell((4, 14), 0).

cell((5, 0), 0).
cell((5, 1), 49186).
cell((5, 2), 0).
cell((5, 3), 0).
cell((5, 4), 0).
cell((5, 5), 32800).
cell((5, 6), 0).
cell((5, 7), 0).
cell((5, 8), 32800).
cell((5, 9), 0).
cell((5, 10), 32800).
cell((5, 11), 0).
cell((5, 12), 0).
cell((5, 13), 0).
cell((5, 14), 0).

cell((6, 0), 0).
cell((6, 1), 32800).
cell((6, 2), 0).
cell((6, 3), 0).
cell((6, 4), 0).
cell((6, 5), 32800).
cell((6, 6), 0).
cell((6, 7), 0).
cell((6, 8), 72).
cell((6, 9), 4608).
cell((6, 10), 32800).
cell((6, 11), 0).
cell((6, 12), 0).
cell((6, 13), 0).
cell((6, 14), 0).

cell((7, 0), 0).
cell((7, 1), 72).
cell((7, 2), 1025).
cell((7, 3), 17411).
cell((7, 4), 1025).
cell((7, 5), 2064).
cell((7, 6), 0).
cell((7, 7), 0).
cell((7, 8), 0).
cell((7, 9), 32800).
cell((7, 10), 32800).
cell((7, 11), 0).
cell((7, 12), 0).
cell((7, 13), 0).
cell((7, 14), 0).

cell((8, 0), 0).
cell((8, 1), 0).
cell((8, 2), 0).
cell((8, 3), 32800).
cell((8, 4), 0).
cell((8, 5), 0).
cell((8, 6), 0).
cell((8, 7), 0).
cell((8, 8), 0).
cell((8, 9), 72).
cell((8, 10), 37408).
cell((8, 11), 0).
cell((8, 12), 0).
cell((8, 13), 0).
cell((8, 14), 0).

cell((9, 0), 0).
cell((9, 1), 16386).
cell((9, 2), 1025).
cell((9, 3), 34864).
cell((9, 4), 0).
cell((9, 5), 0).
cell((9, 6), 0).
cell((9, 7), 0).
cell((9, 8), 0).
cell((9, 9), 0).
cell((9, 10), 32800).
cell((9, 11), 0).
cell((9, 12), 0).
cell((9, 13), 0).
cell((9, 14), 0).

cell((10, 0), 0).
cell((10, 1), 32800).
cell((10, 2), 0).
cell((10, 3), 32800).
cell((10, 4), 0).
cell((10, 5), 0).
cell((10, 6), 0).
cell((10, 7), 0).
cell((10, 8), 0).
cell((10, 9), 0).
cell((10, 10), 32800).
cell((10, 11), 0).
cell((10, 12), 0).
cell((10, 13), 0).
cell((10, 14), 0).

cell((11, 0), 0).
cell((11, 1), 32800).
cell((11, 2), 0).
cell((11, 3), 32800).
cell((11, 4), 0).
cell((11, 5), 0).
cell((11, 6), 0).
cell((11, 7), 0).
cell((11, 8), 0).
cell((11, 9), 0).
cell((11, 10), 32800).
cell((11, 11), 0).
cell((11, 12), 0).
cell((11, 13), 0).
cell((11, 14), 0).

cell((12, 0), 0).
cell((12, 1), 32800).
cell((12, 2), 0).
cell((12, 3), 32800).
cell((12, 4), 0).
cell((12, 5), 0).
cell((12, 6), 0).
cell((12, 7), 0).
cell((12, 8), 0).
cell((12, 9), 0).
cell((12, 10), 72).
cell((12, 11), 1025).
cell((12, 12), 1025).
cell((12, 13), 1025).
cell((12, 14), 0).

cell((13, 0), 0).
cell((13, 1), 72).
cell((13, 2), 1025).
cell((13, 3), 2064).
cell((13, 4), 0).
cell((13, 5), 0).
cell((13, 6), 0).
cell((13, 7), 0).
cell((13, 8), 0).
cell((13, 9), 0).
cell((13, 10), 0).
cell((13, 11), 0).
cell((13, 12), 0).
cell((13, 13), 0).
cell((13, 14), 0).

cell((14, 0), 0).
cell((14, 1), 0).
cell((14, 2), 0).
cell((14, 3), 0).
cell((14, 4), 0).
cell((14, 5), 0).
cell((14, 6), 0).
cell((14, 7), 0).
cell((14, 8), 0).
cell((14, 9), 0).
cell((14, 10), 0).
cell((14, 11), 0).
cell((14, 12), 0).
cell((14, 13), 0).
cell((14, 14), 0).

"""


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


def plot_grid_with_images(pos_type_map, show1d=False):

    y_coords = sorted(set(y for y, x in pos_type_map.keys()))
    x_coords = sorted(set(x for y, x in pos_type_map.keys()))

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

            if show1d == True:

                ax.text(x + 0.45, y - 0.45, str(idx), fontsize=8, ha='right', va='top')

    ax.set_xlim(min(x_coords) - 0.5, max(x_coords) + 0.5)
    ax.set_ylim(max(y_coords) + 0.5, min(y_coords) - 0.5)

    ax.tick_params(axis='both', which='major', labelsize=4) 

    ax.set_xticks(x_coords)
    ax.set_yticks(y_coords)

    ax.set_aspect('equal', adjustable='box')
    plt.show()


print(plot_grid_with_images(grid_extractor(input_env), True))