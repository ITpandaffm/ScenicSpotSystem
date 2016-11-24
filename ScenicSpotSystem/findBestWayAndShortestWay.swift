//
//  findBestWayAndShortestWay.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/24.
//  Copyright © 2016年 ITPanda. All rights reserved.
//  北门 狮子山 仙云石 一线天 飞流瀑 仙武湖 九曲桥 观云台 花卉园 红叶亭 朝日峰 碧水亭
/*
 求两个景点间的最短路径和最短距离。
 */

import Foundation

let places:[String] = ["北门",	"狮子山","仙云石","一线天","飞流瀑","仙武湖","九曲桥","观云台","花卉园","红叶亭","朝日峰","碧水亭"]

public func findBestWayAndShortestWay (graph:inout Graph) {
    print("请输入要查询的两个距离的两个景点名称（空格隔开）")
    let places = getUserInput()
    let startPlace:String = places.first!
    let endPlaces:String = places.last!
    
    if !places.contains(startPlace) || !places.contains(endPlaces) {
        print("输入地址有误！")
        return
    }
    
    let dijkstra:DijkstraTofindShortestWay = DijkstraTofindShortestWay(graph: &graph, startPoint: startPlace)
    dijkstra.createDistanceDict()
    print(dijkstra.getShortesetDistanceTo(destinPoint: endPlaces))
    
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

class DijkstraTofindShortestWay: NSObject {
    
    var graph:Graph?
    var startPoint:String?
    var distToOtherPointDict:Dictionary<String, Int>
    var currentPoint:ArcNode?
    var path:[String] = []

    //不另外设计为结点设置一个bool值，直接利用之前深度遍历的时候设置的 isVisited:Bool 属性作为标记
    init(graph:inout Graph, startPoint:String) {
        self.graph = graph
        self.startPoint = startPoint
        self.distToOtherPointDict = Dictionary<String, Int>()
    }
    
    public func createDistanceDict() {
        
        //初始化
        resetAceNodes(graph: &self.graph!)
        for vertex:ArcNode in (self.graph?.vertexArr)! {
            self.distToOtherPointDict[vertex.name] = 32676
        }
        
        let startVertex:ArcNode = (self.graph?.getArcNode(vertexName: self.startPoint!))!
        startVertex.visited = true
        self.distToOtherPointDict[startPoint!] = 0
        
        currentPoint = self.graph?.getArcNode(vertexName: self.startPoint!)

        for i in 0 ..< (self.graph?.vertexArr.count)! {
            
            let sortedValueArr = getSortedValueArr()
            path.append((currentPoint?.name)!)
            //查找对应在邻接结点是哪个
            let miniDistance = sortedValueArr[i]
            currentPoint = findFixPoint(miniDistance: miniDistance)
            //遍历周围的结点
            for connectedEdge:Edge in (currentPoint?.connectedEdgeArr)! {
                let endVertex:ArcNode = (self.graph?.getArcNode(vertexName: connectedEdge.endPoint.name))!
                if endVertex.visited {
                    //当为真，证明已经访问过，进行松弛操作
                    let fomerPointWeight:Int = self.distToOtherPointDict[endVertex.name]!
                    if miniDistance + connectedEdge.weight < fomerPointWeight {
                        //更新权值
                    self.distToOtherPointDict[endVertex.name] = miniDistance + connectedEdge.weight
                    }
                } else {
                    self.distToOtherPointDict[endVertex.name] = connectedEdge.weight + miniDistance
                    endVertex.visited = true
                }
            }
        }
        output(path: &path)
    }
    
    
    public func getShortesetDistanceTo(destinPoint:String) -> Int {
        return self.distToOtherPointDict[destinPoint]!
    }
    func findFixPoint(miniDistance:Int) -> ArcNode {
        var point:ArcNode?
        for (key, value) in self.distToOtherPointDict {
            if value == miniDistance {
                point = (self.graph?.getArcNode(vertexName: key))!
                break
            }
        }
        return point!
    }
    func getSortedValueArr() -> [Int] {
        //找出此时字典里最小的最近距离
        let valueArr = self.distToOtherPointDict.values
        let sortedValueArr = valueArr.sorted()
        return sortedValueArr
    }
    
    func hasPathTo(endPoint:String) -> Bool {
        if self.distToOtherPointDict[endPoint] != 32676 {
            return true
        } else {
        return false
        }
    }
    func resetAceNodes(graph:inout Graph) {
        for vertex:ArcNode in graph.vertexArr {
            vertex.visited = false
        }
    }
    func output(path: inout [String]) {
        path.removeFirst()
        for str in path {
            print("\(str)-->",terminator:"")
        }
        print(path.first!)
    }

}

