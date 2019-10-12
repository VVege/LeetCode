//
//  Sort.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/1.
//  Copyright © 2019 vege. All rights reserved.
//

import Foundation

class Sort {
    public class func bubbleSort(array:[Int]){
        var myArray = array
        for i in 0 ..< myArray.count - 1 {
            for j in 0 ..< myArray.count - 1 - i{
                if myArray[j] < myArray[j + 1]{
                    let temp = myArray[j]
                    myArray[j] = myArray[j + 1]
                    myArray[j + 1] = temp
                }
            }
        }
        
        printArray(array: myArray)
    }
    
    public class func insertSort(array:[Int]){
        var myArray = array
        for i in 1 ... myArray.count - 1 {
            
            let temp = myArray[i]
            var sj = i
            //倒序数据搬移较为方便
            for j in (0 ..< i).reversed() {
                if myArray[j] < temp {
                    myArray[j + 1] = myArray[j]
                    sj = j
                }else{
                    break
                }
            }
            myArray[sj] = temp
        }
        printArray(array: myArray)
    }
    
    public class func selectedSort(array:[Int]){
        var myArray = array
        for i in 0 ..< myArray.count  {
            var minIndex = i
            
            //寻找最小
            for j in i ..< myArray.count {
                if myArray[j] < myArray[minIndex]{
                    minIndex = j
                }
            }

            //将最小和当前位置交换
            let temp = myArray[i]
            myArray[i] = myArray[minIndex]
            myArray[minIndex] = temp
        }
        
        printArray(array: myArray)
    }
    
    public class func mergeSort(array:inout [Int]){
        separate(array: &array, start: 0, end: array.count - 1)
        printArray(array: array)
    }
    
    public class func quickSort(array:[Int]){
        var myArray = array
        let allRange = 0 ..< array.count
        partition(array: &myArray, range: allRange)
        printArray(array: myArray)
    }
}

extension Sort {
    private class func printArray(array:[Int]){
        array.forEach { (value) in
            print(value)
        }
    }
    
    private class func separate(array:inout [Int],start:Int,end:Int){
        
        if end <= start {
            return
        }
        let middel = (end + start)/2
        separate(array: &array, start: start, end: middel)
        separate(array: &array, start: middel + 1, end: end)

        var index1:[Int] = []
        var index2:[Int] = []
        
        for i in start ... middel {
            index1.append(i)
        }
        
        for j in middel+1 ... end {
            index2.append(j)
        }
        
        merge(array: &array, index1: index1, index2: index2)
    }
    
    private class func merge(array:inout [Int],index1:[Int], index2:[Int]) {
        var newArray:[Int] = []
        
        var x:Int = index1.startIndex
        var y:Int = index2.startIndex
        
        var xFull = false
        var yFull = false
        
        while !xFull || !yFull {
            let xValue = array[index1[x]]
            let yValue = array[index2[y]]
            if xFull {
                newArray.append(yValue)
                y = y + 1
                if y >= index2.count{
                    yFull = true
                    y = index2.count - 1
                }
            }else if yFull {
                newArray.append(xValue)
                x = x + 1
                if x >= index1.count {
                    xFull = true
                    x = index1.count - 1
                }
            }else if xValue < yValue {
                newArray.append(xValue)
                x = x + 1
                if x >= index1.count {
                    xFull = true
                    x = index1.count - 1
                }
            }else {
                newArray.append(yValue)
                y = y + 1
                if y >= index2.count{
                    yFull = true
                    y = index2.count - 1
                }
            }
        }
        
        for i in 0 ..< index1.count {
            array[index1[i]] = newArray[i]
        }
        
        for j in 0 ..< index2.count {
            array[index2[j]] = newArray[j + index1.count]
        }
    }
    
    private class func partition(array:inout [Int],range:Range<Int>) {
        
        let firstIndex = range.startIndex
        let lastIndex = range.endIndex - 1
        
        if firstIndex >= lastIndex {
            return
        }
        
        var minBigIndex = -1
        let partitionValue = array[lastIndex]
        
        for i in firstIndex ..< lastIndex {
            let currentValue = array[i]
            if currentValue >= partitionValue{
                if minBigIndex < 0 {
                    minBigIndex = i
                }
            }else{
                if minBigIndex >= 0 {
                    array[i] = array[minBigIndex]
                    array[minBigIndex] = currentValue
                    minBigIndex += 1
                }
            }
        }
        
        //将分区点从最后交换到正确的位置
        if minBigIndex >= 0 {
            array[lastIndex] = array[minBigIndex]
            array[minBigIndex] = partitionValue
        }
        
        //没有找到比之大的
        if minBigIndex == -1 {
            let smallRange = firstIndex ..< lastIndex
            partition(array: &array, range: smallRange)
            return
        }
        
        //比之小的只有一个，无需再排
        if minBigIndex <= firstIndex + 1 {
            let bigRange = minBigIndex+1 ..< lastIndex + 1
            partition(array: &array, range: bigRange)
            
            return
        }
        
        //比之大的只有一个无需再排
        if minBigIndex == lastIndex - 1 {
            let smallRange = firstIndex ..< minBigIndex
            partition(array: &array, range: smallRange)
            return
        }
        
        let smallRange = firstIndex ..< minBigIndex
        let bigRange = minBigIndex+1 ..< lastIndex + 1
        partition(array: &array, range: smallRange)
        partition(array: &array, range: bigRange)
    }
}
