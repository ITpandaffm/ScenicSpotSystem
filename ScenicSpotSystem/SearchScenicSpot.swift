//
//  FindAndSort.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
//6、查找排序
/*
 可以根据用户输入的关键字进行景点的查找，关键字可以在景点名称也可以在景点介绍中。
 查找成功则返回景点的相关简介，如果查找不成功请给予正确提示。
 */
import Foundation

public func SearchScenicSpot(graph: Graph) {
    print("请输入要查找的景点信息（景点名称或简介包含的关键字")
    let info = getUserInput()
    let userInPut:String = info.first!
    
    let search:Serach = Serach(userInput: userInPut, graph: graph)
    search.startSearch()
    
}

public class Serach : NSObject {
    let keyWord:String?
    let grapah:Graph
    var resultPointNams:[String] = []
    var vertexDict:Dictionary<String, String>
    
    init(userInput:String, graph:Graph) {
        self.keyWord = userInput
        self.grapah = graph
        self.vertexDict = Dictionary()
    }
    
    public func startSearch() {
        dictInit()
        searchInName()
        searchInIntroduction()
        outputResults()
    }
    func dictInit() {
        for vertex:ArcNode in self.grapah.vertexArr {
            self.vertexDict[vertex.name] = vertex.introduction
        }
    }
    
    func searchInName() {
        for key in self.vertexDict.keys {
            if key == self.keyWord {
                self.resultPointNams.append(key)
            }
        }
    }
    func searchInIntroduction() {
        for (key, value) in self.vertexDict {
            if value.contains(self.keyWord!) {
                self.resultPointNams.append(key)
            }
        }
    }
    
    func outputResults() {
        if self.resultPointNams.count != 0 {
            for str in self.resultPointNams {
                let suitablePoint:ArcNode = self.grapah.getArcNode(vertexName: str)!
                print(suitablePoint.name)
                print(suitablePoint.introduction)
                print(suitablePoint.popularity)
                print("休息区：\(suitablePoint.isHaveRestArea)")
                print("厕所：\(suitablePoint.isHaveWC)")
            }
        } else {
            print("没有找到符合的结果")
        }
    }
    
}

