//
//  DynamicCoin.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/22.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//硬币找零问题，我们在贪心算法那一节中讲过一次。我们今天来看一次。我们今天来看一个新的硬币找零问题。假设我们有几种不同币值v1，v2，……，vn（单位是元）。如果我们要支付 w 元，求最少需要多少个硬币。比如，我们有 3 种不同的硬币，1 元、3 元、5 元，我们要支付 9 元，最少需要 3 个硬币（3 个 3 元的硬币）。

///动态规划求 最少硬币数量
class DynamicCoin {
    var status:[[Bool]] = []
    
    private var coinTypes:[Int]!
    private var needPay:Int!
    
    init(coinTypes:[Int],needPay:Int) {
        self.coinTypes = coinTypes
        self.needPay = needPay
    }
}

///状态转移表法
extension DynamicCoin {
    public func countFromStatusTable() {
        
        //初始化第一行状态
        var initPrices:[Bool] = Array.init(repeating: false, count: needPay + 1)
        for i in 0 ..< coinTypes.count {
            initPrices[coinTypes[i]] = true
        }
        status.append(initPrices)
    
        //从第二行开始不断累加
        for j in 1 ..< Int.max {
            var prices:[Bool] = Array.init(repeating: false, count: needPay + 1)
            let lastPrices = status[j - 1]
            
            for k in 0 ..< coinTypes.count {
                for index in 1 ..< lastPrices.count {
                    let addPrice = coinTypes[k]
                    if lastPrices[index] && index + addPrice <= needPay {
                        prices[index + addPrice] = true
                    }
                }
            }
            status.append(prices)
            if prices[needPay] == true {
                print("至少需要\(status.count)个硬币")
                break
            }
        }
    }
}

///状态转移方程法
///f(9) = min(f(8),f(6),f(4)) + 1

extension DynamicCoin {
    public func countFromEquation() {
        print("至少需要\(minCount(value: needPay))个硬币")
    }
    
    private func minCount(value:Int) -> Int {
        var min = Int.max
        for index in 0 ..< coinTypes.count {
            let coin = coinTypes[index]
            if value == coin {
                return 1
            }else if value > coin {
                let count = minCount(value: value - coin) + 1
                if count < min {
                    min = count
                }
            }
        }
        return min
    }
}
