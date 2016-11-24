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
 
 之前错了！不应该在整个数组里找啊！！应该找与点相连的边
 
 /*
 bugs
 北门-->狮子山-->一线天-->观云台-->飞流瀑-->红叶亭-->花卉园-->朝日峰-->碧水亭-->仙武湖-->仙云石-->九曲桥-->请输入你要选择的菜单项
 1.飞流瀑-->红叶亭 32676
 2.花卉园-->朝日峰
 
 找到问题所在了，原来只是输出问题，因为到达该点之后就直接输出，当走到尽头的时候，而不能撤销输出，所以看起来就好像 飞流瀑-->红叶亭 有路一样，其实只是因为输出问题
 解决：先不输出，先存数组里，直到最后才进行速出
 */
 */
import Foundation

public func outputGuiLineMap(graph:Graph) {
    
    var path:[String] = []
    var pathsArr:NSMutableArray = []
    
    var connectedVectorCount:Int = 0
    for vertex:ArcNode in graph.vertexArr {
        vertex.visited = false
    }
    for vertex:ArcNode in graph.vertexArr {
        if !vertex.visited {
            DFSTraverse(graph: graph, path: &path, pathsArr: &pathsArr ,vertex: vertex)
            connectedVectorCount += 1 //联通分量
        }
    }
    
    //查找最大值
    let maxCount:Int = findTheMaxCountArr(arr: pathsArr)
    path = pathsArr[maxCount] as! [String]
    print("为您推荐的最佳导游路线一条路走到底不走回头路！")
    for str:String in path {
        if str != path.last {
            print("\(str)-->",terminator:"")
        } else {
            print(str)
        }
    }
    
    print("联通分量一共有\(connectedVectorCount)个")
    
    //判断两个景点间是否有直接相连的边
    let temp1:ArcNode = ArcNode(name: "狮子山")
//    let temp2:ArcNode = ArcNode(name: "碧水亭")
    let temp2:ArcNode = ArcNode(name: "北门")
    IsEdge(graph: graph, vertex1: temp1, vertex2: temp2)
}

func DFSTraverse(graph:Graph, path:inout [String], pathsArr:inout NSMutableArray,vertex:ArcNode) {
    vertex.visited = true
    path.append(vertex.name)
    for connectedEdge:Edge in vertex.connectedEdgeArr {
        let nextPointName:String = connectedEdge.endPoint.name
        let nextPoint:ArcNode = graph.getArcNode(vertexName: nextPointName)!
        if !nextPoint.visited {
            
            DFSTraverse(graph: graph, path:&path, pathsArr: &pathsArr ,vertex: nextPoint)
        }
    }
    pathsArr.add(path)
    path.removeLast()

}
//    for nextPoint:ArcNode in graph.vertexArr { 警钟长鸣，找下一个点的时候要从与该点相连的那些点里去找
//        if !nextPoint.visited {
//            DFSTraverse(graph: &graph, vertex: nextPoint)
//        }
//    }


//判断要查的这两个顶点之间是否有直接相连的边：
func IsEdge(graph:Graph, vertex1:ArcNode, vertex2:ArcNode) {
    let weight:Int = graph.getWeight(vertexName: vertex1.name, anotherName: vertex2.name)
    if weight != 32676 && weight != 0 {
        print("\(vertex1.name)与\(vertex2.name)之间有直接相连的边!");
    } else {
        print("\(vertex1.name)与\(vertex2.name)之间没有直接相连的边")
    }
}

//查找路径数组里面的最大值
func findTheMaxCountArr(arr:NSMutableArray) -> Int {
    var maxCount = 0
    var maxCountArr:[String] = arr[maxCount] as! [String]
    for i in 1 ..< arr.count {
        let temp:[String] = arr[i] as! [String]
        if temp.count > maxCountArr.count {
            maxCountArr = temp
            maxCount = i
        }
    }
    return maxCount
}


