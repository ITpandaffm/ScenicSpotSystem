//
//  Graph.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation

let MAX_WEIGHT:Int = 32676
//
////枚举类型景区的欢迎度
//public enum ePopularity:Int {
//    case 五星
//    case 四星
//    case 三星
//    case 二星
//    case 一星
//}

public class ArcNode {
    var name:String = "" //景点名称
    var introduction:String = ""  //景点简介
    var popularity:String = "AAAAA旅游景区" //景点欢迎度
    var isHaveRestArea:String = "有"  //是否有休息区
    var isHaveWC:String = "有"  //是否公厕
    
    //因为不是仅仅有一条边与结点相连，，
//    var next:ArcNode?
//    var pre:ArcNode?
    
    //与该顶点相连的所有边
    var connectedEdgeArr:[Edge] = []
    
    
    init(name:String, introduction:String, popularity:String, haveRestArea:String, haveWC:String) {
        self.name = name
        self.introduction = introduction
        self.popularity = popularity
        self.isHaveRestArea = haveRestArea
        self.isHaveWC = haveWC
        
//        self.next = nil
//        self.pre = nil
    }
    
    init(name:String) {
        self.name = name
        self.introduction = "\(name)真是个好地方呀风景如画啦啦啦"
        self.popularity = "AAAA旅游景区"
        self.isHaveRestArea = "有"
        self.isHaveWC = "有"
        
//        self.next = nil
//        self.pre = nil
    }
    
}

public class Edge {
    var startPoint:ArcNode
    var endPoint:ArcNode
    var weight:Int = MAX_WEIGHT //权重
    
    init(startVertex:ArcNode, endVertex:ArcNode, edgeWeight:Int) {
        self.startPoint = startVertex
        self.endPoint = endVertex
        self.weight = edgeWeight
    }
}

public class Graph {
    
    var numberOfVetex:Int = 0
    var numberOfEdge:Int = 0
    var vertexArr:[ArcNode]
    var edgeArr:[Edge]
    var isDirected:Bool = false
    
    var maxVertexNum:Int
    var maxEdgeNum:Int
    

    //建立空图；
    init() {
        vertexArr = []
        edgeArr = []
        self.maxEdgeNum = 0
        self.maxVertexNum = 0
    }
    init(maxVertexNum:Int, maxEdgeNum:Int) {
        self.maxVertexNum = maxVertexNum
        self.maxEdgeNum = maxEdgeNum
        vertexArr = []
        edgeArr = []
    }

    //插入一顶点vertex，顶点暂时没有边
    public func insertArcNode(vertex:ArcNode) ->Bool {
        if self.vertexArr.count >= self.maxVertexNum {
            print("已达到最大顶点值！插入顶点失败！\n")
            return false
        } else if (self.getArcNode(vertexName: vertex.name) != nil) {
            print("该节点已经存在！")
            return false
        }
        self.numberOfVetex += 1
        self.vertexArr.append(vertex)
        return true
    }
    //插入一条边 
    public func insertEdge(vertex: ArcNode, anotherVertex: ArcNode, weight:Int) ->Bool {
        if self.edgeArr.count >= self.maxEdgeNum {
            print("已达最大边界数，插入边失败")
            return false
        } else if vertex.name == anotherVertex.name {  //注意此程序不考虑自环边
            print("不考虑自环边！插入边失败")
            return false
        }

        for tempEdge in self.edgeArr {
            if (tempEdge.startPoint.name == vertex.name &&
                tempEdge.endPoint.name == anotherVertex.name) ||
                (tempEdge.endPoint.name == vertex.name &&
                tempEdge.startPoint.name == anotherVertex.name) {
                print("该边已经存在！")
                return false
            }
        }
        
        
        /*
         这里切不可以直接修改传进来的点的信息，一来 不是引用传递 ，改了对外部也没用
         除非用inout关键字修饰
         但是就算修改了，改的也只是在外部声明的这个结点，对内部数据没任何影响
         正确的姿势应该是从self.vertexArr里面获取到对应点的点来修改才对
         */
//        vertex.next = anotherVertex
//        anotherVertex.pre = vertex
        let vertex1 = self.getArcNode(vertexName: vertex.name)
        let vertex2 = self.getArcNode(vertexName: anotherVertex.name)
//        vertex1?.next = vertex2
//        vertex2?.pre = vertex1
        
        let newEdge = Edge(startVertex: vertex1!, endVertex: vertex2!, edgeWeight: weight)
        vertex1?.connectedEdgeArr.append(newEdge)
        
        let reverseEdge = Edge(startVertex: vertex2!, endVertex: vertex1!, edgeWeight: weight)
        vertex2?.connectedEdgeArr.append(reverseEdge)
        
        self.edgeArr.append(newEdge)
        self.numberOfEdge += 1
        return true
    }
    //判断图是否为空
    func graphIsEmpty() -> Bool {
        if self.numberOfEdge == 0 {
            return true
        } else {
            return false
        }
    }
    //判断图满
    func graphFull() -> Bool {
        if (self.numberOfVetex == self.maxVertexNum || self.numberOfEdge == self.maxVertexNum * (self.maxVertexNum - 1)/2)
        {
            return true
        } else {
            return false
        }
    }
    //返回当前顶点数
    public func getNumberOfVetex() -> Int {
        return self.numberOfVetex
    }
    //返回当前边数
    public func getNumberOfEdge() -> Int {
        return self.numberOfEdge
    }
    //获取某个顶点 不合理则返回0
    public func getArcNode(vertexName:String) -> ArcNode? {
        for tempVertex in self.vertexArr {
            if vertexName == tempVertex.name {
                return tempVertex
            }
        }
        return nil
    }
    //获取某条边上的权值
    public func getWeight(vertexName:String, anotherName:String) -> Int {
        for tempEdge in self.edgeArr {
            if vertexName == anotherName {
                return 0
            } else if ((tempEdge.startPoint.name == vertexName &&
                tempEdge.endPoint.name == anotherName) || (tempEdge.endPoint.name == vertexName &&
                tempEdge.startPoint.name == anotherName))
            {
                return tempEdge.weight
            }
        }
        return MAX_WEIGHT
    }
    //
    
}
