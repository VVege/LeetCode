//
//  Heap.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/15.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///大顶推

///堆是一种完全二叉树
///每一个节点都要比其所有子节点大或者小
///优势是可利用数组进行存储
class Heap {
    private var array:[Int] = []
    init() {
        array.append(0)
    }
}

extension Heap {
    public func append(value:Int) {
        array.append(value)
        var index = array.count - 1
        
        while index > 1 {
            let rootIndex = index/2
            if array[index] > array[rootIndex] {
                let temp = array[index]
                array[index] = array[rootIndex]
                array[rootIndex] = temp
                index = rootIndex
            }else{
                break
            }
        }
    }
    
    public func removeTop() -> Int {
        let topValue = array[1]
        array[1] = array[array.count - 1]
        array.removeLast()
        
        var index = 1
        while index <= array.count/2 - 1 {
            let subLeft = index*2
            let subRight = index*2 + 1
            var maxIndex = 0
            if array[subRight] > array[subLeft] {
                maxIndex = subRight
            }else{
                maxIndex = subLeft
            }
            if array[index] < array[maxIndex]{
                //交换
                let temp = array[index]
                array[index] = array[maxIndex]
                array[maxIndex] = temp
                index = maxIndex
            }
        }
        
        return topValue
    }
    
    public func printArray(){
        for i in 1 ..< array.count {
            print(array[i])
        }
    }
}
