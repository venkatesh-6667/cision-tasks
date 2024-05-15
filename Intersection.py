class ArrayIntersection:
    @staticmethod
    def find_intersection(arr1, arr2):
        intersection = []
        i, j = 0, 0
        
        while i < len(arr1) and j < len(arr2):
            if arr1[i] < arr2[j]:
                i += 1
            elif arr1[i] > arr2[j]:
                j += 1
            else:
                intersection.append(arr1[i])
                i += 1
                j += 1
                
        return intersection

# Example usage:
arr1 = [2, 4, 6, 8, 10]
arr2 = [3, 6, 9, 12]
result = ArrayIntersection.find_intersection(arr1, arr2)
print(result)  # Output: [6]
