//
//  ListItemView.swift
//  Devote
//
//  Created by Amr Muhammad on 10/03/2023.
//

import SwiftUI

struct ListItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item:Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2,design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical,12)
                .animation(.default)
        }
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

//struct ListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItemView(task: "new asssist", date: Date())
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
