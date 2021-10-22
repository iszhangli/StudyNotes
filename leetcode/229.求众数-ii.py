#
# @lc app=leetcode.cn id=229 lang=python3
#
# [229] 求众数 II
#

# @lc code=start
class Solution:
    def majorityElement(self, nums: List[int]) -> List[int]:
        # 方法1：哈希
        # cond = list()
        # nums_d = {}
        # for num in nums:
        #     if num in nums_d.keys(): # IN AND NOT IN
        #         nums_d[num] += 1
        #     else:
        #         nums_d[num] = 1
        # for k, v in nums_d.items():
        #     if v > len(nums) / 3:
        #         cond.append(k)
        
        # return cond
        # 方法2：摩尔投票
        cand1, cand2 = 0, 0
        vote1, vote2 = 0, 0
        for num in nums:
            if vote1 > 0 and cand1 == num:
                vote1 += 1
            elif vote2 > 0 and cand2 == num:
                vote2 += 1
            elif vote1 == 0:
                cand1 = num
                vote1 += 1
            elif vote2 == 0:
                cand2 = num
                vote2 += 1
            else:
                vote1 -= 1
                vote2 -= 1
        vote1, vote2 = 0, 0
        for num in nums:
            if num == cand1:
                vote1 += 1
            elif num == cand2:
                vote2 += 1
        l = []
        if vote1 > len(nums) / 3:
            l.append(cand1)
        if vote2 > len(nums) / 3:
            l.append(cand2)
        return l
# @lc code=end

