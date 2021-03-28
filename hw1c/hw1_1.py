def binary_search(list, target, low, high):
	if low >= high:
		return -1
	mid = (low + high) // 2
	if list[mid] > target:
		return binary_search(list, target, low, mid)
	if list[mid] == target:
		return mid
	if list[mid] < target:
		return binary_search(list, target, mid + 1, high)

list = list(map(int, input().split()))
target = int(input())
output = binary_search(list, target, 0, len(list) - 1)

print("None" if output < 0 else output + 1)
