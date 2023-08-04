//
//  ListView.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel:ListViewModel
    
    var body: some View {
        
        ZStack{
            //每次发生变更都会重新绘制界面
            if listViewModel.items.isEmpty{
                //展示界面时，渐入
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else{
                List{
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)//触发删除操作
                    .onMove(perform: listViewModel.moveItem)//触发移动操作
                }
            }
        }
        .navigationTitle("Todo List📋")
        .navigationBarItems(
            leading: EditButton()
                .font(.headline)
                .foregroundColor(.purple),
            trailing:
                //定制样式
                NavigationLink(destination: {
                    AddView()
                }, label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.purple)
                })
            )
    }
    
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())//用来预览，需要添加测试数据
    }
}
