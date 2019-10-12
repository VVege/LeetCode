//
//  Stairs.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/7/29.
//  Copyright © 2019 vege. All rights reserved.
//

import Foundation

class Stairs {
    private var m = 0
    public func clumb(n:Int) {
        if n >= 2 {
            clumb(n: n - 1)
            clumb(n: n - 2)
        }else if n >= 1 {
            clumb(n: n - 1)
        }else{
            m += 1
            print("完成第\(m)种解法")
        }
    }
}
