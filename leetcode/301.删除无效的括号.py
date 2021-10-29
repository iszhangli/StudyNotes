#
# @lc app=leetcode.cn id=301 lang=python3
#
# [301] 删除无效的括号
#

# @lc code=start
class Solution:
    def removeInvalidParentheses(self, s: str) -> List[str]:
        def isvalid(s):  # 判断字符串是否有效
            cnt = 0
            for c in s:
                if c == '(': cnt += 1
                elif c == ')': cnt -= 1
                if cnt < 0: return False
            return cnt == 0
        # bfs
        level = {s}
        while True:
            result = list(filter(isvalid, level))
            if result != []: return result
            next_level = set()
            for item in level:
                for i in range(len(item)):
                    if item[i] in '()':
                        next_level.add(item[:i] + item[i+1:])
            level = next_level

# @lc code=end

