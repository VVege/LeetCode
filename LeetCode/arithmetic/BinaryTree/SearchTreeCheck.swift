//
//  SearchTreeCheck.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/16.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class SearchTreeCheck: NSObject {
    
    public class func isSearchTree(root:BinaryTreeNode) -> Bool{
        return check(node: root)
    }
    
    private class func check(node:BinaryTreeNode) -> Bool {
        let leftValue = node.left?.value ?? Int.min
        let rightValue = node.right?.value ?? Int.max
        let pass = node.value > leftValue && node.value < rightValue
        if pass {
            if let left = node.left {
                return check(node: left)
            }
            
            if let right = node.right {
                return check(node: right)
            }
            
            return true
        }
        
        return false
    }
}
