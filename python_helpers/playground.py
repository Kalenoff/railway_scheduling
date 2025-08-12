def clean_transitions(input_string):
    # Split the input string into individual lines
    lines = input_string.split('\n')

    # Remove "laggy_" and "real_" from each line
    cleaned_lines = [line.replace('laggy_transition', 'transition').replace('real_transition', 'transition') for line in lines]

    return cleaned_lines

input_string = """real_transition(1,0,1,east,move_forward,2,east) real_transition(1,1,2,east,move_forward,8,south) real_transition(1,2,8,south,move_forward,14,south) real_transition(1,3,14,south,move_forward,13,west) real_transition(1,4,13,west,move_forward,12,west) laggy_transition(1,5,13,west,move_forward,12,west)"""

cleaned_transitions = clean_transitions(input_string)
for transition in cleaned_transitions:
    print(transition)
