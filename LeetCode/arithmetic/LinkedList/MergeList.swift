//
//  MergeList.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/7/14.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class MergeList {
    class public func merge(listArray:[Node]){
        var array = listArray
        var head:Node?
        var end:Node?
        while array.count > 0 {
            let node = deleteMinNode(from: &array)
            if head == nil{
                head = node
            }
            else if end == nil{
                head?.next = node
                end = node
            }else{
                end?.next = node
                end = node
            }
        }
        
        if let printHead = head {
            printList(head: printHead)
        }
    }
    
    class private func deleteMinNode(from array:inout [Node]) -> Node{
        
        var minNode = array[0]
        var minIndex = 0
        
        for (index,head) in array.enumerated() {
            if minNode.value > head.value {
                minNode = head
                minIndex = index
            }
        }
        
        array.remove(at:minIndex)
        if let next = minNode.next {
            array.append(next)
        }
        return minNode
    }
    
    class private func printList(head:Node){
        var currentNode:Node? = head
        while let node = currentNode {
            print("\n\(node.value)")
            currentNode = node.next
        }
    }
}
