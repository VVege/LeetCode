//
//  MinPath.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/26.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//https://leetcode-cn.com/problems/minimum-path-sum/
//给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
//
//说明：每次只能向下或者向右移动一步。
class MinPath {
    private var status:[[Int]]!
    private var array:[[Int]]!
    init(array:[[Int]]) {
        let item = Array.init(repeating: 0, count: array[0].count)
        status = Array.init(repeating: item, count: array.count)
        self.array = array
        status[0][0] = array[0][0]
        for i in 1 ..< array[0].count {
            status[0][i] = status[0][i - 1] + array[0][i]
        }
        
        for i in 1 ..< array.count {
            status[i][0] = status[i - 1][0] + array[i][0]
        }
    }
}

extension MinPath {
    public func minLength() {
        for i in 1 ..< array[0].count {
            for j in 1 ..< array.count {
                let top = status[i - 1][j]
                let left = status[i][j - 1]
                status[i][j] = min(top, left) + array[i][j]
            }
        }
        print("最短距离为\(status.last?.last ?? -1)")
    }
}
