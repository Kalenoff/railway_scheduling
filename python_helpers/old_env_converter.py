from copy import deepcopy

input_env = """cell((1,0), 0).
cell((1,2), 0).
cell((1,1), 0).
cell((0,1), 0).
"""

input_env_listed_cleared = [x.replace('\n', '') for x in input_env.split('.')[:-1]]

y_old = sorted(set([x[6] for x in input_env_listed_cleared]))
y_new = deepcopy(y_old)
y_new.reverse()

y_mapper = dict(zip(y_old, y_new))

def y_replacer(cell_string):
    cell_string_listed = list(cell_string)
    y_old = cell_string_listed[6]
    y_new = y_mapper[y_old]
    cell_string_listed[6] = y_new
    cell_string_new = "".join(cell_string_listed)
    return cell_string_new

output_env = ".\n".join([y_replacer(x) for x in input_env_listed_cleared]) + '.'

print(output_env)