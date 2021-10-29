#
# @lc app=leetcode.cn id=47 lang=python3
#
# [47] 全排列 II
#

# @lc code=start
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        nums = sorted(nums)
        res = list()
        def backtrack(nums, tmp):
            if not nums:
                res.append(tmp)
                return
            for i in range(len(nums)):
                if i > 0 and nums[i-1]==nums[i]:
                    continue
                backtrack(nums[:i]+nums[i+1:], tmp+[nums[i]])
        backtrack(nums, [])
        return res
# @lc code=end

