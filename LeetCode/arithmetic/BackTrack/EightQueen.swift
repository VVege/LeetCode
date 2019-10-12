//
//  EightQueen.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/20.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

///回溯思想
///暴力遍历
///类似于深度优先遍历的思想
///只不过深度优先用在有关联的部分元素中，例如图.
///回溯的使用场景一般点与点之间的关联性较小，缺乏规律性的场景。

///8皇后问题的回溯解法
class EightQueen {
    
    ///下标表示行
    ///内容表示列
    private var paths:[Int] = []
    private var count = 0
    
    init() {
        for _ in 0 ..< 8 {
            paths.append(-1)
        }
    }
    
    private func check(row:Int){
        
        if row == 8 {
            printCurrentPath()
            return
        }
        
        for column in 0 ..< 8{
            if valid(row: row, column: column) {
                paths[row] = column
                check(row: row + 1)
            }
        }
    }
    
    private func valid(row:Int,column:Int) -> Bool{
        for passedRow in 0 ..< row{
            let passedColumn = paths[passedRow]
            
            if passedColumn < 0 {
                continue
            }
            
            if row == passedRow {
                return false
            }
            
            if column == passedColumn {
                return false
            }
            
            if row - passedRow == abs(column - passedColumn){
                return false
            }
        }
        return true
    }
    
    private func printCurrentPath() {
        count += 1
        print("\n")
        print("第\(count)种")
        for i in 0 ..< 8 {
           var string = ""
            for j in 0 ..< 8 {
                if paths[i] == j {
                   string = string+"Q"
                }else{
                   string = string+"*"
                }
            }
            print(string)
        }
    }
}

extension EightQueen {
    public func printAllPath(){
        check(row: 0)
    }
}
