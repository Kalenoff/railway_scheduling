from difflib import SequenceMatcher

def checker(answer_1: str, answer_2: str) -> str:
    if answer_1 == answer_2:
        return "Answers are identical"
    else:
        matcher = SequenceMatcher(None, answer_1, answer_2)
        ratio = matcher.ratio()
        opcodes = matcher.get_opcodes()
        for opcode in opcodes:
            tag, i1, i2, j1, j2 = opcode
            if tag != 'equal':
                return ratio, (f"{tag}: str1[{i1}:{i2}] = '{str1[i1:i2]}' vs str2[{j1}:{j2}] = '{str2[j1:j2]}'")
        

str1 = """transition(0,0,28,north,move_forward,38,north) transition(0,1,38,north,move_forward,48,north) transition(0,2,48,north,move_forward,47,west) transition(0,3,47,west,move_forward,46,west) transition(0,4,46,west,move_forward,56,north) transition(0,5,56,north,turn_right,57,east) transition(0,6,57,east,move_forward,58,east) transition(0,7,58,east,move_forward,68,north) transition(0,8,68,north,move_forward,78,north) transition(0,9,78,north,move_forward,88,north) transition(0,10,88,north,move_forward,87,west) transition(0,11,87,west,move_forward,86,west) transition(0,12,86,west,move_forward,85,west) transition(0,13,85,west,move_forward,75,south) transition(0,14,75,south,move_forward,65,south) transition(0,15,65,south,turn_right,64,west) transition(0,16,64,west,move_forward,63,west) transition(0,17,63,west,move_forward,53,south) transition(0,18,53,south,move_forward,43,south) transition(0,19,43,south,turn_right,42,west) transition(0,20,42,west,move_forward,32,south) transition(0,21,32,south,move_forward,31,west) transition(0,22,31,west,move_forward,21,south) transition(0,23,21,south,move_forward,11,south) transition(0,24,11,south,move_forward,12,east) transition(0,25,12,east,move_forward,13,east) transition(0,26,13,east,move_forward,23,north) transition(0,27,23,north,move_forward,33,north) transition(0,28,33,north,move_forward,43,north) transition(0,29,43,north,move_forward,53,north) transition(0,30,53,north,turn_left,52,west) transition(0,31,52,west,move_forward,51,west) transition(0,32,51,west,move_forward,61,north) transition(0,33,61,north,move_forward,71,north)
"""
str2 = """transition(0,0,28,north,move_forward,38,north) transition(0,1,38,north,move_forward,48,north) transition(0,2,48,north,move_forward,47,west) transition(0,3,47,west,move_forward,46,west) transition(0,4,46,west,move_forward,56,north) transition(0,5,56,north,turn_right,57,east) transition(0,6,57,east,move_forward,58,east) transition(0,7,58,east,move_forward,68,north) transition(0,8,68,north,move_forward,78,north) transition(0,9,78,north,move_forward,88,north) transition(0,10,88,north,move_forward,87,west) transition(0,11,87,west,move_forward,86,west) transition(0,12,86,west,move_forward,85,west) transition(0,13,85,west,move_forward,75,south) transition(0,14,75,south,move_forward,65,south) transition(0,15,65,south,turn_right,64,west) transition(0,16,64,west,move_forward,63,west) transition(0,17,63,west,move_forward,53,south) transition(0,18,53,south,move_forward,43,south) transition(0,19,43,south,move_forward,33,south) transition(0,20,33,south,move_forward,23,south) transition(0,21,23,south,move_forward,13,south) transition(0,22,13,south,move_forward,12,west) transition(0,23,12,west,move_forward,11,west) transition(0,24,11,west,move_forward,21,north) transition(0,25,21,north,move_forward,31,north) transition(0,26,31,north,move_forward,32,east) transition(0,27,32,east,move_forward,42,north) transition(0,28,42,north,move_forward,43,east) transition(0,29,43,east,move_forward,53,north) transition(0,30,53,north,turn_left,52,west) transition(0,31,52,west,move_forward,51,west) transition(0,32,51,west,move_forward,61,north) transition(0,33,61,north,move_forward,71,north)
"""

print(checker(str1, str2))