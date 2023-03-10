//
//  Constants.swift
//  Devote
//
//  Created by Amr Muhammad on 10/03/2023.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
