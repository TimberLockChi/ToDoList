//
//  AddView.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel:ListViewModel
    
    @State var alertOpacity:Double=0
    @State var textFieldText:String=""
    //ColorLiteral写法在IOS14中不生效，因此可以采用此种写法，变量类型是CGColor
    @State var textFieldBackgroundColor:CGColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) //CGColor的类型
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,spacing: 3){
                TextField("Type something here...",text:$textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))//可以随着黑暗模式变化
                    .cornerRadius(10)
                Text("输入长度不少于三个字符")
                    .font(.system(size: 10,weight: .semibold,design: .monospaced))
                    .padding(.leading,5)
                    .foregroundColor(.red)
                    .opacity(alertOpacity)
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

            }
            .padding(14)
        }
        .navigationTitle("Add an Item")
    }
    
    func saveButtonPressed(){
        if textIsAppropriate(){
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func textIsAppropriate()->Bool{
        if textFieldText.count<3{
            alertOpacity = 1
            return false
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        //同时预览light模式和dark模式
        Group{
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
            
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
        }
    }
}
