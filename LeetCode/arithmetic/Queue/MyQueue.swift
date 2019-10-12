//
//  MyQueue.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/7/20.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//https://leetcode-cn.com/problems/design-circular-deque/solution/shi-yong-xun-huan-shu-zu-lai-shi-xian-shuang-duan-/

//要点不使用数组插入api。避免数据搬移
class MyQueue {
    
    private var capacity = 0
    private var headIndex:Int = 0
    private var lastIndex:Int = 0
    private var empty:Bool = true
    private var array:[Int] = []
 
    init(capacity:Int) {
        self.capacity = capacity
        for _ in 0 ..< capacity {
            array.append(-1)
        }
    }
    
    public func insertFront(value: Int) -> Bool{
        if isFull() {
            return false
        }
        
        if !empty{
            if headIndex == 0 {
                headIndex = capacity - 1
            }else{
                headIndex -= 1
            }
        }
        
        array[headIndex] = value
        empty = false
        
        return true
    }
    
    public func insertLast(value: Int) -> Bool{
        if isFull() {
            return false
        }
        
        if !empty {
            if lastIndex == capacity - 1 {
                lastIndex = 0
            }
            lastIndex += 1
        }
        empty = false
        array[lastIndex] = value
        return true
    }
    
    public func deleteFront() -> Bool{
        if isEmpty() {
            return false
        }
        
        array[headIndex] = -1
        if headIndex == lastIndex {
            empty = true
            return true
        }
    
        headIndex += 1
        if headIndex > capacity - 1 {
            headIndex = 0
        }
        return true
    }
    
    public func deleteLast() -> Bool{
        if isEmpty() {
            return false
        }
        
        array[lastIndex] = -1
        if lastIndex == headIndex {
            empty = true
            return true
        }
        
        
        lastIndex -= 1
        if lastIndex < 0 {
            lastIndex = capacity - 1
        }
        return true
    }
    
    public func getFront() -> Int{
        return array[headIndex]
    }
    
    public func getRear() -> Int{
        return array[lastIndex]
    }
    
    public func isEmpty() -> Bool{
        return empty
    }
    
    public func isFull() -> Bool{
        let normal = (lastIndex - headIndex) == capacity - 1
        let moved =  (lastIndex == headIndex - 1)
        return normal || moved
    }
}
