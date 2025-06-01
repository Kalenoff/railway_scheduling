file_path = r"C:\Users\roman\Documents\Code\ASP\railway_scheduling\asp\prototyping\environments\many_trains\twenty_by_twenty.lp"

columns = [y for y in range(0,20)]
rows = [x for x in range(0,20)]

cells = ""

for column in columns:
    for row in rows:
        cells += f'cell(({column}, {row}), 0).\n'

with open(file_path, 'w') as file:
    file.write(cells)
