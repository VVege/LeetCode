//
//  Graph.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/16.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class GraphNode: NSObject {
    var value:Int = 0
    var links:[GraphNode] = []
    public func link(with node:GraphNode){
        for linkedNode in links {
            if linkedNode == node {
                return
            }
        }
        links.append(node)
        
        //无向图的双向绑定
        node.link(with: self)
    }
}

/// 无向图
class Graph {
    private var vertex:[GraphNode]!
    var dfsFindTag = false
    
    init(vertex:[GraphNode]) {
        self.vertex = vertex
    }
    
    private func printPath(paths:[GraphNode:GraphNode], end:GraphNode) {
        var currentNode:GraphNode? = end
        var pathArray:[GraphNode] = []
        while let node = currentNode{
            pathArray.append(node)
            currentNode = paths[node]
        }
        
        for node in pathArray.reversed() {
            print(node.value)
        }
    }
    
    private func recursDfs(fromNode:GraphNode,toNode:GraphNode,visitedNodes:inout [GraphNode], pathNodes:inout [GraphNode:GraphNode]) {
        if dfsFindTag {
            return
        }
        
        for node in fromNode.links {
            if visitedNodes.contains(node) {
                continue
            }
            visitedNodes.append(node)
            pathNodes[node] = fromNode
            if node.value == toNode.value {
                dfsFindTag = true
                return
            }
            recursDfs(fromNode: node, toNode: toNode, visitedNodes: &visitedNodes, pathNodes: &pathNodes)
        }
    }
}

//MARK:Public
///广度优先搜索：按照层级遍历（很像二叉树的按层遍历），借助队列存储，使用循环出队列比较方便
///深度优先搜索：从第一层第一个点，遍历到最后一层第一个点，再从第一层第二个点遍历到最后一层第二个点，依次类推。类似于二叉树的正常遍历，使用递归方便
extension Graph {
    
    /// 广度优先搜索
    public func bfs(fromNode:GraphNode, toNode:GraphNode){
        if fromNode == toNode {
            return
        }
        
        ///记录访问过自身值的元素
        var visitedNodes:[GraphNode] = []
        ///存储刚刚访问过当前值，还没有访问过子元素的元素
        var queue:[GraphNode] = []
        ///记录访问路径
        var pathsNodes:[GraphNode:GraphNode] = [:]
        
        queue.append(fromNode)
        visitedNodes.append(fromNode)
        
        while queue.count > 0 {
            let node = queue.removeLast()
            for linkNode in node.links {
                if visitedNodes.contains(linkNode) {
                    continue
                }
                
                ///key为当前值
                ///value为上层节点
                ///倒序即可从终点走到起点
                pathsNodes[linkNode] = node
                if linkNode.value == toNode.value {
                    printPath(paths: pathsNodes, end: linkNode)
                    return
                }
                visitedNodes.append(linkNode)
                queue.append(linkNode)
            }
        }
        
    }
    
    /// 深度优先搜索
    public func dfs(fromNode:GraphNode, toNode:GraphNode){
        ///记录访问过自身值的元素
        var visitedNodes:[GraphNode] = [fromNode]
        ///记录访问路径
        var pathsNodes:[GraphNode:GraphNode] = [:]
        
        recursDfs(fromNode: fromNode, toNode: toNode, visitedNodes: &visitedNodes, pathNodes: &pathsNodes)
        printPath(paths: pathsNodes, end: toNode)
    }
}
