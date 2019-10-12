//
//  Atoi.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/14.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//https://leetcode-cn.com/problems/string-to-integer-atoi/
//String 转 int

class Atoi {

    public class func atoi(string:[Character]) -> Int {
        var value = 0
        var headValid = false
        var nativeTag = true
        let bit = 10
        
        for char in string {
            if !headValid {
                if char == " "{
                    
                }else if let native = isNative(char: char){
                    nativeTag = native
                    headValid = true
                }else if let newValue = intValue(char: char){
                    value = newValue
                    headValid = true
                }else{
                    return 0
                }
            }else{
                if let newValue = intValue(char: char){
                    if value > (Int.max - newValue)/10 {
                        print("数值越界，返回32位Int最大值\n")
                        return Int.max
                    }else{
                        value = value * bit + newValue
                    }
                }else{
                    break
                }
            }
        }
        
        if nativeTag == false {
            value = -value
        }
        return value
    }
    
    private class func isNative(char:Character) -> Bool? {
        if char == "+" {
            return true
        }else if char == "-"{
            return false
        }
        return nil
    }
    
    private class func intValue(char:Character) -> Int? {
        if char == "0" {
            return 0
        }
        if char == "1" {
            return 1
        }
        if char == "2" {
            return 2
        }
        if char == "3" {
            return 3
        }
        if char == "4" {
            return 4
        }
        if char == "5" {
            return 5
        }
        if char == "6" {
            return 6
        }
        if char == "7" {
            return 7
        }
        if char == "8" {
            return 8
        }
        if char == "9" {
            return 9
        }
        return nil
    }
}
