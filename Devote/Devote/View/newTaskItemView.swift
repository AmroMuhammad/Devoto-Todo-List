//
//  newTaskItemView.swift
//  Devote
//
//  Created by Amr Muhammad on 11/03/2023.
//

import SwiftUI

struct newTaskItemView: View {
     
    @State private var textFieldString:String = ""
    @Binding var isShowing:Bool
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false

    
    private var isButtonDisabled:Bool {
        return textFieldString.isEmpty
    }
    @Environment(\.managedObjectContext) private var viewContext
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = textFieldString
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
     
    var body: some View {
        
        VStack{
            Spacer()
            
            VStack(spacing: 16){
                TextField("New Task", text: $textFieldString)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: ".mp3")
                    textFieldString = ""
                    hideKeyboard()
                    isShowing = false
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: ".mp3")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(
                    isButtonDisabled ? Color.blue : Color.pink
                )
                .cornerRadius(10)
                .disabled(isButtonDisabled)
                
            }//: Vstack
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }//: Vstack
        .padding()
    }
}

struct newTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        newTaskItemView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
