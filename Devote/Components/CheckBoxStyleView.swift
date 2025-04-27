//
//  CheckBoxStyleView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/26/25.
//

import SwiftUI

struct CheckBoxStyleView: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .onTapGesture{
                    configuration.isOn.toggle()
                    if configuration.isOn{
                        playSound(sound: "sound-rise", type: "mp3")
                        feedback.notificationOccurred(.success)
                        
                    }
                    else{
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }//HStack
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Toggle("Placeholder label",isOn: .constant(false))
        .toggleStyle(CheckBoxStyleView())
        .padding()
        .background(Color.blue)
}
