//
//  EvalRPN.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/7/19.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

enum OperatorType {
    case plus
    case minus
    case multiply
    case division
}

struct Operator {
    
    private var type = OperatorType.plus
    init(string:String) {
        if string == "+"{
            type = .plus
        }else if string == "-"{
            type = .minus
        }else if string == "*"{
            type = .multiply
        }else if string == "/"{
            type = .division
        }
    }
    
    public func operate(num1:Int, num2:Int) -> Int{
        switch type {
        case .plus:
            return num1 + num2
        case .minus:
            return num1 - num2
        case .multiply:
            return num1 * num2
        case .division:
            return num1 / num2
        }
    }
}
//根据逆波兰表示法，求表达式的值。
//
//有效的运算符包括 +, -, *, / 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
//https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
class EvalRPN: NSObject {
    class public func eval(array:[String]) -> Int {
        var stack:[Int] = []
        
        for item in array {
            if let value = Int.init(item) {
                stack.append(value)
            }else {
                let operation = Operator.init(string: item)
                let first = stack.removeLast()
                let second = stack.removeLast()
                
                let newLast = operation.operate(num1: second, num2: first)
                let newIndex = stack.count > 1 ? stack.count - 1 : 0
                stack.insert(newLast, at: newIndex)
            }
        }
        
        if stack.count == 1 {
            return stack[0]
        }
        
        print("数据格式错误")
        return 0
    }
}
