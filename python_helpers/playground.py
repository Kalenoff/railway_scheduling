import matplotlib.pyplot as plt

def draw_inverted_grid(rows, cols):
    fig, ax = plt.subplots(figsize=(cols, rows))
    ax.set_xlim(0, cols)
    ax.set_ylim(0, rows)

    # Draw grid
    for x in range(cols + 1):
        ax.axvline(x, color='gray', linewidth=1)
    for y in range(rows + 1):
        ax.axhline(y, color='gray', linewidth=1)

    # Label cells with (Y, X)
    for y in range(rows):
        for x in range(cols):
            ax.text(x + 0.5, y + 0.5, f'({y},{x})', ha='center', va='center', fontsize=10)

    # Invert Y-axis to match top-left origin
    ax.invert_yaxis()

    # Turn off ticks
    ax.set_xticks([])
    ax.set_yticks([])

    # Keep grid square
    ax.set_aspect('equal')

    plt.title("Inverted Grid: Origin at Top-Left, Y ↓, X →")
    plt.show()

# Example: 5 rows (Y), 6 columns (X)
draw_inverted_grid(5, 6)
