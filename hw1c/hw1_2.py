def quick_sort(list) -> list:
	if len(list) <= 1:
		return list
	pivot = list[len(list) // 2]
	lesser, equal, greater = [], [], []
	for i in list:
		if i < pivot:
			lesser.append(i)
		elif i > pivot:
			greater.append(i)
		else:
			equal.append(i)
	return quick_sort(lesser) + equal + quick_sort(greater)

list = list(map(int, input().split()))
print(quick_sort(list))