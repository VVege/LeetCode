//
//  HashTable.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/9.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class HashNode {
    var next:HashNode?
    var value:Int?
    var key:String = ""
}

class HashTable {
    private var array:[HashNode] = []
    init() {
        for _ in 0 ... 9 {
            let hashNode = HashNode()
            array.append(hashNode)
        }
    }
    
    private func hash(key:String) -> Int {
        return key.count % 10
    }
}

//MARK:Public
extension HashTable {
    public func set(value:Int,key:String){
        var node:HashNode? = array[hash(key: key)]
        
        if node?.value == nil {
            node?.key = key
            node?.value = value
            return
        }
        
        if node?.key == key {
            node?.value = value
            return
        }
        
        while let next = node?.next {
            if next.key == key {
                next.value = value
            }else{
                node = next
            }
        }
        
        let newNext = HashNode()
        newNext.key = key
        newNext.value = value
        node?.next = newNext
    }
    
    public func remove(from key:String) {
        var node:HashNode? = array[hash(key: key)]
        if node?.key == key {
            node?.key = ""
            node?.value = nil
            return
        }
        
        while let next = node?.next {
            if next.key == key {
                let nnext = next.next
                node?.next = nnext
                return
            }
            node = next
        }
    }
    
    public func value(for key:String) -> Int? {
        var node:HashNode? = array[hash(key: key)]
        while node != nil {
            if node?.key == key {
                return node?.value
            }
            node = node?.next
        }
        return nil
    }
}
