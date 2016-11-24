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
 
 思路有误。（无向）
 
 1.先判断是否有回路 （计算度 ，把每个结点度都大于1那就肯定了，如果有存在1的，删掉，并相应结点扣1 如果都大于2 那就存在
 2.当存在回路，就进行寻找
 3.深度优先遍历，当遇到起始点的时候，标记，然后继续，遍历完，退栈，看有否更短的其他路径，（注意排除只有2个结点的环
 
 胜利竣工✌️，思路主要是记录走过的路径，每准备走下一步的时候，对下一个点进行多重判断
 如果没遍历过，则当前点设为它，如果遍历过，判断是否是起点，如果是起点，则判断长度，如果符合形成回路的长度，则证明发现了一个回路
 
 代码再重构！ 大量优化代码，极大缩小代码篇幅， 当遇到遍历过的点，其实也不用管他是不是顶点了
 */
import Foundation

public func findLoopWay(graph:Graph) {
    var path:[String] = []
    for vertex:ArcNode in graph.vertexArr {
        vertex.visited = false
    }
    for vertex:ArcNode in graph.vertexArr {
        if !vertex.visited {
            moveToNext(graph: graph, path: &path ,vertex: vertex)
        }
    }
    
}

func moveToNext(graph:Graph, path:inout [String] ,vertex:ArcNode)
{
    vertex.visited = true
    path.append(vertex.name)
    for connectedEdge:Edge in vertex.connectedEdgeArr {
        let nextPointName:String = connectedEdge.endPoint.name
        let nextPoint:ArcNode = graph.getArcNode(vertexName: nextPointName)!
        if !nextPoint.visited {
            moveToNext(graph: graph, path:&path ,vertex: nextPoint)
        } else {                                //走过的点，判断是否满足产生回路的条件
            let lastTimePointIndex:Int = findLastSamePointInPath(path: path, pointName: nextPointName)
            if path.count - lastTimePointIndex - 1 > 1 {
                let pathNSArray:NSArray = path as NSArray
                let range = NSMakeRange(lastTimePointIndex, path.count-lastTimePointIndex-1)
                let loop = pathNSArray.subarray(with: range)
                for str in loop {
                    print("\(str)-->",terminator:"")
                        }
                print(nextPointName)
                }
            
            }
        }
    path.removeLast()       //要退一步的时候，模拟进行退栈，把最后一个元素移除
}


func findVertexIndexInVertexArr(graph:Graph, vertex:ArcNode) -> Int { //这里假设传个Array，要有泛型[Arcnode] 还不如干脆整个graph传过来
    for i in 0 ..< graph.vertexArr.count {
        let temp:ArcNode = graph.vertexArr[i]
        if temp.name == vertex.name {
            return i
        }
    }
    return 32676
}

func findLastSamePointInPath(path:[String], pointName:String) -> Int {
    for i in 0 ..< path.count {
        let point:String = path[i]
        if pointName == point {
            return i
        }
    }
    return 32676
}
