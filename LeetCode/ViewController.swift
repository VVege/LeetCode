//
//  ViewController.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/5/18.
//  Copyright © 2019年 vege. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        threeSum()
//        majorityElement()
//        firstMissing()
//        findMedian()
//        findCirclePoint()
//        mergeList()
//        vaildBracket()
//        vaildLongestBracket()
//        rpn()
//        circleQueue()
//        slideWindow()
//        clumbStairs()
//        bubble()
//        insert()
//        selected()
//        merge()
//        quick()
//        search()
//        firstBigSearch()
//        rescursionSearch()
//        sqrt()
//        hashTable()
//        lruCache()
//        bmSearch()
//        kmpSearch()
//        trie()
//        reverseString()
//        reverseStringWord()
//        atoi()
//        searchTree()
//        turnTree()
//        isSearchTree()
//        pathPlus()
//        heap()
//        heapSort()
//        graphBfs()
//        island()
//        eightQueenBackTrack()
//        oneZeroBag()
//        reverseNum()
//        dynamicBag()
//        dynamicPriceBag()
//          subLongest()
//        levenshteinDistance()
//        longestSameLength()
//        regularMatch()
//        minPathLength()
        mutiplySubMax()
    }
}

extension ViewController {
    func threeSum() {
        let array:[Int] = [2,-1, 0, 1, 2, -1, -4]
//        ThreeSum.threeSumToZero(nums: array)
//        ThreeSum.f_threeSumToZero(nums: array)
        ThreeSum.allSumToZero(nums: array)
    }
    
    func majorityElement()  {
        let array:[Int] = [2,2,1,1,1,2,2,3,3,3,3,3]
//        MajorityElement.majorityNumber(nums: array)
        MajorityElement.a_majorityNumber(nums: array)
    }
    
    func firstMissing() {
        let array1:[Int] = [1,2,0]
        let array2:[Int] = [3,4,-1,1]
        let array3:[Int] = [7,8,9,11,12]
        var array4:[Int] = [4,1,5,3,2,-1,-1,-1,3,9]
        let a = FirstMissing.a_firstMissingPositive(&array4)

        print("第一个缺失的正数是\(a)")
    }
    
    func findMedian() {
        let array1 = [1,3,6,7,8]
        let array2 = [9,12]
        FindMedian.findMedianSortedArrays(nums1: array1, nums2: array2)
    }
}

//链表
extension ViewController {
    func findCirclePoint() {
        let head = Node()
        head.value = 0
        let n1 = Node()
        n1.value = 1
        let n2 = Node()
        n2.value = 2
        let n3 = Node()
        n3.value = 3
        let n4 = Node()
        n4.value = 4
        
        head.next = n1
        n1.next = n2
        n2.next = n3
        n3.next = n4
        n4.next = n2
        
        CircleList.haveCircleO1(head: head)
    }
    
    func mergeList() {
        let list0 = makeList(values: [0,1,3,6,7])
        let list1 = makeList(values: [1,2,3])
        let list2 = makeList(values: [2,3,4,5,6])
        MergeList.merge(listArray: [list0,list1,list2])
    }
    
    func makeList(values:[Int]) -> Node {
        let head = Node()
        head.value = values[0]
        var currentNode = head
        for (index,value) in values.enumerated() {
            if index > 0 {
                let node = Node()
                node.value = value
                currentNode.next = node
                currentNode = node
            }
        }
        return head
    }
}

//栈
extension ViewController {
    func vaildBracket() {
        let string = "(){[]}]"
        let valid = ValidBracket.isValid(string: string)
        let log = valid ? "验证成功" : "验证失败"
        print(log)
    }
    
    func vaildLongestBracket() {
        let string = "((())"
        ValidBracket.longestValidParentheses(string: string)
    }
    
    func rpn() {
        let array = ["2", "1", "+", "3", "*"]
//        let array = ["4", "13", "5", "/", "+"]
        let value = EvalRPN.eval(array: array)
        print(value)
    }
}

//队列
extension ViewController {
    func circleQueue() {
        let queue = MyQueue.init(capacity: 3)
        let a = queue.insertFront(value: 0)
        let b = queue.insertFront(value: 1)
        let c = queue.insertFront(value: 2)
        let d = queue.insertFront(value: 3)
        
        let m = queue.getFront()
        let n = queue.getRear()
        
        let q = queue.deleteLast()
        let p = queue.deleteFront()
        print("......")
    }
    
    func slideWindow() {
        let array = [3,4,5,6,7,8,43,5,21,13,5,743,3,5,6]
        let slide = SlideWindow.init(windowSize: 3)
        slide.slide(array: array)
        slide.slide1(array: array)
    }
}

//递归
extension ViewController {
    func clumbStairs() {
        let stair = Stairs()
        stair.clumb(n: 6)
    }
}

//排序
extension ViewController {
    func bubble(){
        let array = [6,5,2,3,1,4,7]
        Sort.bubbleSort(array: array)
    }
    
    func insert() {
        let array = [6,5,2,3,1,4,7]
        Sort.insertSort(array: array)
    }
    
    func selected() {
        let array = [6,5,2,3,1,4,7]
        Sort.selectedSort(array: array)
    }
    
    func merge() {
        var array = [6,5,2,3,1,4,7]
        Sort.mergeSort(array: &array)
    }
    
    func quick() {
        let array = [6,5,2,3,1,4,7,1,12,3,5,6,3,4]
        Sort.quickSort(array: array)
    }
}

//二分查找
extension ViewController {
    func search() {
        let array = [1,2,4,5,6,7,7,9,23,45,76,898]
        Search.binary(from: array, destination: 898)
    }
    
    func firstBigSearch() {
        let array = [1,2,4,5,6,7,7,9,23,45,76,898]
        Search.firstBig(from: array, destination: 897)
    }
    
    func rescursionSearch() {
        let array = [1,2,4,5,6,7,7,9,23,45,76,898]
        
        for value in array {
            Search.recursionSearch(from: array, destination: value)
        }
        
        Search.recursionSearch(from: array, destination: 0)
        Search.recursionSearch(from: array, destination: 88)
    }
    
    func sqrt() {
        print(67.sqrt())
    }
}

//MARK:HashTable
extension ViewController {
    func hashTable() {
        let table = HashTable()
        table.set(value: 19, key: "a")
        table.set(value: 9292, key: "fef")
        table.set(value: 383, key: "23")
        table.set(value: -89, key: "fff")
        table.set(value: -9, key: "ff")
        
        print(table.value(for: "a"))
        print(table.value(for: "fef"))
        print(table.value(for: "23"))
        print(table.value(for: "fff"))
        print(table.value(for: "ff"))
        
        table.remove(from: "a")
        table.remove(from: "fef")
        table.remove(from: "23")
        
        print(table.value(for: "a"))
        print(table.value(for: "fef"))
        print(table.value(for: "23"))
        print(table.value(for: "fff"))
        print(table.value(for: "ff"))
    }
    
    func lruCache() {
        let cache = LRUCache.init(capacity: 3)
        cache.setCache(value: 90, for: "ffe")
        cache.setCache(value: 9, for: "3e")
        cache.setCache(value: 8, for: "34")
        cache.printAllValue()
        
        print("\n")
        cache.setCache(value: 1, for: "1")
        cache.printAllValue()
        
        print("\n")
        cache.getCache(from: "3e")
        cache.printAllValue()
        
        print("\n")
        cache.setCache(value: 77, for: "ffe")
        cache.setCache(value: 3, for: "34")
        cache.printAllValue()
    }
}

//MARK:String
extension ViewController {
    private func bmSearch() {
//        let homeString = ["a","m","l","f","m","f","m","r","t","q","o","m"]
//        let modeString = ["f","m","r"]
        
        let homeString:[Character] = ["a","a","a","a","a","a","a","a","a","a","a","a","a","a"]
        let modeString:[Character]  = ["a","b","a","a"]
        BMStringMatch.match(home: homeString, match: modeString)
    }
    
    private func kmpSearch() {
        let homeString:[Character] = ["a","a","a","a","a","a","a","a","a","a","a","a","a","a"]
        let modeString:[Character]  = ["a","b","a","a"]
//        let homeString:[Character] = ["a","m","l","f","m","f","m","r","t","q","o","m"]
//        let modeString:[Character] = ["f","m","r"]
        KMPStringMatch.match(home: homeString, match: modeString)
    }
    
    private func trie() {
        let trie = Trie()
        trie.append(string: ["f","e","c","k"])
        trie.append(string: ["f","a","v","f"])
        trie.append(string: ["f","e","e","d"])
        trie.append(string: ["f","e","b","m"])
        trie.append(string: ["f","e","c","v"])
        trie.append(string: ["f","e","c","k","e"])
        
        trie.multiModeMatch(string: ["f"])
    }
    
    private func reverseString() {
        var string:[Character] = ["1","2","3","4","5", "6", "7"]
        ReverseString.reverse(string: &string)
    }
    
    private func reverseStringWord() {
        var string:[Character] = ["m","y"," ","l","o","v","e"," ","5", "6"," ", "7"]
        ReverseString.reverseWord(string: &string)
    }
    
    private func atoi(){
        let string:[Character] = [" "," ","-","4","4","5","6","7","8","9","5","6","7","8","9","5","6","7","8","9","5","6","7","8","9","w"]
        let value = Atoi.atoi(string: string)
        print(value)
    }
}

//MARK:BinaryTree
extension ViewController {
    private func searchTree() {
        let tree = SearchTree()
        tree.append(value: 8)
        tree.append(value: 9)
        tree.append(value: 7)
        tree.append(value: 4)
        tree.append(value: 15)
        tree.append(value: 23)
        tree.append(value: 1)
        tree.append(value: 6)
        tree.append(value: 10)
        tree.append(value: 5)
        
//        tree.delete(value: 10)
//        tree.delete(value: 9)
//        tree.delete(value: 8)
//        tree.delete(value: 7)
        
//        tree.traverse(type: .front)
        tree.traverse(type: .level)
        print("树的高度是\(tree.height())")
        
    }
    
    private func turnTree(){
        let array:[Int] = [10,2,5,7,3,9,1,8]
        let tree = TurnTree.init(with: array)
        tree.fPrint()
        tree.turn()
        print("\n")
        tree.fPrint()
    }
    
    private func isSearchTree(){
        let tree = SearchTree()
        tree.append(value: 8)
        tree.append(value: 9)
        tree.append(value: 7)
        tree.append(value: 4)
        tree.append(value: 15)
        tree.append(value: 23)
        
        let tree1 = TurnTree.init(with: [3,4,21,1,5,3,2])
        let check = SearchTreeCheck.isSearchTree(root: tree1.root)
        
        
        print(check)
    }
    
    private func pathPlus(){
        let tree = SearchTree()
        tree.append(value: 8)
        tree.append(value: 9)
        tree.append(value: 7)
        tree.append(value: 4)
        tree.append(value: 15)
        
        let tree1 = TurnTree.init(with: [8,3,5,1,4,21,4,5])
        let pathPlus = PathValuePlus()
        let have = pathPlus.valueInPath(root: tree1.root, plusValue: 17)
        
//        let have = pathPlus.valueInPath(root: tree.root, plusValue: 19)
        print(have)
    }
}

extension ViewController {
    func heap() {
        let heap = Heap()
        heap.append(value: 1)
        heap.append(value: 10)
        heap.append(value: 7)
        heap.append(value: 3)
        heap.append(value: 5)
        heap.append(value: 8)
        heap.append(value: 2)
        heap.append(value: 6)
        
        heap.printArray()
        print("\n移除\(heap.removeTop())\n")
        heap.printArray()
    }
    
    func heapSort() {
        var array = [6,6,7,3,8,12,0,2,5,7]
        HeapSort.sort(with: &array)
        print(array)
    }
}

//MARK:Graph
extension ViewController {
    private func graphBfs() {
        let node1 = GraphNode()
        node1.value = 1

        let node2 = GraphNode()
        node2.value = 2
        
        let node3 = GraphNode()
        node3.value = 3
        
        let node4 = GraphNode()
        node4.value = 4
        
        let node5 = GraphNode()
        node5.value = 5
        
        node1.link(with: node2)
        node2.link(with: node5)
        node5.link(with: node1)
        node3.link(with: node4)
        node4.link(with: node2)
        
        let graph = Graph.init(vertex: [node1,node2,node3,node4,node5])
//        graph.bfs(fromNode: node1, toNode: node3)
        graph.dfs(fromNode: node1, toNode: node3)
        
    }
    
    private func island() {
        let island = Island.init(array: [[1,1,1,1,0],
                                         [1,1,0,1,0],
                                         [1,1,0,0,0],
                                         [0,0,0,0,0]])
//        let island = Island.init(array: [[1,1,0,0,0],
//                                         [1,1,0,1,0],
//                                         [0,0,1,0,0],
//                                         [0,0,0,1,1]])
//        island.dfsCheck()
        island.bfsCheck()
    }
}

//MARK:BackTrack
extension ViewController {
    private func eightQueenBackTrack() {
        let eightQueen = EightQueen()
        eightQueen.printAllPath()
    }
    
    private func oneZeroBag() {
        let bag = OneZeroBag.init(maxWeight: 14, things: [1,5,8,2,3,7])
        bag.find()
    }
}

//MARK:Divide and Conquer
extension ViewController {
    private func reverseNum() {
        let reverse = ReverseOrderNum.init(array: [1,5,8,2,3,7])
        reverse.printReverseOrderNum()
//        reverse.vg_printReverseOrderNum()
    }
}

//MARK:DynamicProgramming
extension ViewController {
    private func dynamicBag() {
        let bag = DynamicBag.init(things: [2,2,4,6,3], maxWeight: 9)
        bag.generateStatus()
    }
    
    private func dynamicPriceBag() {
        let good1 = PriceGood()
        good1.price = 15
        good1.weight = 2
        
        let good2 = PriceGood()
        good2.price = 80
        good2.weight = 2
        
        let good3 = PriceGood()
        good3.price = 14
        good3.weight = 4
        
        let good4 = PriceGood()
        good4.price = 29
        good4.weight = 6
        
        let good5 = PriceGood()
        good5.price = 70
        good5.weight = 3
        
        let bag = DynamicPriceBag.init(maxWeight: 9, things: [good1,good2,good3,good4,good5])
        bag.generateStatus()
        
    }
    
    private func dynamicCoin() {
        let coin = DynamicCoin.init(coinTypes: [1,3,5], needPay: 9)
        coin.countFromStatusTable()
        coin.countFromEquation()
    }
    
    private func subLongest(){
        let queue = LongestIncreasingSubSequences.init(queue: [2, 9, 3, 6, 5, 1, 7,8])
        queue.longest()
    }
    
    private func levenshteinDistance() {
        let distance = LevenshteinDistance.init(string1: ["m","i","t","c","m","u"], string2: ["m","t","a","c","n","u"])
        distance.distance()
    }
    
    private func longestSameLength(){
        let string = LongestSameSubString.init(string1: ["m","i","t","c","m","u"], string2: ["m","t","a","c","n","u"])
        string.length()
    }
    
    private func regularMatch(){
//        let match = RegexMatch.init(string: ["a","a"], regular: ["a","*"])
//        let match = RegexMatch.init(string: ["a","b"], regular: [".","*"])
//        let match = RegexMatch.init(string: ["a","a","b"], regular: ["c","*","a","*","b"])
//        let match = RegexMatch.init(string: ["a","a","b"], regular: ["a","*","c","*","a","*","b"])
//        let match = RegexMatch.init(string: ["a","a","b"], regular: ["c","*","a","*","b","*","c","*"])
        let match = RegexMatch.init(string: ["m","i","s","s","i","s","s","i","p","p","i"], regular: ["m","i","s","*","i","s","*","p","*","."])
        match.match()
    }
    
    private func minPathLength() {
        let path = MinPath.init(array: [[1,3,1],
                                        [1,5,1],
                                        [4,2,1]])
        path.minLength()
    }
    
    private func mutiplySubMax() {
        let _ = MutiplySubMax.init(array: [2,3,-2,4,-2,-2])
    }
}
