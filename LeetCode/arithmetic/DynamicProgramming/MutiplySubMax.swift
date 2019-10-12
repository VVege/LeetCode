//
//  MutiplySubMax.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/26.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//给定一个整数数组 nums ，找出一个序列中乘积最大的连续子序列（该序列至少包含一个数）。
//https://leetcode-cn.com/problems/maximum-product-subarray/
//这题太巧妙了啊,感觉很难想到。
///动态方程：f(i) = max(preMax*array[i], preMin*array[i], array[i])
class MutiplySubMax {
    
    private var array:[Int]!
    
    init(array:[Int]) {
        self.array = array
        getMax(index: 1, preMax: array[0], preMin: array[0])
    }
    
    private func getMax(index:Int, preMax:Int, preMin:Int) {
        if index > array.count - 1 {
            print("最大乘积\(preMax)")
            return
        }
        
        let value = array[index]
        
        var currentMax = 0
        let max1 = value * preMax
        let max2 = value * preMin
        let max3 = value
        currentMax = max(max1, max2)
        currentMax = max(currentMax, max3)
        
        var currentMin = 0
        let min1 = value * preMin
        let min2 = value * preMax
        let min3 = value
        currentMin = min(min1, min2)
        currentMin = min(currentMin, min3)
        
        getMax(index: index + 1, preMax: currentMax, preMin: currentMin)
    }
}
