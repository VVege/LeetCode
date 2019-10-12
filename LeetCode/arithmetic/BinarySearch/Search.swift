//
//  Search.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/5.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class Search {
    
    /// 普通二分查找
    public class func binary(from array:[Int], destination:Int) {
        
        var low = 0
        var high = array.count - 1
        //精髓
        while (low <= high) {
            let middle = (low + high)/2
            if array[middle] < destination {
                //精髓
                low = middle + 1
            }else if array[middle] > destination {
                //精髓
                high = middle - 1
            }else{
                print("\(destination)所在index为\(middle)")
                return
            }
        }
        
        print("未找到值为\(destination)的元素")
    }
    
    /// 二分查找到大于等于给定值的第一个元素
    public class func firstBig(from array:[Int], destination:Int) {
        var low = 0
        var high = array.count - 1
        while (low <= high) {
            
            let middle = (low + high)/2
            
            if array[middle] <= destination {
                //精髓
                if middle <= array.count - 1 && array[middle + 1] > destination {
                    print("第一个值比\(destination)大的元素是\(array[middle + 1]), 位置在\(middle + 1)")
                    return
                }
                low = middle + 1
            }else {
                if (middle == 0) || (middle > 0 && array[middle - 1] < destination) {
                    print("第一个值比\(destination)大的元素是\(array[middle]),位置在\(middle)")
                    return
                }
                high = middle - 1
            }
        }
        print("未找到第一个值比大\(destination)的元素")
    }
}

//递归二分查找
extension Search {
    public class func recursionSearch(from array:[Int], destination:Int){
        recursion(array: array, startIndex: 0, endIndex: array.count - 1, destination: destination)
    }
    
    private class func recursion(array:[Int], startIndex:Int,endIndex:Int ,destination: Int){

        if startIndex > endIndex {
            print("未找到值为\(destination)的元素")
            return
        }
        
        let searchIndex = (startIndex + endIndex)/2
        
        if array[searchIndex] == destination {
            print("\(destination)所在index为\(searchIndex)")
            return
        }
        
        if array[searchIndex] < destination {
            let newStart = searchIndex + 1
            let newEnd = endIndex
            recursion(array: array, startIndex: newStart, endIndex: newEnd, destination: destination)
        }else {
            let newStart = startIndex
            let newEnd = endIndex - 1
            recursion(array: array, startIndex: newStart, endIndex: newEnd, destination: destination)
        }
    }
}
