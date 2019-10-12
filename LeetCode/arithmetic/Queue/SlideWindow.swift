//
//  SlideWindow.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/7/25.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//给定一个数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口 k 内的数字。滑动窗口每次只向右移动一位。
//https://leetcode-cn.com/problems/sliding-window-maximum/

class SlideWindow: NSObject {
    
    private var windowArray:[Int] = []
    private var numArray:[Int] = []
    private var windowSize:Int = 0
    
    private func printArray(array:[Int]) {
        for value in array {
            print("\n\(value)")
        }
    }
    
    init(windowSize:Int) {
        super.init()
        self.windowSize = windowSize
    }
    
    private func clear() {
        let currentIndex = windowArray[windowArray.count - 1]
        let currentValue = numArray[currentIndex]
        
        windowArray.removeAll { (value) -> Bool in
            return numArray[value] < currentValue
        }
    }
}

//MARK:Public
//双向队列解法：
extension SlideWindow {
    public func slide(array:[Int]){
        numArray = array
        
        //确定好初始最大值
        var initMaxValueIndex = 0
        for index in 0 ..< windowSize {
            if numArray[index] > numArray[initMaxValueIndex] {
                initMaxValueIndex = index
            }
        }
        windowArray.append(initMaxValueIndex)
        
        //建立输出数组，将第一位设置为初始最大值
        var output:[Int] = []
        output.append(numArray[windowArray[0]])
        
        
        for index in windowSize ..< numArray.count {
            let currentHeadIndex = index - windowSize + 1
            
            //头部元素从窗口移除
            if windowArray[0] < currentHeadIndex {
                windowArray.removeFirst()
            }
            
            //尾部元素从窗口移入
            windowArray.append(index)
            //清理windowArray中比尾部数值小的元素
            clear()
            
            //因为每一步的时候都清理了比当前尾部小的元素
            //所以windowArray的头，就是所选最大值
            output.append(numArray[windowArray[0]])
        }
        
        printArray(array: output)
    }
}

//动态规划解法
extension SlideWindow {
    public func slide1(array:[Int]) {
        numArray = array
        var left:[Int] = []
        var right:[Int] = []
        
        var subCount = array.count / windowSize
        if array.count % windowSize != 0 {
            subCount += 1
        }
        
        for countIndex in 0 ..< subCount {
            var max:Int = -100000
            for index in (countIndex * windowSize) ..< (countIndex + 1) * windowSize {
                if numArray[index] > max {
                    max = numArray[index]
                }
                left.append(max)
            }
        }
        
        for countIndex in 0 ..< subCount {
            
            var max:Int = -100000
            var insertIndex = countIndex * windowSize
            
            for index in (countIndex * windowSize ..< (countIndex + 1) * windowSize).reversed(){
                if numArray[index] > max {
                    max = numArray[index]
                }
        
                right.insert(max, at: insertIndex)
                insertIndex += 1
            }
        }
        
        
        var output:[Int] = []
        for i in 0 ... numArray.count - windowSize {
            let j = i + windowSize - 1
            let maxValue = max(right[i], left[j])
            output.append(maxValue)
        }
        
        printArray(array: output)
    }
}
