#
# @lc app=leetcode.cn id=492 lang=python3
#
# [492] 构造矩形
#

# @lc code=start
class Solution:
    def constructRectangle(self, area: int) -> List[int]:
        w = int(math.sqrt(area)) # 向下取整
        while area % w != 0:
            w -= 1
        return [int(area/w), w]
# @lc code=end

