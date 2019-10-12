//
//  ReverseOrderNum.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/21.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///分治算法核心
///将复杂的大问题分解成小问题
///小问题合并时采取优化措施，从而减少时间复杂度

//使用分治算法
//求一个数组中逆序数的个数
class ReverseOrderNum {
    private var nums:[Int]!
    private var count = 0
    init(array:[Int]) {
        nums = array
    }
    
    //MARK:自己写的简陋版
    private func mergeReverseNums(reverseArray:[Int], dataArray:[[Int]]){
        if reverseArray.count != dataArray.count {
            print("Error:数据错误")
            return
        }
        
        if reverseArray.count == 1{
            print("逆序数的个数为\(reverseArray[0])")
            return
        }
        
        var newDataArray:[[Int]] = []
        var newReverseArray:[Int] = []
        
        var index = 0
        while index < reverseArray.count{
            let num1 = reverseArray[index]
            var num2 = 0
            var num3 = 0
            if index + 1 < reverseArray.count {
                num2 = reverseArray[index + 1]
                
                let array1 = dataArray[index]
                let array2 = dataArray[index + 1]
                num3 = reverseNum(array1: array1, array2: array2)
                
                var mergeArray = Array.init(array1)
                mergeArray.append(contentsOf: array2)
                
                newDataArray.append(mergeArray)
                newReverseArray.append(num1 + num2 + num3)
            }else{
                let array1 = dataArray[index]
                newDataArray.append(array1)
                newReverseArray.append(num1)
            }
            
            index += 2
        }
        mergeReverseNums(reverseArray: newReverseArray, dataArray: newDataArray)
    }
    
    ///计算两个数组间的逆序数
    private func reverseNum(array1:[Int], array2:[Int]) -> Int {
        var count = 0
        for i in 0 ..< array1.count {
            for j in 0 ..< array2.count {
                if array2[j] < array1[i]{
                    count += 1
                }
            }
        }
        return count
    }
    
    private func separateAndMerge(array:inout [Int],low:Int,high:Int) {
        if low >= high {
            return
        }
        
        let middle = (low + high)/2
        separateAndMerge(array: &array, low: low, high: middle)
        separateAndMerge(array: &array, low: middle + 1, high: high)
        merge(array: &array, low: low, middle: middle, high: high)
    }
    
    private func merge(array:inout [Int], low:Int,middle:Int,high:Int) {
        var temp:[Int] = []
        
        var lowPoint = low
        var highPoint = middle + 1
        
        while lowPoint <= middle && highPoint <= high {
            let value1 = array[lowPoint]
            let value2 = array[highPoint]
            if value1 <= value2 {
                temp.append(value1)
                lowPoint += 1
            }else{
                //***这里是计算逆序度的重点***//
                //1.计算每两个数之间的逆序数 n1
                //2.合并两个有序数组的逆序值为 n1 + n2 + 两个数组间的逆序数
                //3.计算两个数组间的逆序数：当使用temp数组合并时，lowPoint停留的位置代表着后面的数组比前面数组 元素值小的个数。
                //通过指针停留位置可一次将逆序数值增加多个，减少循环次数
                let add = (middle - lowPoint + 1)
                count += add
                temp.append(value2)
                highPoint += 1
            }
        }
        
        if lowPoint <= middle {
            for i in lowPoint ... middle {
                temp.append(array[i])
            }
        }else if highPoint <= high {
            for i in highPoint ... high {
                temp.append(array[i])
            }
        }
        
        //同步array值
        for i in 0 ..< temp.count {
            array[low + i] = temp[i]
        }
    }
}


extension ReverseOrderNum {
    ///自己写的简陋版
    public func vg_printReverseOrderNum() {
        var reverseArray:[Int] = []
        for _ in 0 ..< nums.count {
            reverseArray.append(0)
        }
        
        var dataArray:[[Int]] = []
        for i in 0 ..< nums.count {
            dataArray.append([nums[i]])
        }
        mergeReverseNums(reverseArray: reverseArray, dataArray: dataArray)
    }
    
    ///教材版：直接归并排序
    public func printReverseOrderNum() {
        count = 0
        separateAndMerge(array: &nums, low: 0, high: nums.count - 1)
        print("逆序数的个数为\(count)")
    }
}
