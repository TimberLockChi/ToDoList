//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 */

class ListViewModel:ObservableObject{
    
    @Published var items : [ItemModel] = []{
        //在每次对items进行变更的时候，都会执行这个代码块
        didSet {
            saveItems()
        }
    }
    
    
    
    let itemsKey:String="item_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
//        let newItems : [ItemModel] = [
//            ItemModel(title: "This is the first title", isCompleted: true),
//            ItemModel(title: "This is the #2 title", isCompleted: false),
//            ItemModel(title: "This is the #3 title",
//                isCompleted: true),
//            ItemModel(title:  "This is the #4 title", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)//批量拷贝
        //确认 用户存储的数据一定存在
        //确认 数据可以被解析成ItemModel
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            //因为需要解析成一个数组的形式，所以解析类型部分要设置为[ItemModel]
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {return}
        
        self.items = savedItems
    }
    //删除
    func deleteItem(indexSet:IndexSet){
        items.remove(atOffsets: indexSet)
    }
    //移动
    func moveItem(from:IndexSet,to:Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    //添加
    func addItem(title:String){
        let newItem = ItemModel(title:title,isCompleted: false)
        items.append(newItem)
    }
    //修改Item
    func updateItem(item:ItemModel){
        //$0相当于所有存在的item
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index]=item.updateCompletion()
        }
    }
    
    //持久化数据
    func saveItems(){
        //尝试将items解析成JSON
        if let encodedData = try? JSONEncoder().encode(items){
            //在类中，推荐使用UserDefaults而不是AppStorage进行持久化
            //AppStorage常被用在View中
            UserDefaults.standard.set(encodedData, forKey:itemsKey)
        }
    }
}
