//
//  Trie.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/12.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class TrieNode {
    var char:Character!
    var dic:[Character:TrieNode] = [:]
}

class Trie {
    
    private let root:TrieNode!
    init() {
        root = TrieNode()
    }
    
    private func printFromNode(node:TrieNode){
        print(node.char)
        if node.dic.count == 0 {
            return
        }
        for key in node.dic.keys {
            if let nextNode = node.dic[key] {
                printFromNode(node: nextNode)
            }
        }
    }
}

//MARK: Public
extension Trie {
    public func append(string:[Character]){
        var index = 0
        var node = root
        while index < string.count {
            let char = string[index]
            if let myNode = node?.dic[char] {
                node = myNode
            }else{
                let newNode = TrieNode()
                newNode.char = char
                node?.dic[char] = newNode
                node = newNode
            }
            index += 1
        }
    }
    
    public func multiModeMatch(string:[Character]){
        var lastNode = root
        var index = 0
        while index < string.count {
            let char = string[index]
            if let matchNode = lastNode?.dic[char]{
                lastNode = matchNode
                index += 1
            }else{
                print("未找到匹配字符串")
                return
            }
        }
        
        
        if let currentNode = lastNode{
            printFromNode(node: currentNode)
        }
    }
}
