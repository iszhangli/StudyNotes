#
# @lc app=leetcode.cn id=53 lang=python3
#
# [53] 最大子数组和
#

# @lc code=start
from cmath import inf
from typing import List


class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        dp = nums[0]
        res = nums[0]
        n = len(nums)
        for i in range(1, n, 1):
            # dp = max(nums[i], dp+nums[i])
            # 和项
            if dp < 0:
                dp = nums[i]
            else:
                dp = dp + nums[i]
            
            res = max(res, dp)
            
        return res
Solution().maxSubArray([-2,1,-3,4,-1,2,1,-5,4])
# @lc code=end

