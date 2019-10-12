//
//  PathValuePlus.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/16.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。
//https://leetcode-cn.com/problems/path-sum/

class PathValuePlus {
    private var equalTag = false
    
    public func valueInPath(root:BinaryTreeNode,plusValue:Int) -> Bool{
        equalTag = false
        totalValue(node: root, value: 0, destination: plusValue)
        return equalTag
    }
    
    private func totalValue(node:BinaryTreeNode, value:Int, destination:Int){
        let newValue = value + node.value
        
        if let left = node.left {
            totalValue(node: left, value: newValue, destination: destination)
        }
        
        if let right = node.right {
            totalValue(node: right, value: newValue, destination: destination)
        }
        
        if node.left == nil, node.right == nil {
            if destination == newValue {
                equalTag = true
                return
            }
        }
    }
}
