#
# @lc app=leetcode.cn id=367 lang=python3
#
# [367] 有效的完全平方数
#

# @lc code=start
class Solution:
    def isPerfectSquare(self, num: int) -> bool:
        # 暴力
        # i = 0
        # while True:
        #     if i ** 2 == num:
        #         return True
        #     i += 1
        #     if i ** 2 > num:
        #         return False
        # 数学
        return num ** 0.5 % 1 == 0
        # 二分法

# @lc code=end

