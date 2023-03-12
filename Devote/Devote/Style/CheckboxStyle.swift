//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Amr Muhammad on 11/03/2023.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? Color.pink : Color.primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    if configuration.isOn{
                        playSound(sound: "sound-rise", type: ".mp3")
                    }else{
                        playSound(sound: "sound-tap", type: ".mp3")
                    }
                }
            
            configuration.label

        }//: HStack
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("PlaceHolder Label",isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
