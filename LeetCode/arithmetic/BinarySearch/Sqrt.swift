//
//  Sqrt.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/9.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit

//保留四位小数
extension Int {
    
    public func sqrt() -> CGFloat {
        return search(start: 0, end: CGFloat(self))
    }
    
    private func search(start:CGFloat, end:CGFloat) -> CGFloat {
        let value = (start + end)/2
        let destination = self * 10000
        let currentValue = Int(value * value * 10000)
        if currentValue == destination {
            return value
        }else if currentValue < destination {
            return search(start: value + 0.0001, end: end)
        }else{
            return search(start: start, end: value - 0.0001)
        }
    }
}
