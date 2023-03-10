//
//  ContentView.swift
//  Devote
//
//  Created by Amr Muhammad on 09/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var textFieldString:String = ""
    
    private var isButtonDisabled:Bool {
        return textFieldString.isEmpty
    }
    @Environment(\.managedObjectContext) private var viewContext
    
    

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack{
                VStack(spacing: 16){
                    TextField("New Task", text: $textFieldString)
                        .padding()
                        .background(
                            Color(UIColor.systemGray6)
                        )
                        .cornerRadius(10)
                    
                    
                    Button(action: {
                        addItem()
                        textFieldString = ""
                        hideKeyboard() 
                    }, label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    })
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(
                        isButtonDisabled ? Color.gray : Color.pink
                    )
                    .cornerRadius(10)
                    .disabled(isButtonDisabled)

                }
                .padding()
                

                
                List {
                    ForEach(items) { item in
                            ListItemView(task: item.task ?? "N/A", date: item.timestamp ?? Date())
                    }
                    .onDelete(perform: deleteItems)
                }
            } //: VStack
            .navigationBarTitle("Daily Tasks",displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
