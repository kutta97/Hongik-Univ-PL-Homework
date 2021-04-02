import re

count = int(input())

data_set = []
for i in range(count):
	data_set.append(input())

for data in data_set:
	if re.fullmatch('(100+1+|01)+', data): print("DANGER")
	else: print("PASS")