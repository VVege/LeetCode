//
//  KMPStringMatch.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/12.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

/// KMP字符串匹配算法
/// 从前向后遍历
/// 模式串中可生成的好前缀，前缀子串与后缀子串的匹配长度信息
/// 前进步数：好前缀的长度 - 该好前缀前后匹配的长度
/// 与BM算法的差距，KMP的前进步数与可匹配前缀相关，BM多于模式串长度相关
/// TODO:使用动态规划实现生成好前缀匹配数组
class KMPStringMatch {
    public class func match(home:[Character],match:[Character]) {
        if home.count < match.count {
            print("主串过小")
            return
        }
        
        var currentHeadIndex = 0
        let matchInfoArray = generateInfo(match: match)
        while currentHeadIndex <= home.count - match.count {
            let subHome = Array.init(home[currentHeadIndex ... currentHeadIndex + match.count - 1])
            let distance = moveDistance(subHome: subHome, match: match, matchInfoArray: matchInfoArray)
            print("当前前进步数\(distance)")
            if distance == 0 {
                print("已找到匹配字符串位置from\(currentHeadIndex),to\(currentHeadIndex + match.count - 1)")
                return
            }
            currentHeadIndex += distance
        }
        print("未找到匹配字符串")
    }
}

extension KMPStringMatch {
    private class func moveDistance(subHome:[Character], match:[Character], matchInfoArray:[Int]) -> Int {
        
        var barCharIndex = 0
        while barCharIndex < match.count {
            if subHome[barCharIndex] == match[barCharIndex] {
                barCharIndex += 1
            }else{
                break
            }
        }
        
        //无好前缀
        if barCharIndex == 0 {
            return 1
        }
        
        //全部匹配
        if barCharIndex == match.count {
            return 0
        }
        
        let matchLength = matchInfoArray[barCharIndex - 1]
        let moveDistance = barCharIndex - matchLength
        return moveDistance
    }
    
    ///模式串中，生成好前缀的后缀子串与好前缀的前缀子串的匹配情况
    ///数组下标代表好前缀子串末尾坐标
    ///数组值代表可匹配的长度
    private class func generateInfo(match:[Character]) -> [Int] {
        var array:[Int] = []
        array.append(0)
        for index in 1 ..< match.count {
            var currentIndex = 0
            var prefix:[Character] = []
            var suffix:[Character] = []
            while currentIndex < index {
                prefix.append(match[currentIndex])
                suffix.insert(match[index - currentIndex], at: 0)
                var equal = true
                for j in 0 ... prefix.count - 1 {
                    if prefix[j] != suffix[j]{
                        equal = false
                    }
                }
                
                if equal {
                     currentIndex += 1
                }else{
                    break
                }
            }
            array.append(currentIndex)
        }
        return array
    }
}
