#
# @lc app=leetcode.cn id=575 lang=python3
#
# [575] 分糖果
#

# @lc code=start
class Solution:
    def distributeCandies(self, candyType: List[int]) -> int:
        # hash sorted
        d = {}
        for i in candyType:
            if i is d.keys():
                d[i] += 1
            else: d[i] = 1
        d = sorted(d.items(), key=lambda x: x[1])
        re = 0
        for k, v in d:
            re += 1
            if re >= len(candyType) / 2:
                return re
        return re
# @lc code=end

