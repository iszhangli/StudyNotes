#
# @lc app=leetcode.cn id=16 lang=python3
#
# [16] 最接近的三数之和
#

# @lc code=start
from cmath import inf
from typing import List


class Solution:
    def threeSumClosest(self, nums: List[int], target: int) -> int:
        # max_gap = inf
        # re = inf
        # n = len(nums)
        # for i in range(n):
        #     for j in range(i+1, n, 1):
        #         for k in range(j+1, n, 1):
        #             mid = nums[i] + nums[j] + nums[k] 

        #             # if abs(target-mid) == 0:
        #             #     return mid
        #             if abs(target-mid) < max_gap:
        #                 max_gap = abs(target-mid)
        #                 re = mid
        # print(re)
        # return re
        max_gap = inf
        re = inf
        nums = sorted(nums)
        n = len(nums)
        for i in range(n-2):
            left, right = i+1, n-1
            while left < right:
                mid = nums[i] + nums[left] + nums[right]
                if target-mid == 0:
                    return target

                if abs(target-mid) <= max_gap and target - mid < 0:
                    max_gap = abs(target-mid)
                    re = mid
                    right -= 1
                    print(i, left, right)
                elif abs(target-mid) <= max_gap and target - mid > 0:
                    max_gap = abs(target-mid)
                    re = mid
                    left += 1
                elif abs(target-mid) > max_gap and target - mid < 0:
                    right -= 1
                else:
                    left += 1
        print(re)
        return re
l = [13,252,-87,-431,-148,387,-290,572,-311,-721,222,673,538,919,483,-128,-518,7,-36,-840,233,-184,-541,522,-162,127,-935,-397,761,903,-217,543,906,-503,-826,-342,599,-726,960,-235,436,-91,-511,-793,-658,-143,-524,-609,-728,-734,273,-19,-10,630,-294,-453,149,-581,-405,984,154,-968,623,-631,384,-825,308,779,-7,617,221,394,151,-282,472,332,-5,-509,611,-116,113,672,-497,-182,307,-592,925,766,-62,237,-8,789,318,-314,-792,-632,-781,375,939,-304,-149,544,-742,663,484,802,616,501,-269,-458,-763,-950,-390,-816,683,-219,381,478,-129,602,-931,128,502,508,-565,-243,-695,-943,-987,-692,346,-13,-225,-740,-441,-112,658,855,-531,542,839,795,-664,404,-844,-164,-709,167,953,-941,-848,211,-75,792,-208,569,-647,-714,-76,-603,-852,-665,-897,-627,123,-177,-35,-519,-241,-711,-74,420,-2,-101,715,708,256,-307,466,-602,-636,990,857,70,590,-4,610,-151,196,-981,385,-689,-617,827,360,-959,-289,620,933,-522,597,-667,-882,524,181,-854,275,-600,453,-942,134]
t = -2805
Solution().threeSumClosest(l, t)
# @lc code=end

