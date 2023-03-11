//
//  Constants.swift
//  Devote
//
//  Created by Amr Muhammad on 10/03/2023.
//

import SwiftUI 

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

var backgroundGradient: LinearGradient{
    return LinearGradient(gradient: Gradient(colors:[Color.pink,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
