//
//  outputGuideLineMap.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/23.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/*
 3、输出导游路线图
 深度优先遍历
 */
import Foundation

public func outputGuiLineMap(graph:inout Graph) {
    
    var connectedVectorCount:Int = 0
    for vertex:ArcNode in graph.vertexArr {
        vertex.visited = false
    }
    for vertex:ArcNode in graph.vertexArr {
        if !vertex.visited {
            DFSTraverse(graph: &graph, vertex: vertex)
            connectedVectorCount += 1 //联通分量
        }
    }
    print("联通分量一共有\(connectedVectorCount)个")
    
    //判断两个景点间是否有直接相连的边
    let temp1:ArcNode = ArcNode(name: "狮子山")
//    let temp2:ArcNode = ArcNode(name: "碧水亭")
    let temp2:ArcNode = ArcNode(name: "北门")
    IsEdge(graph: &graph, vertex1: temp1, vertex2: temp2)
}

public func DFSTraverse(graph:inout Graph, vertex:ArcNode) {
    vertex.visited = true
    print("\(vertex.name)-->",terminator:"")
    for nextPoint:ArcNode in graph.vertexArr {
        if !nextPoint.visited {
            DFSTraverse(graph: &graph, vertex: nextPoint)
        }
    }
}

//判断要查的这两个顶点之间是否有直接相连的边：
public func IsEdge(graph:inout Graph, vertex1:ArcNode, vertex2:ArcNode) {
    let weight:Int = graph.getWeight(vertexName: vertex1.name, anotherName: vertex2.name)
    if weight != 32676 && weight != 0 {
        print("\(vertex1.name)与\(vertex2.name)之间有直接相连的边!");
    } else {
        print("\(vertex1.name)与\(vertex2.name)之间没有直接相连的边")
    }
}
