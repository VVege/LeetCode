//
//  FirstMissing.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/5/28.
//  Copyright © 2019年 vege. All rights reserved.
//

import UIKit
/// https://leetcode-cn.com/problems/first-missing-positive/
/// 给定一个未排序的整数数组，找出其中没有出现的最小的正整数。
//  说明:
//  你的算法的时间复杂度应为O(n)，并且只能使用常数级别的空间。

///第一次尝试完全没思路
///看了网上版本，写一个试试
class FirstMissing: NSObject {
   public class func firstMissingPositive(_ nums:inout [Int]) -> Int {
        
        var index:Int = 0
        while index < nums.count {
            while (nums[index] > 0) && (nums[index] <= nums.count) && (nums[nums[index] - 1] != nums[index]) {
                let value = nums[index]
                let temp = nums[value - 1]
                nums[value - 1] = value
                nums[index] = temp
            }
            index += 1
        }
        
        index = 0
        while index < nums.count {
            if index + 1 != nums[index] {
                return index + 1
            }
            index += 1
        }
        return index + 1
    }
}

///网上标准答案
///1.首次循环判断是否有1，无则return1，有则继续2
///2.因为数组中有1，将<= 0 或 >n 的不合格元素替换成1
///3.利用负号标记已存在的元素
///如果便利到当前元素值为3，则 a[3] = -abs(a[3])
///4.a[0]的元素正负号代表 值为n的元素是否存在；这里取巧方法，也可以a[n - 1] 的值的正负代表 值n是否存在
extension FirstMissing{
    public class func a_firstMissingPositive(_ nums:inout [Int]) -> Int {
        
        var exist1 = false
        for a in nums {
            if a == 1 {
                exist1 = true
                break
            }
        }
        
        if !exist1 {
            return 1
        }
        
        var index = 0
        while index < nums.count {
            if nums[index] <= 0 || nums[index] > nums.count {
                nums[index] = 1
            }
            index += 1
        }
        
        index = 0
        
        while index < nums.count {
            let value = abs(nums[index]) 
            if value == nums.count{
                nums[0] = -abs(nums[0])
            }else{
                nums[value] = -abs(nums[value])
            }
            index += 1
        }
        
        index = 1
        
        while index < nums.count {
            if nums[index] > 0 {
                return index
            }
            index += 1
        }
        
        if nums[0] > 0 {
            return nums.count
        }
        
        return nums.count + 1
    }
}
