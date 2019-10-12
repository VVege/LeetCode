//
//  RegexMatch.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/26.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
//https://leetcode-cn.com/problems/regular-expression-matching/
///觉得这题没有动态规划的必要
enum MatchSymbol {
    case none
    case star
}

class Regular {
    var value:Character!
    var matchSymbol = MatchSymbol.none
}

class RegexMatch {
    private var myString:[Character]!
    private var myRegular:[Regular]!
    
    init(string:[Character],regular:[Character]) {
        myString = string
        myRegular = generateRegularArray(regular: regular)
    }
    
    private func generateRegularArray(regular:[Character]) -> [Regular]{
        var array:[Regular] = []
        var i = 0
        while i < regular.count{
            let char = regular[i]
            var nextChar:Character?
            if i < regular.count - 1 {
                nextChar = regular[i + 1]
            }
            if let nextChar = nextChar, nextChar == "*" {
                let matchReg = Regular.init()
                matchReg.value = char
                matchReg.matchSymbol = .star
                array.append(matchReg)
                i += 2
            }else{
                let matchReg = Regular()
                matchReg.matchSymbol = .none
                matchReg.value = char
                array.append(matchReg)
                i += 1
            }
        }
        return array
    }
}

//MARK:Public
extension RegexMatch {
    public func match(){
        var regularIndex = 0
        var tryNext = false
        
        for i in 0 ..< myString.count {
            if regularIndex >= myRegular.count {
                print("匹配失败")
                return
            }
            
            let char = myString[i]
            let regular = myRegular[regularIndex]
            switch regular.matchSymbol {
            case .none:
                if regular.value == char || regular.value == "." {
                    tryNext = false
                    regularIndex += 1
                }else{
                    print("匹配失败")
                    return
                }
            case .star:
                if regular.value == char{
                    tryNext = false
                    continue
                }
                if regular.value == "." {
                    regular.value = char
                    tryNext = false
                    continue
                }
                
                if !tryNext {
                    regularIndex += 1
                    tryNext = true
                }else{
                    print("匹配失败")
                    return
                }
            }
        }
        
        //规则如果有剩余，则包含非星就失败
        if regularIndex < myRegular.count - 1 {
            for i in regularIndex ... (myRegular.count - 1) {
                let regular = myRegular[i]
                if regular.matchSymbol == .none {
                    print("匹配失败")
                    return
                }
            }
        }
        
        print("匹配成功")
    }
}
