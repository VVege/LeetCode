//
//  LRUCache.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/9.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class LRUCacheNode:NSObject {
    var key = ""
    var value:Int?
    
    //双链表
    var next:LRUCacheNode?
    var last:LRUCacheNode?
    
    //散列表
    var hnext:LRUCacheNode?
}

///双向链表 + 散列表构成的LRUCache
///散列表作用：使查找的时间复杂度为o(1)
///双向链表: 使排序的时间复杂度为o(1)
class LRUCache {
    private var array:[LRUCacheNode] = []
    private var maxCount:Int = 0
    private var currentCount:Int = 0
    private var linkedHead:LRUCacheNode?
    private var linkedTail:LRUCacheNode?
    
    init(capacity:Int) {
        maxCount = capacity
        for _ in 0 ..< capacity  {
            let node = LRUCacheNode()
            array.append(node)
        }
    }
    
    private func hash(key:String) -> Int {
        return key.count % maxCount
    }
    
    private func nodeFromHashTable(key:String) -> LRUCacheNode? {
        var node = array[hash(key: key)]
        if node.key == key {
            return node
        }
        
        while let hnext = node.hnext {
            if hnext.key == key {
                return hnext
            }
            node = hnext
        }
        return nil
    }
    
    typealias LRUGenerateInfo = (node:LRUCacheNode, isNew:Bool)
    private func generateNode(key:String, value:Int) -> LRUGenerateInfo{
        var node = array[hash(key: key)]
        
        if node.value == nil {
            node.key = key
            node.value = value
            return LRUGenerateInfo(node:node,isNew:true)
        }
        
        if key == node.key {
            node.value = value
            return LRUGenerateInfo(node:node,isNew:false)
        }
        
        while let hnext = node.hnext {
            if hnext.key == key {
                hnext.value = value
                return LRUGenerateInfo(node:hnext,isNew:false)
            }
            node = hnext
        }
        
        let newNext = LRUCacheNode()
        newNext.key = key
        newNext.value = value
        node.hnext = newNext
        return LRUGenerateInfo(node:newNext,isNew:true)
    }
    
    private func linkListPutNodeLast(node: LRUCacheNode){
        if let head = linkedHead, node == head {
            linkedHead = node.next
        }
        
        let last = node.last
        let next = node.next
        last?.next = next
        next?.last = last
        
        node.last = linkedTail
        node.next = nil
        
        linkedTail?.next = node

        linkedTail = node
    }
    
    private func removeNodeAtLinkListFirst() {
        let first = linkedHead
        linkedHead = linkedHead?.next
        
        if let key = first?.key {
            currentCount -= 1
            removeNodeFromHashTable(key: key)
        }
    }
    
    @discardableResult
    private func removeNodeFromHashTable(key:String) -> LRUCacheNode?{
        var node:LRUCacheNode? = array[hash(key: key)]
        
        if node?.key == key {
            node?.key = ""
            node?.value = nil
            return node
        }
        
        while let next = node?.hnext {
            if next.key == key {
                let nnext = next.hnext
                node?.hnext = nnext
                return next
            }
            node = next
        }
        return nil
    }
}

//MARK:Public
extension LRUCache {
    public func setCache(value:Int,for key:String) {
        //判断是否已满
        //满则删除头部
        //存入散列表
        //将节点移至双链表尾部
        if currentCount == maxCount {
            removeNodeAtLinkListFirst()
        }
        
        let info = generateNode(key: key, value: value)
        
        let node = info.node
        let isNewCreate = info.isNew
        
        if isNewCreate {
            if currentCount == 0 {
                linkedHead = node
                linkedTail = node
            }else if currentCount == 1{
                linkedTail = node
                linkedHead?.next = node
                linkedTail?.last = linkedHead
            }else{
                linkListPutNodeLast(node: node)
            }
            currentCount += 1
        }else{
            linkListPutNodeLast(node: node)
        }
    }
    
    public func getCache(from key:String) -> Int? {
        //获取散列表中缓存
        //如果有则将节点移至双链表尾部
        if let node = nodeFromHashTable(key: key) {
            linkListPutNodeLast(node: node)
            return node.value
        }
        return nil
    }
    
    public func printAllValue() {
        var currentNode = linkedHead
        while currentNode != nil {
            print("\(String(describing: currentNode!.value))")
            currentNode = currentNode?.next
        }
    }
}
