//
//  Sort.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation

public func SortScenicSpot(graph: Graph) {
    
    print("请输入要进行的排序方式\n1.冒泡排序 2.快速排序 3.插入排序")
    let sinInput = FileHandle.standardInput
    let cxData = NSString(data: sinInput.availableData, encoding: String.Encoding.utf8.rawValue)
    let sortWay:Int = Int(cxData!.intValue)
    
    let sortSpot:Sort = Sort(graph: graph)
    
    switch sortWay {
    case 1:
        sortSpot.sortPopularityByBubble()
    case 2:
        sortSpot.quickSort()
    case 3:
        sortSpot.selectSort()
    default:
        print("输入有误")
    }
}


public class Sort : NSObject {
    
    let graph:Graph
    var nodeArr:[ArcNode] = []
    
    init(graph:Graph) {
        self.graph = graph
        self.nodeArr = graph.vertexArr
    }
    
    func sortPopularityByBubble() {
        
        for i in 0 ... self.nodeArr.count-1 {       //n个数排序，只要进行n-1轮操作
            for j in 0 ..< self.nodeArr.count-i-1 {
                if self.nodeArr[j].popularity > self.nodeArr[j+1].popularity {
                    let temp = self.nodeArr[j]
                    self.nodeArr[j] = self.nodeArr[j+1]
                    self.nodeArr[j+1] = temp
                }
            }
        }
        ouputResult(sortWay: "冒泡")
    }
    
    func quickSort() {
        print("暂未开放...")
    }
    
    func selectSort() {
        for i in 0 ..< self.nodeArr.count {
            for j in i ..< self.nodeArr.count {
                if self.nodeArr[j].popularity < self.nodeArr[i].popularity {
                    let temp = self.nodeArr[j]
                    self.nodeArr[j] = self.nodeArr[i]
                    self.nodeArr[i] = temp
                }
            }
        }
        ouputResult(sortWay: "选择")
    }
    
    func ouputResult(sortWay:String) {
        print("\(sortWay)排序结束，排序后：")
        for vertex in self.nodeArr {
            print("景点：\(vertex.name), 人气:\(vertex.popularity), 简介：\(vertex.introduction)")
        }
    }
    
}


