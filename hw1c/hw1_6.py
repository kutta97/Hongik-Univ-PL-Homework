PATTERN = "(100~1~|01)~"

def data_encryption_analyis(data):
	i = 0
	while i < len(data):
		if len(data[i:]) >= len("100") and data[i:i+3] == "100":
			i += len("100")
			while i < len(data) and data[i] == '0': i+= 1
			if i == len(data): print("PASS"); return
			if data[i] == '1': 
				while i < len(data) and data[i] == '1': i+= 1
			else: print("PASS"); return
			if i < len(data) and data[i] == '0': i -= 1
			continue
		if len(data[i:]) >= len("01") and data[i:i+2] == "01":
			i += len("01"); continue
		print("PASS"); return
	print("DANGER")

count = int(input())

data_set = []
for i in range(count):
	data_set.append(input())

for data in data_set:
	data_encryption_analyis(data)