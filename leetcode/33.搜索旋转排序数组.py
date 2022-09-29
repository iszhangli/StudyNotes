#
# @lc app=leetcode.cn id=33 lang=python3
#
# [33] 搜索旋转排序数组
#

# @lc code=start
class Solution:
    def search(self, nums, target: int) -> int:
        low, high = 0, len(nums)-1
        while(low<=high):
            mid = low + (high-low)//2
            if target == nums[mid]:
                return mid
            
            if nums[low] <= nums[mid]: # [1, 2, 3, 4, 0]
                if nums[low] <= target < nums[mid]:
                    high = mid-1
                else:
                    low = mid+1
            else:
                if nums[mid] < target <= nums[high]:
                    low = mid + 1
                else:
                    high = mid -1
        return -1 

nums = [3,1]
target = 1           
print(Solution().search(nums, target))
# @lc code=end

