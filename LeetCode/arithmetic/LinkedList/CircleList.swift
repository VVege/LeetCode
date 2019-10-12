//
//  CircleList.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/7/13.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit
//给定一个链表，判断链表中是否有环。
//https://leetcode-cn.com/problems/linked-list-cycle/

class Node {
    var value:Int = 0
    var next:Node?
    var id:String = UUID().uuidString
}

class CircleList: NSObject {
    /// hashtable
    class public func haveCircle(head: Node){
        var dic = Dictionary<String, Int>()
        
        var currentNode = head
        while true {
            if let _ = dic[currentNode.id]{
                print("有环\(currentNode.value)")
                return
            }
            
            dic[currentNode.id] = currentNode.value
            if let next = currentNode.next {
                currentNode = next
            }else{
                print("没环")
                return
            }
        }
    }
    
    ///o(1)
    ///双指针法
    ///差速寻址
    class public func haveCircleO1(head: Node){
        var quick = head
        var slow = head
        var secondSlow = head
        var findCircle = false
        while true {
            if let next = slow.next {
                slow = next
            }else{
                print("没环")
                break
            }
            
            if let nextNext = quick.next?.next {
                quick = nextNext
            }else{
                print("没环")
                break
            }
            
            if quick.id == slow.id {
                findCircle = true
                break
            }
        }
        
        if findCircle {
            while true {
                if  let next = slow.next, let secondNext = secondSlow.next {
                    slow = next
                    secondSlow = secondNext
                    if slow.id == secondSlow.id {
                        print("环点在值为\(slow.value)的点")
                        break
                    }
                }
            }
        }
    }
}
