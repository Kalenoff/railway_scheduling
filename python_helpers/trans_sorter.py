answer = """laggy_transition(1,turn_right) real_transition(0,turn_right) laggy_transition(4,turn_right) real_transition(3,turn_right) laggy_transition(10,wait) real_transition(9,wait) laggy_transition(12,move_forward) real_transition(11,move_forward) laggy_transition(2,turn_right) real_transition(8,wait) laggy_transition(13,move_forward) real_transition(5,move_forward) real_transition(6,move_forward) real_transition(7,turn_left)"""

answer_listed = answer.split(" ")

# answer_listed_sorted = sorted(answer_listed, key=lambda x: int(x.split('(')[1].split(',')[1]))

answer_listed_sorted = sorted(answer_listed, key=lambda x: int(x.split('(')[1].split(',')[0]))

print(answer_listed_sorted)