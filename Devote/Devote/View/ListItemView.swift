//
//  ListItemView.swift
//  Devote
//
//  Created by Amr Muhammad on 10/03/2023.
//

import SwiftUI

struct ListItemView: View {
    let task:String
    let date:Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(task)
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Item at \(date, formatter: itemFormatter)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(task: "new asssist", date: Date())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
