//
//  findLoopWay.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/24.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

/*
 4、输出导游路线图中的回路。
 思路，跟深度遍历一样进行递归，然后另外定义一个数组，把每次走的点的名字记录下来（记录路径）
 每走下一步，然后都往路径里面
 */

import Foundation

public func findLoopWay(graph:inout Graph) {
    var pathArr:[String] = []  //定义一个数组来记录走过的点
    for vertex:ArcNode in graph.vertexArr {
        vertex.visited = false
    }
    for vertex:ArcNode in graph.vertexArr {
        if !vertex.visited {
            moveToNext(graph: &graph, pathArr:&pathArr, vertex: vertex)
            
        }
    }
    
    

}

public func moveToNext(graph:inout Graph, pathArr:inout [String], vertex:ArcNode) {
    vertex.visited = true
    print("\(vertex.name)-->",terminator:"")
    pathArr.append(vertex.name)

    for connectedEdge:Edge in vertex.connectedEdgeArr {
        let nextPointName:String = connectedEdge.endPoint.name
        let nextPoint:ArcNode = graph.getArcNode(vertexName: nextPointName)!
        if !nextPoint.visited {
//            DFSTraverse(graph: &graph, pathArr: &pathArr, vertex: nextPoint)
//            DFSTraverse(graph: &graph, path: &path:, pathsArr: &<#T##NSMutableArray#>, vertex: <#T##ArcNode#>)
        } else {                            //判断是否已经走过
            for passedPointName:String in pathArr {
                if passedPointName == nextPoint.name {
                    print("\(nextPoint.name) 发现回路！")
                }
            }
        }
    }
}


