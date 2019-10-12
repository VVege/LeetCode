//
//  3sum.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/5/18.
//  Copyright © 2019年 vege. All rights reserved.
//

///https://leetcode-cn.com/problems/3sum/
/*
 给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。
 
 注意：答案中不可以包含重复的三元组。
 */

import Foundation

class ThreeSum {}

//MARK:初次尝试通过
//1.分步遍历（排列组合式）
//2.去重

//问题
//1:分步遍历时while循环代码凌乱
//2:去重问题不够灵活，无脑遍历略显智障
//基于这种思想的优化
//1:循环优化成这类写法
//for (let i = 0; i < nums.length - 2; i++) { // 每个人
//    for (let j = i + 1; j < nums.length - 1; j++) { // 依次拉上其他每个人
//        for (let k = j + 1; k < nums.length; k++) { // 去问剩下的每个人
//            if (nums[i] + nums[j] + nums[k] === 0) { // 我们是不是可以一起组队
//                res.push([nums[i], nums[j], nums[k]])
//            }
//        }
//    }
//}
//2:判断去重时可先把数组排序，对比相同时只需要o（n），目前是O（n*n）

extension ThreeSum {
    public class func threeSumToZero(nums:[Int]) {
        var a = 0
        var b = 1
        var c = 2
        var temp:[[Int]] = []
        
        var loopCounts = 0
        while a <= (nums.count - 3) {
            loopCounts += 1
            
            let aValue = nums[a]
            let bValue = nums[b]
            let cValue = nums[c]
            
            if aValue + bValue + cValue == 0 {
                var isExist:Bool = false
                for array in temp {
                    if isEqual(nums0: array, nums1: [aValue,bValue,cValue]){
                        isExist = true
                        break
                    }
                }
                
                if !isExist {
                    temp.append([aValue,bValue,cValue])
                    print("相加为零的三个数为 a:\(aValue),b:\(bValue),c:\(cValue)")
                }
            }
            
            c += 1
            if c > nums.count - 1 {
                b += 1
                if b > nums.count - 2 {
                    a += 1
                    b = a + 1
                }
                c = b + 1
            }
        }
        print("循环次数为\(loopCounts)")
    }
    
    private class func isEqual(nums0:[Int], nums1:[Int]) -> Bool {
        
        for i in 0 ..< nums0.count {
            var find:Bool = false
            for j in 0 ..< nums1.count {
                if nums0[i] == nums1[j] {
                    find = true
                }
            }
            if !find {
                return false
            }
        }
        return true
        
    }
}

//MARK:网上优化版本
extension ThreeSum {
    public class func f_threeSumToZero(nums:[Int]){
        //1.数组排序
        //思维方式：因结果需要过滤相同元素的数组，且对于元素位置无任何要求
        //因为求和为0使得数据正负值更便于处理
        
        //2.中部凿井法
        //方式：寻找中点，从第二点开始为中点，依次将其左右点相加，直到中点到倒数第二点
        //思维方式: 以三点和为零构建的特殊处理方式，分中左右
        
        //3.具体优化点
        //相同数组。for 循环遍历20次，而中部凿井法 为8次
        //如果和已经大于零，则省掉了继续左移rigntPoint的次数，小于零同理
        //而for循环方案不具备此优化，全遍历
        
        //测试循环次数
        var loopCounts = 0
        
        var temp = nums
        temp.sort { (a, b) -> Bool in
            return a < b
        }
        var centerPoint:Int = 1
        while centerPoint <= temp.count - 2 {
            var leftPoint = 0
            var rightPoint = temp.count - 1
            
            while(true){
                loopCounts += 1
                let sum = temp[leftPoint] + temp[centerPoint] + temp[rightPoint]
                if sum < 0 {
                    //右移
                    leftPoint += 1
                    if leftPoint == centerPoint {
                        centerPoint += 1
                        break
                    }
                }else if sum > 0 {
                    //左移
                    rightPoint -= 1
                    if rightPoint == centerPoint {
                        centerPoint += 1
                        break
                    }
                    
                }else{
                    //记录
                    print("相加为零的三个数为 a:\(temp[leftPoint]),b:\(temp[centerPoint]),c:\(temp[rightPoint])")
                    centerPoint += 1
                    break
                }
            }
        }
        print("循环次数为\(loopCounts)")
    }
}

//MARK:发散思维 借助其他数据结构来完善此方法
extension ThreeSum {
    //哈希表
    //更好理解的途径
    //2Sum：求数组中和 = target 的两个元素
    //例子：求[-1, 0, 1, 2, -1, -4] 和 = 0 的两个数
    //step1:遍历数组，建立target hash表
    //targetHash {-value:value}: {1:-1, 0:0, -1:1, -2:2, 1:-1, 4:-4}
    //step2:再次遍历数组，以当前值为key，能找到对应value则标记一对儿和为0的两个元素。
    
    //3Sum
    //step1:遍历数组，建立target hash表
    //例子：求[-1, 0, 1, 2, -1, -4] 和 = 0 的三个数
    //value为没两对数的数组，key为能与这两个数和为0的数字
    //targetHash {-value:value}: {1:(-1，0), 0:(-1,1), -1:(-1,2)), 2:(-1,-1),5:(-1,-4)...}
    //step2:再次遍历数组，以当前值为key，能找到对应value则标记三个数。
}

//MARK:发散思维，求数组中所有可以和为零的子元素集合
extension ThreeSum {
    public class func allSumToZero(nums:[Int]) {
        var temp = nums
        
        temp.sort { (a, b) -> Bool in
            return a < b
        }
        
        for i in 0 ..< temp.count {
            for j in stride(from: temp.count - 1, to: i, by: -1) {
                var sum = temp[i]
                for k in stride(from: j, to: i, by: -1){
                    sum = sum + temp[k]
                    if sum == 0{
                        printSub(nums: temp, i: i, j: j, k: k)
                    }
                }
            }
        }
        
    }
    
    private class func printSub(nums:[Int],i:Int,j:Int,k:Int){
        print("start \n\(nums[i])")
        for index in k...j {
            print(nums[index])
        }
    }
}
