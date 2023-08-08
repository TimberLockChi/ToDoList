//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")//自定义的颜色
    
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                Text("There are no items")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom,20)
                NavigationLink(destination: AddView()) {
                    Text("Add Something")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background( animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)//触发大小呼吸变化
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.7) :  Color.accentColor.opacity(0.7),
                    radius: animate ? 10 : 5)
                .scaleEffect(animate ? 1.1 : 1.0)//缩放效果
                .offset(y:animate ? -7 : 0)
            }
            .frame(maxWidth:400)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    
    func addAnimation(){
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
            withAnimation(
                //定制动画样式
                Animation.easeInOut(duration: 2.0)
                    .repeatForever()//animate取值会无限进行取反
            ){
                //表示为去反
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
        
    }
}
