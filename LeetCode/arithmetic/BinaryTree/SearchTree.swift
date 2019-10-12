//
//  SearchTree.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/14.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

enum BinaryTreeTraverseType {
    case front
    case center
    case behind
    case level
}

///二叉查找树
class SearchTree {
    public private(set) var root:BinaryTreeNode!
    private var rootEmpty:Bool = true
    private var levelArray:[[Int]] = []
    
    init() {
        root = BinaryTreeNode()
    }
    
    //MARK:Traverse
    private func frontTraverse(node:BinaryTreeNode){
        print(node.value)
        if let left = node.left {
            frontTraverse(node: left)
        }
        if let right = node.right {
            frontTraverse(node: right)
        }
    }
    
    private func centerTraverse(node:BinaryTreeNode){
        if let left = node.left {
            centerTraverse(node: left)
        }
        print(node.value)
        if let right = node.right {
            centerTraverse(node: right)
        }
    }
    
    private func behindTraverse(node:BinaryTreeNode){
        if let left = node.left {
            behindTraverse(node: left)
        }
        if let right = node.right {
            behindTraverse(node: right)
        }
        print(node.value)
    }
    
    ///*二叉树的按层级遍历
    ///解法巧妙，便利顺序虽然还是根->左->右
    ///但通过二维数组，以及level参数，使相同深度的元素插入到同一数组中。
    private func levelTraverse(node:BinaryTreeNode, level:Int){
        if level == levelArray.count {
            let newLevel:[Int] = []
            levelArray.append(newLevel)
        }
        
        levelArray[level].append(node.value)
        
        if let left = node.left {
            levelTraverse(node: left, level: level + 1)
        }
        if let right = node.right {
            levelTraverse(node: right, level: level + 1)
        }
    }
    
    
    private func heightForTree(node:BinaryTreeNode) -> Int{
        
        var leftHeight = 0
        var rightHeight = 0
        if let left = node.left {
            leftHeight = heightForTree(node: left)
        }
        if let right = node.right {
            rightHeight = heightForTree(node: right)
        }
        return max(leftHeight, rightHeight) + 1
    }
}

extension SearchTree {
    public func append(value: Int) {
        if rootEmpty {
            root.value = value
            rootEmpty = false
            return
        }
        
        let newNode = BinaryTreeNode()
        newNode.value = value
        
        var currentNode = root
        while true {
            guard let node = currentNode else {
                break
            }
            if node.value > newNode.value {
                if let left = node.left{
                    currentNode = left
                }else {
                    node.left = newNode
                    break
                }
            }else{
                if let right = node.right{
                    currentNode = right
                }else{
                    node.right = newNode
                    break
                }
            }
        }
    }
    
    public func delete(value:Int) {
        var currentNode = root
        var lastNode:BinaryTreeNode?
        var currentIsLeft:Bool = false
        while true {
            guard let node = currentNode else {
                break
            }
            if node.value > value {
                if let left = node.left{
                    currentIsLeft = true
                    lastNode = currentNode
                    currentNode = left
                }else {
                    print("Error未找到值为\(value)的元素")
                    return
                }
            }else if node.value < value{
                if let right = node.right{
                    currentIsLeft = false
                    lastNode = currentNode
                    currentNode = right
                }else{
                    print("Error未找到值为\(value)的元素")
                    return
                }
            }else{
                //已找到
                //判断删除移动的三种情况
                //1.无右，则直接用左节点
                //2.有右子树，但右子树中无左子树，则直接用右节点
                //3.*有右子树，且右子树中有左子树，则选择这条左子树的最左节点，将其替换到删除点的位置
                if currentNode?.right == nil {
                    if currentNode == root{
                        root = currentNode?.left
                    }else if currentIsLeft {
                        lastNode?.left = currentNode?.left
                    }else{
                        lastNode?.right = currentNode?.left
                    }
                }else if currentNode?.right?.left == nil {
                    if currentNode == root{
                        root = currentNode?.right
                        root.left = currentNode?.left
                    }else if currentIsLeft {
                        lastNode?.left = currentNode?.right
                    }else{
                        lastNode?.right = currentNode?.right
                    }
                }else {
                    var rightFinalLeft = currentNode?.right
                    var rightFinalLeftLast = currentNode
                    while let left = rightFinalLeft?.left {
                        rightFinalLeftLast = rightFinalLeft
                        rightFinalLeft = left
                    }
                    
                    rightFinalLeftLast?.left = nil
                    rightFinalLeft?.left = currentNode?.left
                    rightFinalLeft?.right = currentNode?.right
                    if currentNode == root{
                        root = rightFinalLeft
                    }else if currentIsLeft {
                        lastNode?.left = rightFinalLeft
                    }else{
                        lastNode?.right = rightFinalLeft
                    }
                }
                return
            }
        }
    }
    
    public func traverse(type:BinaryTreeTraverseType){
        switch type {
        case .front:
            frontTraverse(node: root)
        case .center:
            centerTraverse(node: root)
        case .behind:
            behindTraverse(node: root)
        case .level:
            levelArray = []
            levelTraverse(node: root, level: 0)
            print(levelArray)
        }
    }
    
    public func height() -> Int {
        return heightForTree(node: root)
    }
}
