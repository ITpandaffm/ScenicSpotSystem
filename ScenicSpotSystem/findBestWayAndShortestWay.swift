//
//  findBestWayAndShortestWay.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/24.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/*
 求两个景点间的最短路径和最短距离。
 */

import Foundation


public func findBestWayAndShortestWay (graph: Graph) {
    print("请输入要查询的两个距离的两个景点名称（空格隔开）")
    let places = getUserInput()
    let startPlace:String = places.first!
    let endPlaces:String = places.last!
    
    

}

func getUserInput() -> [String] {
    let stdInput = FileHandle.standardInput
    let userInput = NSString(data: stdInput.availableData, encoding: String.Encoding.utf8.rawValue)
    var tempArr = userInput?.components(separatedBy: " ")
    let tempArr2 = tempArr?.last?.components(separatedBy: "\n")
    //把空格去掉归并到一个数组里
    tempArr?.removeLast()
    tempArr?.append((tempArr2?.first)!)
    return tempArr!
}
