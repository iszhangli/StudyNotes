#
# @lc app=leetcode.cn id=5 lang=python3
#
# [5] 最长回文子串
#

# @lc code=start


class Solution:
    def longestPalindrome(self, s: str) -> str:
        # re = ''
        # length = len(s)
        # def is_true(s):
        #     for i in range(len(s)//2): # 向下取整
        #         if s[i]!=s[-(i+1)]:
        #             return False
        #     return True
        # # 遍历出所有长度大于2的字串，由长到短
        # for i in range(length):  # range 前闭后开
        #     for j in range(length, i, -1):
        #         # 判断字串是不是回文
        #         cand_s = s[i:j]
        #         if len(re) >= len(cand_s):
        #             break
        #         if is_true(cand_s):
        #             re = cand_s
        # return re
        # --
        # dp
        n = len(s)
        dp = [[False]*n for _ in range(n)]

        max_len = 0
        left, right = 0, 0
        # for i in range(n):
        #     dp[i][i] = True
        # dp[i][j] = dp[i+1][j-1] && s[i]==s[j] 
        for i in range(n-1, -1, -1):
            for j in range(i, n, 1):
                if j - i <= 1:
                    if s[i] == s[j]: dp[i][j] = True
                else:
                    if (s[i] == s[j]) and (dp[i+1][j-1]): 
                        dp[i][j] = True

                if dp[i][j] and j-i+1>max_len:
                    max_len = j-i+1
                    left = i
                    right = j+1
        return s[left:right]
            

s = 'babad'
# cbbd cbb cb c bbd bb b bd b d 
Solution().longestPalindrome(s)
# @lc code=end

