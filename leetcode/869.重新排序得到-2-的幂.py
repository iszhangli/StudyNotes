#
# @lc app=leetcode.cn id=869 lang=python3
#
# [869] 重新排序得到 2 的幂
#

# @lc code=start
from typing import Text


class Solution:
    
    def reorderedPowerOf2(self, n: int) -> bool:
        def isPowerOfTwo(n: int) -> bool:
            return n & (n-1) == 0
        nums = sorted(list(str(n)))
        res = []
        # 
        def backtrack(nums, tmp):
            if not nums:
                res.append(tmp)
                return
            for i in range(len(nums)):
                if i>0 and nums[i]==nums[i-1]: # 剪枝
                    continue
                state = tmp + [nums[i]]
                path = nums[:i] + nums[i+1:]
                backtrack(path, state)
        backtrack(nums, [])
        
        for tmpL in res:
            if tmpL[0] == '0':  # 首字母是0的情况
                continue
            tmpR = 0
            for id, v in enumerate(tmpL[::-1]):
                tmpR += int(v) * 10**id
            if isPowerOfTwo(tmpR):
                return True
        return False


# @lc code=end

