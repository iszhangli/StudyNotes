#
# @lc app=leetcode.cn id=70 lang=python3
#
# [70] 爬楼梯
#

# @lc code=start
class Solution:
    def climbStairs(self, n: int) -> int:
        # 1: 动态规划 dp[i] = dp[i-1] + dp[i-2]
        # 2: 递归函数 f(i) = f(i-1) + f(i-2) return f(i)
        cache = list(range(n+1))
        
        for i in range(n+1):
            if i==0 or i==1 or i==2:
                cache[i] = i
            else:
                cache[i] = cache[i-1] + cache[i-2]
        return cache[n]

# n = Solution().climbStairs(38)
# print(n)
# @lc code=end