//
//  LevenshteinDistance.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/8/25.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///计算字符串的莱文斯坦距离
///一个字符串通过操作（删除，添加，替换）字符，到达另一个字符，操作次数即为莱文斯坦距离

///状态转移方程才是动态规划的核心
///状态转移表只是方程的体现，复杂情况要先理清状态转移方程，也就是当前状态，是从前面哪几个状态而来。
///正确顺序是先理清方程，再画表，代码也就一目了然，如果先画表，方程复杂的情况下很难将推倒出来。
///画递归树可以辅助写出状态转移方程
class LevenshteinDistance {
    private var fromArray:[Character]!
    private var toArray:[Character]!
    
    private var status:[[Int]]!
    
    init(string1:[Character], string2:[Character]) {
        fromArray = string1
        toArray = string2
        let statusItem = Array.init(repeating: 0, count: toArray.count)
        status = Array.init(repeating: statusItem, count: fromArray.count)
    }
}

extension LevenshteinDistance {
    public func distance() {
        //设置纵向第一排初始值
        if toArray[0] != fromArray[0]{
            status[0][0] = 1
        }
        
        let vBase = toArray[0]
        for i in 1 ..< fromArray.count {
            if fromArray[i] == vBase {
                if status[i - 1][0] == i - 1{
                    status[i][0] = status[i - 1][0] + 1
                }else{
                    status[i][0] = status[i - 1][0]
                }
            }else{
                status[i][0] = status[i - 1][0] + 1
            }
        }
        
        //设置横向第一排初始值
        let hBase = fromArray[0]
        for i in 1 ..< toArray.count {
            if toArray[i] == hBase {
                if status[0][i - 1] == i - 1{
                    status[0][i] = status[0][i - 1] + 1
                }else{
                    status[0][i] = status[0][i - 1]
                }
            }else{
                status[0][i] = status[0][i - 1] + 1
            }
        }
        
        //填充状态表
        for i in 1 ..< status.count {
            for j in 1 ..< status[i].count {
                let fromChar = fromArray[i]
                let toChar = toArray[j]
                if fromChar == toChar {
                    let fromLeftDistance = status[i][j - 1] + 1
                    let fromTopDistance = status[i - 1][j] + 1
                    let fromTopLeftDistance = status[i - 1][j - 1]
                    var minValue = min(fromTopDistance, fromLeftDistance)
                    minValue = min(minValue, fromTopLeftDistance)
                    status[i][j] = minValue
                }else {
                    let fromLeftDistance = status[i][j - 1] + 1
                    let fromTopDistance = status[i - 1][j] + 1
                    let fromTopLeftDistance = status[i - 1][j - 1] + 1
                    var minValue = min(fromTopDistance, fromLeftDistance)
                    minValue = min(minValue, fromTopLeftDistance)
                    status[i][j] = minValue
                }
            }
        }
        print("莱文斯坦距离为:\(status.last?.last ?? -1)")
    }
}
