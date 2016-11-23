//
//  outputDistributionMap.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/23.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/*
 2.输出景区景点分布图
 */

import Foundation

public func outputDistributionMap(graph:inout Graph) {
    print("开始输出景区景点分布图")
    var nameStr:String = "   "
    for vertex:ArcNode in graph.vertexArr {
        nameStr="\(nameStr)\t\(vertex.name)"
    }
    print(nameStr)
    for vertex:ArcNode in graph.vertexArr {
        let startPointName:String = vertex.name
        var outputStr:String = startPointName
        for anotherVertex:ArcNode in graph.vertexArr {
            let endPointName:String = anotherVertex.name
            outputStr = "\(outputStr)\t\(graph.getWeight(vertexName: startPointName, anotherName: endPointName))"
        }
        print(outputStr)
    }
}
