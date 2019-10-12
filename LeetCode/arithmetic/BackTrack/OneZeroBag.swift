//
//  OneZeroBag.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/20.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///0-1背包问题
///从物品数组中选取最接近背包最大承重的s物品
class OneZeroBag {
    private var maxWeight = 0
    private var thingsArray:[Int] = []
    init(maxWeight:Int,things:[Int]) {
        self.maxWeight = maxWeight
        self.thingsArray = things
    }
    
    private func carry(currentWeight:Int, thingIndex:Int, carryThings:inout [Int]) {
        if currentWeight == maxWeight {
            print("满足条件\(carryThings)")
            return
        }else if currentWeight < maxWeight{
            let weight = currentWeight + thingsArray[thingIndex]
            
            var notCarryed = carryThings
            
            carryThings.append(thingsArray[thingIndex])
            var carryed = carryThings
            
            let newIndex = thingIndex + 1
            if newIndex < thingsArray.count {
                carry(currentWeight: weight, thingIndex: newIndex, carryThings: &carryed)
                carry(currentWeight: currentWeight, thingIndex: newIndex, carryThings: &notCarryed)
            }else{
                if weight == maxWeight {
                    print("满足条件\(carryThings)")
                }else if weight <= maxWeight {
                    print("接近条件\(carryThings)")
                }
            }
        }else{
            carryThings.removeLast()
            print("接近条件\(carryThings)")
            return
        }
    }
}

extension OneZeroBag {
    public func find() {
        var array:[Int] = []
        carry(currentWeight: 0, thingIndex: 0, carryThings: &array)
    }
}
