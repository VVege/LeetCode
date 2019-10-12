//
//  LongestIncreasingSubSequences.swift
//  LeetCode
//
//  Created by 周智伟 on 2019/8/23.
//  Copyright © 2019 vege. All rights reserved.
//

import UIKit
//2, 9, 3, 6, 5, 1, 7 这样一组数字序列，它的最长递增子序列就是 2, 3, 5, 7，所以最长递增子序列就是 2, 3, 5, 7，所以最长递增子序列的长度是 4
///最长子序列问题

class LongestIncreasingSubSequences {
    private var status:[Int]!
    private var myQueue:[Int]!
    init(queue:[Int]) {
        myQueue = queue
    }
}

extension LongestIncreasingSubSequences {
    public func longest() {
        ///状态数组对应的是myQueue中对应元素的最长递增长度
        status = Array.init(repeating: Int.min, count: myQueue.count)
        status[0] = 1
        
        for i in 1 ..< myQueue.count {
            
            var preValueSmallMaxLong = 0
            var preMaxLong = 0
            for j in 0 ..< i {
                ///值比当前值小的元素的最大长度
                if status[j] > preValueSmallMaxLong && myQueue[j] < myQueue[i] {
                    preValueSmallMaxLong = status[j]
                }
                
                ///前面的整体最大长度
                if status[j] > preMaxLong {
                    preMaxLong = status[j]
                }
            }
            status[i] = max(preValueSmallMaxLong + 1, preMaxLong)
        }
        
        print("最长递增子序列长度为\(status[status.count - 1])")
    }
}
