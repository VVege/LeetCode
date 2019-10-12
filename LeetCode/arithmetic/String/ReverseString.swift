//
//  ReverseString.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/14.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

class ReverseString: NSObject {
    
    //编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。
    //
    //不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
    //
    //你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。
    //
    //来源：力扣（LeetCode）
    //链接：https://leetcode-cn.com/problems/reverse-string
    public class func reverse(string: inout [Character]) {
        reverse(string: &string, fromIndex: 0, toIndex: string.count - 1)
        print(string)
    }
    
    public class func reverseWord(string:inout [Character]) {
        var index = 0
        var startIndex = 0
        var endIndex = 0
        while index < string.count {
            let char = string[index]
            if index == string.count - 1 && endIndex > startIndex{
                reverse(string: &string, fromIndex: startIndex, toIndex: endIndex)
                index += 1
            }else if char == " "{
                //开始交换已有
                if endIndex > startIndex {
                    reverse(string: &string, fromIndex: startIndex, toIndex: endIndex)
                }
                index += 1
                
                //更新下一个word位置
                startIndex = index
                endIndex = startIndex
            }else{
                //记录单词数量
                endIndex = index
                index += 1
            }
        }
        print(string)
    }
    
    private class func reverse(string:inout [Character], fromIndex:Int, toIndex:Int) {
        var index = fromIndex
        
        let endIndex = fromIndex + (toIndex - fromIndex)/2
        while index <= endIndex {
            let start = index
            let end = toIndex - (start - fromIndex)
            let temp = string[start]
            string[start] = string[end]
            string[end] = temp
            index += 1
        }
    }
}
