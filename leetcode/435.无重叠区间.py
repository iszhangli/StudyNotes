#
# @lc app=leetcode.cn id=435 lang=python3
#
# [435] 无重叠区间
#

# @lc code=start
class Solution:
    def eraseOverlapIntervals(self, intervals) -> int:
        intervals.sort(key=lambda x: x[1])
        ans = 0
        prev = float('-inf')
        for i in intervals:
            if i[0] >= prev:
                prev = i[1]
            else:
                ans += 1
        return ans

# def erase(intervals):
#     intervals.sort(key=lambda x: x[1])
#     ans = 0
#     prev = float('-inf')
#     for i in intervals:
#         if i[0] >= prev:
#             prev = i[1]
#         else:
#             ans += 1
#     return ans
# l = [[1,100],[11,22],[1,11],[2,12]]
# print(erase(l))
# @lc code=end

