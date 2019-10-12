//
//  island.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/19.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//给定一个由 '1'（陆地）和 '0'（水）组成的的二维网格，计算岛屿的数量。一个岛被水包围，并且它是通过水平方向或垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/number-of-islands

struct IslandLocation:Hashable {
    var x = 0
    var y = 0
    
    static func == (lhs: IslandLocation, rhs: IslandLocation) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    public func left() -> IslandLocation {
        var new = self
        new.x -= 1
        return new
    }
    
    public func right() -> IslandLocation {
        var new = self
        new.x += 1
        return new
    }
    
    public func top() -> IslandLocation {
        var new = self
        new.y -= 1
        return new
    }
    
    public func bottom() -> IslandLocation {
        var new = self
        new.y += 1
        return new
    }
}

class Island {
    private var array:[[Int]]!
    private var markedDic:[IslandLocation:Bool] = [:]
    
    init(array:[[Int]]) {
        self.array = array
    }
    
    private func dfs(location:IslandLocation) {
        if markedDic[location] != nil {
            return
        }
        
        markedDic[location] = true
        
        let left = location.left()
        let right = location.right()
        let top = location.top()
        let bottom = location.bottom()
        
        if left.x > 0, arrayValue(location: left) == 1{
            dfs(location: left)
        }
        
        if right.x < array.count, arrayValue(location: right) == 1 {
            dfs(location: right)
        }
        
        if top.y > 0, arrayValue(location: top) == 1{
            dfs(location: top)
        }
        
        if bottom.y < array[bottom.x].count, arrayValue(location: bottom) == 1{
            dfs(location: bottom)
        }
    }
    
    private func bfs(location:IslandLocation) {
        var queue:[IslandLocation] = []
        queue.append(location)
        
        while queue.count > 0 {
            let location = queue.removeFirst()
            
            if markedDic[location] == true {
                continue
            }
            
            markedDic[location] = true
            
            let left = location.left()
            let right = location.right()
            let top = location.top()
            let bottom = location.bottom()
            
            if left.x > 0, arrayValue(location: left) == 1{
                queue.append(left)
            }
            
            if right.x < array.count, arrayValue(location: right) == 1 {
                queue.append(right)
            }
            
            if top.y > 0, arrayValue(location: top) == 1{
                queue.append(top)
            }
            
            if bottom.y < array[bottom.x].count, arrayValue(location: bottom) == 1{
                queue.append(bottom)
            }
        }
    }
    
    private func arrayValue(location:IslandLocation) -> Int {
        return array[location.x][location.y]
    }
}

//MARK:Public
//利用深度或广度来填充 markedDic
//深度：一条线的递归
//广度：一层层的加入队列，然后处理队列
extension Island {
    
    public func dfsCheck() {
        var islandCount = 0
        markedDic.removeAll()
        for row in 0 ..< array.count {
            for column in 0 ..< array[row].count {
                var location = IslandLocation()
                location.x = row
                location.y = column
                let noMark = markedDic[location] == nil
                if noMark, array[location.x][location.y] == 1 {
                    islandCount += 1
                    dfs(location: location)
                }
            }
        }
        print("岛屿的数量为\(islandCount)")
    }
    
    public func bfsCheck() {
        markedDic.removeAll()
        var islandCount = 0
        for row in 0 ..< array.count {
            for column in 0 ..< array[row].count {
                var location = IslandLocation()
                location.x = row
                location.y = column
                let noMark = markedDic[location] == nil
                if noMark, array[location.x][location.y] == 1 {
                    islandCount += 1
                    bfs(location: location)
                }
            }
        }
        print("岛屿的数量为\(islandCount)")
    }
}
