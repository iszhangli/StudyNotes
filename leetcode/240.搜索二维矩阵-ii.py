#
# @lc app=leetcode.cn id=240 lang=python3
#
# [240] 搜索二维矩阵 II
#

# @lc code=start
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        # Z 字型查找
        row = len(matrix)
        col = len(matrix[0])
        m, n = row-1, 0
        while True:   # 这里还可以再优化一下 while m >=0 and n <len(maxtrix[0])
            if m < 0 or n >= col:
                return False
            elif matrix[m][n] == target:
                return True
            elif matrix[m][n] < target:
                n += 1
            elif matrix[m][n] > target:
                m -= 1
# @lc code=end

