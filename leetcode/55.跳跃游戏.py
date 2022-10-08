#
# @lc app=leetcode.cn id=55 lang=python3
#
# [55] 跳跃游戏
#

# @lc code=start
from ast import List


class Solution:
    def canJump(self, nums):
        length, right = len(nums) - 1, len(nums) - 1 
        while right >= 0:
            ix = 1
            while nums[right] == 0 and right < length:
                if ix > right:
                    return False
                if nums[right-ix] > ix:
                    break
                ix += 1
            right -= ix
        return True
l = [0,1]
Solution().canJump(l)
# @lc code=end

