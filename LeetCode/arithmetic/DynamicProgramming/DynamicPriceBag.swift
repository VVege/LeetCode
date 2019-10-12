//
//  DynamicPriceBag.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/22.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit
///动态规划 0-1背包升级版
///限制最大重量的情况下，找出物品组合最大价值

class PriceGood {
    var weight:Int = 0
    var price:Int = 0
}

class DynamicPriceBag: NSObject {
    ///状态表 存价格
    private var status:[[Int]] = []
    private var maxWeight:Int!
    private var things:[PriceGood]!
    
    init(maxWeight:Int, things:[PriceGood]) {
        self.maxWeight = maxWeight
        self.things = things
        
        for _ in 0 ..< things.count {
            var prices:[Int] = []
            for _ in 0 ... maxWeight {
                prices.append(0)
            }
            status.append(prices)
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
            var string = "\(things[i].weight)      "
            for j in 0 ..< status[i].count{
                let price = status[i][j]
                string += String.init(format: "%2ld ", price)
            }
            print(string)
        }
    }
}

extension DynamicPriceBag {
    public func generateStatus() {
        
        var firstCanCarryThingIndex:Int?
        for i in 0 ..< things.count {
            if things[i].weight < maxWeight {
                firstCanCarryThingIndex = i
                break
            }
        }

        guard let firstIndex = firstCanCarryThingIndex else {
            print("啥也装不了")
            return
        }

        //填充第一排
        status[0][0] = 0
        if firstIndex == 0 {
            let first = things[0]
            status[0][first.weight] = first.price
        }
    
        for i in 1 ..< things.count {
            let newThing = things[i]
            for j in 0 ... maxWeight {
                if status[i - 1][j] > 0 {
                    status[i][j] = status[i - 1][j]
                    if j + newThing.weight <= maxWeight {
                        status[i][j + newThing.weight] = status[i][j] + newThing.price
                    }
                }
            }
        }
        printStatus()
    }
}
