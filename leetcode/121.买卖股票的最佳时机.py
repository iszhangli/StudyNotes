#
# @lc app=leetcode.cn id=121 lang=python3
#
# [121] 买卖股票的最佳时机
#

# @lc code=start
from typing import List


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        max_profit = 0
        left, right = 0, 1
        while right < len(prices):
            if prices[left] < prices[right]:
                max_profit = max(prices[right]-prices[left], max_profit)
            else:
                left = right
            right += 1
        return max_profit
l = [3,3,5,0,0,3,1,4]
Solution().maxProfit(l)
# @lc code=end

