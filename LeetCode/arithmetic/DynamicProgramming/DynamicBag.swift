//
//  DynamicBag.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/22.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///动态规划实现 0-1背包问题
class DynamicBag {
    ///状态表
    ///也可以用一位数组表示状态表
    private var status:[[Bool]] = []
    private var things:[Int]!
    private var maxWeight:Int!
    init(things:[Int], maxWeight:Int) {
        self.things = things
        self.maxWeight = maxWeight
        for _ in 0 ..< things.count {
            var bools:[Bool] = []
            for _ in 0 ... maxWeight {
                bools.append(false)
            }
            status.append(bools)
        }
    }
    
    private func printStatus() {
        var titleString = "元素\\重量"
        for i in 0 ... maxWeight {
            let string = String.init(format: "%2ld ", i)
            titleString += string
        }
        print(titleString)
        
        for i in 0 ..< status.count {
            var string = "\(things[i])      "
            for j in 0 ..< status[i].count{
                string += status[i][j] ? " **" : " --"
            }
            print(string)
        }
    }
}

//MARK:Public
extension DynamicBag {
    public func generateStatus() {
        
        var firstCanCarryThingIndex:Int?
        for i in 0 ..< things.count {
            if things[i] < maxWeight {
                firstCanCarryThingIndex = i
                break
            }
        }
        
        guard let firstIndex = firstCanCarryThingIndex else {
            print("啥也装不了")
            return
        }
        
        //先装好第一排
        status[0][0] = true
        if firstIndex == 0 {
            status[0][things[firstIndex]] = true
        }
        
        for i in 1 ..< things.count {
            
            let newThing = things[i]

            for j in 0 ... maxWeight {
                if status[i - 1][j] == true {
                    status[i][j] = true
                    if j + newThing <= maxWeight {
                        status[i][j + newThing] = true
                    }
                }
            }
        }
        printStatus()
    }
}
