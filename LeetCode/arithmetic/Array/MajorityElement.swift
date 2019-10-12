//
//  MajorityElement.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/5/22.
//  Copyright © 2019年 vege. All rights reserved.
//

//给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
//
//你可以假设数组是非空的，并且给定的数组总是存在众数
import Foundation

class MajorityElement {
    
    /// 初试想法
    /// 借助哈希表记录出现次数
    /// 缺点是没有对于题目的针对性
    public class func majorityNumber(nums:[Int]) {
        var dic:[Int:Int] = [:]
        for i in nums {
            dic[i] = ((dic[i]) ?? 0) + 1
        }
        for j in dic.keys {
            if (dic[j] ?? 0) > nums.count / 2 {
                print("众数是\(j)")
            }
        }
    }
    
    
    /// 网络优化版方法
    /// 借助一个flag来判断众数
    /// 一次循环，不借助外结构。
    /// 核心：众数其实是数组中出现最多次的数字，且数量大于数组数量的一半
    public class func a_majorityNumber(nums:[Int]) {
        var currentRecord:Int = 0
        var flag:Int = 0
        for i in nums {
            if i == currentRecord {
                flag += 1
            }else{
                if flag == 0 {
                    currentRecord = i
                    flag = 1
                }else{
                    flag -= 1
                }
            }
        }
        
        print("众数是\(currentRecord)")
    }
}
