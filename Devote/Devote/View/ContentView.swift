//
//  ContentView.swift
//  Devote
//
//  Created by Amr Muhammad on 09/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showNewTaskItem:Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack{
                    
                    HStack(alignment: .center) {
                        Text("DEVOTE")
                            .font(.system(.largeTitle,design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 70,minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        Button {
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: ".mp3")
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24,height: 24)
                                .font(.system(.title,design: .rounded))

                        }


                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    
                    Button {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: ".mp3") 
                    } label: {
                            Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))

                            Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .foregroundColor(.white)
                    .background(
                        backgroundGradient
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 25), radius: 8,x: 0.0, y: 4.0)
 
                    
                    List {
                        ForEach(items) { item in
                            ListItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//: List
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(radius: 12)
                    .padding(.vertical,0)
                    .frame(maxWidth: 640)
                    
                } //: VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0.0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                if(showNewTaskItem){
                    BlankView(backgroundColor: isDarkMode ? .black : .gray
                              , backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                 showNewTaskItem = false
                            }
                        }
                    newTaskItemView(isShowing: $showNewTaskItem)
                }
            } //: Zstack
            .background(
                backgroundImageView()
                    .offset(x: showNewTaskItem ? 90 : 20)
                    .blur(radius: showNewTaskItem ? 8.0 : 0.0, opaque: false)
                    .animation(.easeOut)

            )
            .background(backgroundGradient.ignoresSafeArea(.all))
        }//: NavigationView
        .navigationViewStyle(.stack)
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
