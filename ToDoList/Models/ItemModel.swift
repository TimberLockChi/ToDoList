//
//  ItemModel.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import Foundation

//Immutable Struct
//Codable表示ItemModel可以被解码和编码，可以将其包装为json
struct ItemModel:Identifiable,Codable{
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id:String = UUID().uuidString, title:String, isCompleted:Bool){
        self.id = id//参数给一个默认值，如果没有的话直接生成一个，否则赋现有值
        self.title = title
        self.isCompleted = isCompleted
    }
    
    //只能通过此方法对数据对象进行变更
    func updateCompletion() -> ItemModel{
        //取消勾选
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}
