//
//  backgroundImageView.swift
//  Devote
//
//  Created by Amr Muhammad on 10/03/2023.
//

import SwiftUI

struct backgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct backgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundImageView()
    }
}
