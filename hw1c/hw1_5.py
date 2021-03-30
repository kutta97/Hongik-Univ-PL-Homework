NUM = 0; START = 1; END = 2

def lecture_sort(lectures, count):
	if len(lectures) <= 1:
		return lectures
	pivot = lectures[count // 2][END]
	lesser, equal, greater = [], [], []
	for i in range(count):
		if lectures[i][END] < pivot:
			lesser.append(lectures[i])
		elif lectures[i][END] > pivot:
			greater.append(lectures[i])
		else:
			equal.append(lectures[i])
	return lecture_sort(lesser, len(lesser)) + equal + lecture_sort(greater, len(greater))

def activity_selection(lectures, count):
	result = [lectures[0][NUM]]
	before = 0
	for i in range(1, count):
		if lectures[i][START] >= lectures[before][END]:
			result.append(lectures[i][NUM])
			before = i
	return result

# count of lectures
count = int(input())

# lectures input
lectures = []
for i in range(count):
	lectures.append(list(map(int, input().split())))

lectures = lecture_sort(lectures, count)
print(activity_selection(lectures, count))
