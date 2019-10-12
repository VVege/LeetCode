//
//  TurnTree.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/16.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit
//翻转一棵二叉树。
//https://leetcode-cn.com/problems/invert-binary-tree/

class BinaryTreeNode:NSObject {
    var left:BinaryTreeNode?
    var right:BinaryTreeNode?
    var value = 0
}

class TurnTree {
    public private(set) var root:BinaryTreeNode!
    
    init(with array:[Int]) {
        
        //根据数组建立一个完全二叉树
        var nodeArray:[BinaryTreeNode] = []
        for i in 0 ..< array.count {
            let newNode = BinaryTreeNode()
            newNode.value = array[i]
            nodeArray.append(newNode)
        }
        
        root = nodeArray[0]
        var index = 0
        while index < nodeArray.count/2 {
            let leftIndex = 2 * index + 1
            nodeArray[index].left = nodeArray[leftIndex]
            
            let rightIndex = 2 * index + 2
            if rightIndex <= nodeArray.count - 1{
                nodeArray[index].right = nodeArray[rightIndex]
            }
            index += 1
        }
    }
    
    private func frontPrint(node:BinaryTreeNode){
        print(node.value)
        if let left = node.left {
            frontPrint(node: left)
        }
        
        if let right = node.right {
            frontPrint(node: right)
        }
    }
    
    private func turn(node:BinaryTreeNode) {
        let left = node.left
        node.left = node.right
        node.right = left
        
        if let nLeft = node.left {
            turn(node: nLeft)
        }
        
        if let nRight = node.right {
            turn(node: nRight)
        }
    }
}

extension TurnTree {
    public func fPrint() {
        frontPrint(node: root)
    }
    
    public func turn(){
        turn(node: root)
    }
}
