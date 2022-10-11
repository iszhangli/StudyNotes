#
# @lc app=leetcode.cn id=1143 lang=python3
#
# [1143] 最长公共子序列
#

# @lc code=start
class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        M, N = len(text1), len(text2)
        dp = [[0]*(N+1) for _ in range(M+1)]
        for i in range(M):
            for j in range(N):
                if text1[i] != text2[j]:
                    dp[i+1][j+1] = max(dp[i+1][j], dp[i][j+1])
                else:
                    dp[i+1][j+1] = dp[i][j] + 1
        return dp[M][N]

text1, text2 = "abcde", "bace"
Solution().longestCommonSubsequence(text1, text2)
# @lc code=end

