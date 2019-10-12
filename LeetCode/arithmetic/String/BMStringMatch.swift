//
//  BMStringMatch.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/8/11.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

enum BMMatchResult:Int {
    ///子串count与模式串count不相等
    case error = -3
    ///子串与模式串匹配
    case match = -2
    ///坏字符规则计算移动值为负
    case badCharFail = -1
}

///BM字符串匹配算法
///1坏字符串规则
///2.好后缀规则

///坏字符规则在末尾字符可匹配的情况下可能出现移动为负值的情况，根据这种特殊情况，出现好后缀规则，专门利用末位的重复后缀计算移动量，成为坏字符的弥补者.
///坏字符和好后缀都可以预先生成散列表来减少匹配时的计算
///坏字符：生成一个坏字符位置查找表，遇到坏字符时直接查找模式串中是否有对应的字符
///好后缀，生成一个后缀位置查找表，遇到好后缀时可以直接查找，该后缀对应的前缀位置
class BMStringMatch {
    public class func match(home:[Character], match:[Character]){
        if home.count < match.count {
            print("error主字符串过小")
            return
        }
        
        var currentLastIndex = match.count - 1
        let goodSuffixInfo = generateSubMatchDictionary(match: match)
        let badCharInfo = gengrateModeDictionary(match: match)
        while currentLastIndex < home.count {
            
            let startIndex = currentLastIndex - (match.count - 1)
            let currentSub = home[startIndex ... currentLastIndex]
            let subArray = Array.init(currentSub)
            let badCharDistance = badCharMoveDistance(subMain: subArray, match: match, matchIndexInfo: badCharInfo)
            let goodSuffixDistance = goodSuffixMove(subMain: subArray, match: match, modeMatchDictionary: goodSuffixInfo)
            if badCharDistance == BMMatchResult.match.rawValue{
                print("找到匹配的字符串,位置在\(startIndex)到\(currentLastIndex)")
                return
            }else if goodSuffixDistance == BMMatchResult.match.rawValue{
                print("找到匹配的字符串,位置在\(startIndex)到\(currentLastIndex)")
                return
            }
            print("\n坏字符前进\(badCharDistance)")
            print("\n好后缀前进\(goodSuffixDistance)")
            let moveDistance = max(badCharDistance, goodSuffixDistance)
            if moveDistance < 0 {
                print("数据错误")
                return
            }
            currentLastIndex += moveDistance
        }
        
        print("未找到相匹配的字符串")
    }
}

//MARK:Private
extension BMStringMatch {
    
    //坏字符规则
    private class func badCharMoveDistance(subMain:[Character], match:[Character], matchIndexInfo:Dictionary<Character,Int>) -> Int {
        
        if subMain.count != match.count {
            return BMMatchResult.error.rawValue
        }
        
        var badCharIndex = subMain.count - 1
        
        //寻找坏字符位置
        while badCharIndex >= 0 {
            let hChar = subMain[badCharIndex]
            let mChar = match[badCharIndex]
            if hChar == mChar {
                badCharIndex -= 1
            }else{
                break
            }
        }
        
        if badCharIndex == -1 {
            return BMMatchResult.match.rawValue
        }
        
        //寻找模式串中与坏字符相同字符的位置
        let badChar = subMain[badCharIndex]
        let matchIndex = matchIndexInfo[badChar]  ?? badCharIndex - 1
        
        let moveDistance = badCharIndex - matchIndex
        if moveDistance < 0 {
            return BMMatchResult.badCharFail.rawValue
        }
        
        return moveDistance
    }
    
    //好后缀规则
    private class func goodSuffixMove(subMain:[Character], match:[Character], modeMatchDictionary:Dictionary<Int, Int>) -> Int {
        if subMain.count != match.count {
            return BMMatchResult.error.rawValue
        }
        
        //没有好后缀则只移动1位
        if subMain[subMain.count - 1] != match[match.count - 1]{
            return 1
        }
        
        var matchedIndex = subMain.count - 1
        while matchedIndex >= 0 {
            if subMain[matchedIndex] == match[matchedIndex]{
                matchedIndex -= 1
            }else{
                break
            }
        }
        
        if matchedIndex == -1 {
            return BMMatchResult.match.rawValue
        }
        
        //寻找模式串中与好后缀匹配的前缀子串，如果找到，移动到对应子串
        //如果没有与好后缀匹配的前缀子串，则寻找与好后缀的前缀子串匹配的模式串中的前缀子串
        let matchSuffixLength = subMain.count - 1 - matchedIndex
        if let matchLength = modeMatchDictionary[matchSuffixLength], matchLength > 0{
            //计算移动距离
            let notMatchedSuffixLength = matchSuffixLength - matchLength
            let moveDistance = match.count - notMatchedSuffixLength - matchLength
            return moveDistance
        }
        
        //没有任何匹配则移动最大距离
        return match.count
    }
    
    private class func gengrateModeDictionary(match:[Character]) -> Dictionary<Character,Int>{
        
        var dic:Dictionary<Character,Int> = Dictionary()
        for (index, value) in match.enumerated() {
            dic[value] = index
        }
        return dic
    }
    
    ///生成模式串后缀子串是否能与前缀子串相匹配的Dictionary
    ///key:后缀长度
    ///value:对应长度的前缀与后缀可匹配的长度
    private class func generateSubMatchDictionary(match:[Character]) -> Dictionary<Int, Int> {
        var currentIndex = 0
        var dictionary:Dictionary<Int,Int> = Dictionary()
        
        var suffix:[Character] = []
        var prefix:[Character] = []
        while currentIndex < match.count {
            prefix.append(match[currentIndex])
            suffix.append(match[match.count - 1 - currentIndex])
            var index = 0
            while index < prefix.count {
                if prefix[index] == suffix[index]{
                    index += 1
                }else{
                    break
                }
            }
            dictionary[currentIndex] = index
            currentIndex += 1
        }
        
        return dictionary
    }
}
