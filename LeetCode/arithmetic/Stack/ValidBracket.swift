//
//  ValidBracket.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/7/15.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit
//给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
//
//有效字符串需满足：
//
//左括号必须用相同类型的右括号闭合。
//左括号必须以正确的顺序闭合。
//注意空字符串可被认为是有效字符串。
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/valid-parentheses
//著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


class ValidBracket {
    class public func isValid(string:String) -> Bool{
        var leftBracketArray:[String.Element] = []
        for (_, char) in string.enumerated() {
            if isLeft(element: char){
                leftBracketArray.append(char)
            }else if leftBracketArray.count > 0{
                //栈 先入后出
                let leftChar = leftBracketArray.removeLast()
                if !isMatch(left: leftChar, right: char){
                    return false
                }
            }else{
                return false
            }
        }
        return leftBracketArray.count == 0
    }
    
    class private func isLeft(element:Character) -> Bool {
        return element == "(" || element == "[" || element == "{"
    }
    
    class private func isMatch(left:Character, right:Character) -> Bool {
        let small = left == "(" && right == ")"
        let middle = left == "[" && right == "]"
        let big = left == "{" && right == "}"
        return small || middle || big
    }
}

//给定一个只包含 '(' 和 ')' 的字符串，找出最长的包含有效括号的子串的长度。
//https://leetcode-cn.com/problems/longest-valid-parentheses/
extension ValidBracket {
    class public func longestValidParentheses(string:String) {
        var leftBracketArray:[String.Element] = []
        var maxCount = 0
        for (_, char) in string.enumerated() {
            if isLeft(element: char){
                leftBracketArray.append(char)
            }else if leftBracketArray.count > 0{
                //栈 先入后出
                let leftChar = leftBracketArray.removeLast()
                if isMatch(left: leftChar, right: char){
                    maxCount = maxCount + 2
                }
            }
        }
        print("最长匹配子串长度为\(maxCount)")
        
    }
}
