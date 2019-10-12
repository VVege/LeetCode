//
//  LongestSameSubString.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/8/25.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///动态规划求解两个字符串的最长公共子串
///例子：mitcmu 和 mtacnu 为 mtcu

class LongestSameSubString {
    private var array1:[Character]!
    private var array2:[Character]!
    private var status:[[Int]]!
    
    init(string1:[Character], string2:[Character]) {
        array1 = string1
        array2 = string2
        let item = Array.init(repeating: 0, count: array1.count)
        status = Array.init(repeating: item, count: array2.count)
    }
}

//MARK:Public
extension LongestSameSubString {
    public func length() {
        //填充初始值
        if array1[0] == array2[0] {
            status[0][0] = 1
        }
        
        //横向第一行
        for i in 1 ..< array1.count {
            if status[i - 1][0] == 1{
                status[i][0] = 1
            }else if array1[i] == array2[0]{
                status[i][0] = 1
            }
        }
        
        //纵向第一行
        for i in 1 ..< array2.count {
            if status[0][i - 1] == 1 {
                status[0][i] = 1
            }else if array2[i] == array1[0]{
                status[0][i] = 1
            }
        }
        
        //填充状态表
        for i in 1 ..< array1.count {
            for j in 1 ..< array2.count {
                if array1[i] == array2[j] {
                    let top = status[i - 1][j] + 1
                    let left = status[i][j - 1] + 1
                    let topLeft = status[i - 1][j - 1] + 1
                    var maxValue = max(top, left)
                    maxValue = max(maxValue, topLeft)
                    status[i][j] = maxValue
                }else{
                    let top = status[i - 1][j]
                    let left = status[i][j - 1]
                    let topLeft = status[i - 1][j - 1]
                    var maxValue = max(top, left)
                    maxValue = max(maxValue, topLeft)
                    status[i][j] = maxValue
                }
            }
        }
        
        print("最大子串长度是\(status.last?.last ?? -1)")
    }
}
