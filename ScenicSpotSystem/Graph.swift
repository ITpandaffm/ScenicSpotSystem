//
//  Graph.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation

let MAX_VERTEX:Int = 32676
let MAX_WEIGHT:Int = 30

//枚举类型景区的欢迎度
public enum ePopularity:Int {
    case 五星
    case 四星
    case 三星
    case 二星
    case 一星
}


public class ArcNode {
    var name:String = "" //景点名称
    var introduction:String = ""  //景点简介
    var popularity:ePopularity = ePopularity.五星  //景点欢迎度
    var isHaveRestArea:Bool = true  //是否有休息区
    var isHaveWC:Bool = true  //是否公厕
    
    var next:ArcNode?
    var pre:ArcNode?
    
    
    init(name:String, introduction:String, popularity:ePopularity, haveRestArea:Bool, haveWC:Bool) {
        self.name = name
        self.introduction = introduction
        self.popularity = popularity
        self.isHaveRestArea = haveRestArea
        self.isHaveWC = haveWC
        
        self.next = nil
        self.pre = nil
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
    
    var numberOfVetex:Int
    var numberOfEdge:Int
    var vertexArr:[ArcNode]
    var edgeArr:[Edge]
    var isDirected:Bool = false
    
    //建立空图；
    init() {
        self.numberOfVetex = 0
        self.numberOfEdge = 0
        vertexArr = []
        edgeArr = []
    }
    init(numVetex:Int, numEdge:Int) {
        self.numberOfVetex = numVetex
        self.numberOfEdge = numEdge
        vertexArr = []
        edgeArr = []
    }
    
    //插入一顶点vertex，顶点暂时没有边
    public func insertArcNode(vertex:ArcNode) ->Bool {
        if self.vertexArr.count >= MAX_VERTEX {
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
    public func insertEdge(vertex:ArcNode, anotherVertex:ArcNode, weight:Int) ->Bool {
        let edge = Edge(startVertex: vertex, endVertex: anotherVertex, edgeWeight: weight)
        
        for tempEdge in self.edgeArr {
            if (tempEdge.startPoint.name == vertex.name &&
                tempEdge.endPoint.name == anotherVertex.name) ||
                (tempEdge.endPoint.name == vertex.name &&
                tempEdge.startPoint.name == anotherVertex.name) {
                print("该边已经存在！")
                return false
            }
        }
        self.numberOfEdge += 1
        vertex.next = anotherVertex
        anotherVertex.pre = vertex
        self.edgeArr.append(edge)
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
        if (self.numberOfVetex == MAX_VERTEX || self.numberOfEdge == MAX_VERTEX * (MAX_VERTEX - 1)/2)
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
    public func getWeight(vetexName:String, anotherName:String) -> Int {
        for tempEdge in self.edgeArr {
            if tempEdge.startPoint.name == vetexName &&
                tempEdge.endPoint.name == vetexName
            {
                return tempEdge.weight
            }
        }
        print("这条边不存在！")
        return MAX_WEIGHT
    }
    //
    
}
