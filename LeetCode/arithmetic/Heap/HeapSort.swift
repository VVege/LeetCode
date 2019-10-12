//
//  HeapSort.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/15.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///堆排序
///原地排序算法，不需额外空间
///1.建堆
///2.排序

class HeapSort {
    
    ///从小到大排序
    public class func sort(with array:inout [Int]){
        //自下而上选取index，子叶节点是被交换的，所以index取值 0 ～ count/2 - 1
        if array.count <= 1 {
            return
        }
        
        //建个大顶堆
        for index in (0 ... array.count/2 - 1).reversed() {
            var currentIndex = index
            while currentIndex <= array.count/2 - 1 {
                let subLeft = currentIndex*2 + 1
                let subRight = currentIndex*2 + 2
                var maxIndex = 0
                //堆中非叶子节点可能没有右子节点
                if subRight > array.count - 1{
                    maxIndex = subLeft
                }else if array[subRight] < array[subLeft]{
                    maxIndex = subLeft
                }else{
                    maxIndex = subRight
                }
                if array[maxIndex] > array[currentIndex]{
                    //交换
                    let temp = array[maxIndex]
                    array[maxIndex] = array[currentIndex]
                    array[currentIndex] = temp
                    currentIndex = maxIndex
                }else{
                    break
                }
            }
        }
        
        //排序
        //将堆顶和末位元素替换
        //堆化
        //直到完成

        var lastIndex = array.count - 1
        while lastIndex > 0 {
            let temp = array[0]
            
            array[0] = array[lastIndex]
            array[lastIndex] = temp
            lastIndex -= 1

            var currentIndex = 0
            while true {
                let subLeft = currentIndex*2 + 1
                let subRight = currentIndex*2 + 2
                var maxIndex = 0
                
                if subLeft > lastIndex {
                    break
                }
                else if subRight > lastIndex {
                    maxIndex = subLeft
                }else if array[subRight] < array[subLeft]{
                    maxIndex = subLeft
                }else{
                    maxIndex = subRight
                }
                
                if array[maxIndex] > array[currentIndex]{
                    //交换
                    let temp = array[maxIndex]
                    array[maxIndex] = array[currentIndex]
                    array[currentIndex] = temp
                    currentIndex = maxIndex
                }else{
                    break
                }
            }
        }
    }
}
