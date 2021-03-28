def merge_sort(list) -> list:
	if len(list) < 2:
		return list
	mid = len(list) // 2
	low = merge_sort(list[:mid])
	high = merge_sort(list[mid:])

	merged = []
	l = h = 0
	while l < len(low) and h < len(high):
		if low[l] < high[h]:
			merged.append(low[l])
			l += 1
		else:
			merged.append(high[h])
			h += 1
	merged += low[l:]
	merged += high[h:]
	return merged

list = list(map(int, input().split()))
print(merge_sort(list))