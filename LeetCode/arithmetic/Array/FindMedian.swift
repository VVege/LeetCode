//
//  FindMedian.swift
//  LeetCode
//
//  Created by 伟哥 on 2019/5/31.
//  Copyright © 2019年 vege. All rights reserved.
//
//给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。
//
//请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
//
//你可以假设 nums1 和 nums2 不会同时为空。
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/median-of-two-sorted-arrays
//著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

//使用双index的方式定位到中位数 small为小数量数组的index m 为小数量数组的数量
//如何确定双index
//1. small + big = (m + n - 1)/2
//2. 保证 big的上一个小于small。small的下一个大于big
//3. 已二分法前进
//4. 处理细节

import UIKit

class FindMedian: NSObject {
    public class func findMedianSortedArrays(nums1:[Int], nums2:[Int]) {
        var bigNum = nums1;
        var smallNum = nums2;
        if nums1.count < nums2.count {
            bigNum = nums2;
            smallNum = nums1;
        }
    
        let m = bigNum.count;
        let n = smallNum.count;
        
        let middle = (m + n - 1)/2
        
        var j = 0
        
        while j < n {
            let bigPValue = bigNum[middle - j];
            let smallPValue = smallNum[j];
            
            let bigPNextValue = bigNum[middle - j + 1];
            let smallPNextValue = smallNum[j + 1];
            if bigPValue <= smallPNextValue && smallPValue <= bigPNextValue {
                print(bigPValue,smallPValue);
                break
            }else if smallPValue > bigPNextValue {
                let step = max((n - j)/2, 1)
                j = j + step
            }else if smallPNextValue < bigPValue {
                if j <= 0 {
                    print(bigPValue);
                    break;
                }else{
                    let step = max(j/2, 1)
                    j = j - step
                }
            }
        }
    }
}
